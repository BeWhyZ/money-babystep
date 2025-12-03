mod model;
pub mod repo;

pub use repo::*;

use std::sync::Arc;

use crate::Result;
use crate::core::IDGenerator;
use sea_orm::{ConnectOptions, Database, DatabaseConnection, DbErr};
use sqlx::{Connection, SqliteConnection, SqlitePool, sqlite::SqliteConnectOptions};
use std::str::FromStr;
use std::time::Duration;
use tracing::{error, info, log};

pub async fn init_db_engine(db_addr: String) -> DatabaseConnection {
    let mut opt = ConnectOptions::new(db_addr.clone());
    opt.max_connections(100)
        .min_connections(5)
        .connect_timeout(Duration::from_secs(8))
        .acquire_timeout(Duration::from_secs(8))
        .idle_timeout(Duration::from_secs(8))
        .max_lifetime(Duration::from_secs(8))
        // .sqlx_logging(false) // disable SQLx logging
        .sqlx_logging_level(log::LevelFilter::Info);
    let db = Database::connect(opt).await.unwrap();

    assert!(db.ping().await.is_ok());
    db.clone().close().await;
    assert!(matches!(db.ping().await, Err(DbErr::ConnectionAcquire(_))));
    info!("Connected to the database at {}", db_addr);

    // Run migrations using sqlx
    if let Err(e) = run_migrations_by_sqlx(db_addr.clone()).await {
        error!("Failed to apply database migrations: {}", e);
        panic!("Database migration error: {}", e);
    }

    db
}

async fn run_migrations_by_sqlx(addr: String) -> Result<()> {
    // Parse the database URL to extract the file path
    // Format: sqlite://money_babystep.db.sqlite?mode=rwc
    let db_path = addr
        .strip_prefix("sqlite://")
        .and_then(|s| s.split('?').next())
        .ok_or_else(|| anyhow::anyhow!("Invalid database URL format"))?;

    // Create SQLite connection options
    let options = SqliteConnectOptions::from_str(&format!("sqlite://{}?mode=rwc", db_path))?
        .create_if_missing(true);

    // Connect to the database
    let mut conn: SqliteConnection = SqliteConnection::connect_with(&options).await?;

    // Run migrations
    sqlx::migrate!("./migrations")
        .run(&mut conn)
        .await
        .map_err(|e| {
            error!("Failed to apply database migrations: {}", e);
            anyhow::anyhow!("Database migration error: {}", e)
        })?;

    info!("Database migrations applied successfully");
    conn.close().await?;
    Ok(())
}

#[derive(Debug, Clone)]
pub struct Infra {
    pub db: SqlitePool,
    pub id_generator: Arc<IDGenerator>,
}

impl Infra {
    pub fn new(db: SqlitePool, id_generator: Arc<IDGenerator>) -> Self {
        Self { db, id_generator }
    }
}
