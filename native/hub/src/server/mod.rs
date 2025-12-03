use std::sync::Arc;

use crate::biz::BillBiz;
use crate::core::{IDGenerator, IdGeneratorConfig};
use crate::data::{self, BillRepoImpl, Infra, TagRepoImpl};
use crate::service::BillSvc;

pub async fn init_app() -> BillSvc<BillRepoImpl, TagRepoImpl> {
    // data
    let id_generator = Arc::new(IDGenerator::new(IdGeneratorConfig::default()).unwrap());
    let db = data::init_db_engine("sqlite://money_babystep.db.sqlite?mode=rwc".to_string()).await;
    let infra = Infra::new(db, id_generator.clone());
    let tag_repo = std::sync::Arc::new(TagRepoImpl::new(infra.clone()));
    let bill_repo = std::sync::Arc::new(BillRepoImpl::new(infra.clone()));

    // biz
    let biz = Arc::new(BillBiz::new(bill_repo, tag_repo));

    // service
    let svc = BillSvc::new(biz.clone());

    svc
}
