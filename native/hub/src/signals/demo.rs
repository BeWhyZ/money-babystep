use std::time::Duration;

use rinf::{DartSignal, RustSignal, debug_print};
use serde::{Deserialize, Serialize};
use tokio::time::interval;

#[derive(Deserialize, DartSignal, Debug)]
pub struct DemoRequest {
    pub name: String,
    pub nums: Vec<i32>,
}

#[derive(Serialize, RustSignal, Debug)]
pub struct DemoResponse {
    pub result: f64,
    pub name: String,
    pub msg: String,
}

#[derive(Serialize, RustSignal)]
pub struct DemoFromRust2Dart {
    pub result: f64,
    pub name: String,
    pub msg: String,
}

pub async fn demo_ffi_f2r() {
    let receiver = DemoRequest::get_dart_signal_receiver();
    while let Some(signal_pack) = receiver.recv().await {
        let req = signal_pack.message;
        debug_print!("rust code receive DemoRequest: {:?}", req);
        let avg: f64 = if req.nums.len() > 0 {
            req.nums.iter().sum::<i32>() as f64 / (req.nums.len() as f64)
        } else {
            0.0
        };
        DemoResponse {
            result: avg,
            name: req.name,
            msg: "pong for demo".to_string(),
        }
        .send_signal_to_dart();
    }
}
