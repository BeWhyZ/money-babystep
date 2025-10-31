use std::sync::Arc;

use crate::biz::BillBiz;
use crate::data::{BillRepoImpl, Infra, TagRepoImpl};
use crate::service::BillSvc;

pub fn init_app() -> BillSvc<BillRepoImpl, TagRepoImpl> {
    // data
    let infra = std::sync::Arc::new(Infra::new());
    let tag_repo = std::sync::Arc::new(TagRepoImpl::new(infra.clone()));
    let bill_repo = std::sync::Arc::new(BillRepoImpl::new(infra.clone()));

    // biz
    let biz = Arc::new(BillBiz::new(bill_repo, tag_repo));

    // service
    let svc = BillSvc::new(biz.clone());

    svc
}
