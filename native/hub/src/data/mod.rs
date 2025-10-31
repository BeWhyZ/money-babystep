use std::sync::Arc;

use crate::Result;
use crate::biz::{Bill, BillRepo, TagRepo};

#[derive(Debug, Clone)]
pub struct Infra {}

impl Infra {
    pub fn new() -> Self {
        Self {}
    }
}

#[derive(Debug, Clone)]
pub struct BillRepoImpl {
    infra: Arc<Infra>,
}

impl BillRepoImpl {
    pub fn new(infra: Arc<Infra>) -> Self {
        Self { infra }
    }
}

impl BillRepo for BillRepoImpl {
    async fn create(&self, bill: &mut crate::biz::Bill) -> Result<()> {
        // Here would be the actual implementation to create a bill in the database.
        Ok(())
    }

    async fn batch_create(&self, bills: &mut [crate::biz::Bill]) -> Result<()> {
        // Here would be the actual implementation to batch create bills in the database.
        Ok(())
    }

    async fn get_latest(&self, user_id: u64, book_id: u64) -> Result<Vec<Bill>> {
        // Here would be the actual implementation to get the latest bills from the database.
        Ok(vec![])
    }
}

#[derive(Debug, Clone)]
pub struct TagRepoImpl {
    infra: Arc<Infra>,
}

impl TagRepoImpl {
    pub fn new(infra: Arc<Infra>) -> Self {
        Self { infra }
    }
}

impl TagRepo for TagRepoImpl {
    async fn create(&self, tag: &mut crate::biz::TagInfo) -> Result<()> {
        // Here would be the actual implementation to create a tag in the database.
        Ok(())
    }

    async fn batch_create(&self, tags: &mut [crate::biz::TagInfo]) -> Result<()> {
        // Here would be the actual implementation to batch create tags in the database.
        Ok(())
    }
}
