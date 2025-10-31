use std::sync::Arc;

use rinf::{DartSignal, RustSignal};
use serde::{Deserialize, Serialize};
use tracing::{error, info};

use crate::api;
use crate::biz::{Bill, BillBiz, BillRepo, TagRepo};

#[derive(Debug, Clone)]
pub struct BillSvc<B, T>
where
    B: BillRepo,
    T: TagRepo,
{
    pub biz: Arc<BillBiz<B, T>>,
}

#[derive(Deserialize, DartSignal, Debug)]
pub struct CreateBillReq {
    pub user_id: u64,
    pub book_id: u64,
    pub amount: f64,
    pub tag_id_lv1: u64,
    pub tag_id_lv2: u64,
}

#[derive(Serialize, RustSignal, Debug)]
pub struct CreateBillResp {
    bill: Bill,
}

impl<B, T> BillSvc<B, T>
where
    B: BillRepo,
    T: TagRepo,
{
    pub fn new(biz: Arc<BillBiz<B, T>>) -> Self {
        Self { biz }
    }

    pub async fn create_bill(&self) {
        let recv = CreateBillReq::get_dart_signal_receiver();
        while let Some(signal_pack) = recv.recv().await {
            let req = signal_pack.message;
            info!("Received CreateBillReq: {:?}", req);

            let res = self
                .biz
                .create_bill(
                    req.user_id,
                    req.book_id,
                    req.amount,
                    req.tag_id_lv1,
                    req.tag_id_lv2,
                )
                .await;
            match res {
                Ok(bill) => {
                    info!("Created bill: {:?}", bill.clone());
                    CreateBillResp { bill: bill }.send_signal_to_dart();
                }
                Err(e) => {
                    error!("Failed to create bill: {:?}", e);
                }
            }
        }
    }
}
