use chrono::Utc;
use tracing::info;

use super::Infra;
use crate::Result;
use crate::biz::{Bill, BillRepo, TagRepo};

#[derive(Debug, Clone)]
pub struct BillRepoImpl {
    infra: Infra,
}

impl BillRepoImpl {
    pub fn new(infra: Infra) -> Self {
        Self { infra }
    }
}

impl BillRepo for BillRepoImpl {
    async fn create(&self, bill: &mut crate::biz::Bill) -> Result<()> {
        // 生成当前日期字符串，格式: YYYY-MM-DD
        let date = Utc::now().format("%Y-%m-%d").to_string();
        bill.transaction_id = self.infra.id_generator.next_id().unwrap();

        // 执行插入操作
        let result = sqlx::query(
            r#"
            INSERT INTO bill (user_id, book_id, amount, tag_id_lv1, tag_id_lv2, date, create_at_sec, update_at_sec)
            VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)
            "#,
        )
        .bind(bill.user_id as i64)
        .bind(bill.book_id as i64)
        .bind(bill.amount)
        .bind(bill.tag_id_lv1 as i64)
        .bind(bill.tag_id_lv2 as i64)
        .bind(&date)
        .bind(bill.create_at_sec)
        .bind(bill.update_at_sec)
        .execute(&self.infra.db)
        .await?;

        // 获取插入后的自增 id
        bill.id = result.last_insert_rowid() as u64;

        info!("Created bill with id: {}", bill.id);
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
    infra: Infra,
}

impl TagRepoImpl {
    pub fn new(infra: Infra) -> Self {
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
