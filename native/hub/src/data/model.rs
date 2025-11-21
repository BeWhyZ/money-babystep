use sqlx::FromRow;

use crate::biz::TransactionType;

#[derive(Debug, Clone, FromRow)]
pub(super) struct Bill {
    pub id: u64,
    pub transaction_id: u64,
    pub transaction_type: TransactionType,
    pub user_id: u64,
    pub book_id: u64,
    pub amount: f64,
    pub note: Option<String>,
    pub tag_id_lv1: u64,
    pub tag_id_lv2: u64,
    pub date: String,
    pub create_at_sec: i64,
    pub update_at_sec: i64,
}

#[derive(Debug, Clone, FromRow)]
pub(super) struct TagInfo {
    pub id: u64,
    pub name: String,
    pub parent_id: Option<u64>,
    pub label_en: String,
    pub label_zh: String,
    pub avatar: String,
    pub create_at_sec: i64,
    pub update_at_sec: i64,
}
