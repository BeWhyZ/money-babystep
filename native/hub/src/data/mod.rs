mod model;
pub mod repo;

pub use repo::*;

use std::sync::Arc;

use crate::core::IDGenerator;
use sqlx::sqlite::SqlitePool;
use tracing::{error, info};

pub async fn init_db_engine(db_addr: String) -> SqlitePool {
    let pool = match SqlitePool::connect(&db_addr).await {
        Ok(p) => p,
        Err(e) => {
            error!("Failed to connect to the database: {}", e);
            panic!("Database connection error");
        }
    };

    info!("Connected to the database at {}", db_addr);

    // Here you can run migrations or any initialization SQL if needed.
    match sqlx::migrate!("./migrations").run(&pool).await {
        Ok(_) => info!("Database migrations applied successfully"),
        Err(e) => {
            error!("Failed to apply database migrations: {}", e);
            panic!("Database migration error");
        }
    };

    pool
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
