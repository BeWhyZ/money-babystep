//! This `hub` crate is the
//! entry point of the Rust logic.

mod actors;
mod api;
mod biz;
mod data;
mod server;
mod service;
mod signals;

use once_cell::sync::OnceCell;
use std::sync::Arc;

use actors::create_actors;
use anyhow::Result as AnyResult;
use rinf::{dart_shutdown, debug_print, write_interface};
use server::init_app;
use tokio::spawn;

use crate::data::{BillRepoImpl, TagRepoImpl};
use crate::service::BillSvc;

pub type Result<T> = AnyResult<T>;
// Uncomment below to target the web.
// use tokio_with_wasm::alias as tokio;

write_interface!();

static APP_SERVER: OnceCell<Arc<BillSvc<BillRepoImpl, TagRepoImpl>>> = OnceCell::new();

// You can go with any async library, not just `tokio`.
#[tokio::main(flavor = "current_thread")]
async fn main() {
    let srv = Arc::new(init_app());
    APP_SERVER
        .set(srv.clone())
        .expect("Failed to set app server");

    // Spawn concurrent tasks.
    // Always use non-blocking async functions like `tokio::fs::File::open`.
    // If you must use blocking code, use `tokio::task::spawn_blocking`
    // or the equivalent provided by your async library.
    spawn(async move {
        srv.create_bill().await;
    });
    spawn(create_actors());
    spawn(signals::demo_ffi_f2r());
    // Keep the main function running until Dart shutdown.
    dart_shutdown().await;
    debug_print!("rust code shutdown");
}
