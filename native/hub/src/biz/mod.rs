use std::sync::Arc;

use chrono::Utc;
use rinf::SignalPiece;
use serde::{Deserialize, Serialize};

use crate::Result;
// 业务逻辑一个账本相关的业务逻辑
// 用户默认使用的是默认账本, 所有的账本相关的操作, 都是针对默认账本进行的
// 记账则是关联用户id,账本id，以及帐的一个id
#[derive(Debug, Clone)]
pub struct BillBiz<B, T>
where
    B: BillRepo,
    T: TagRepo,
{
    // bill repo
    pub br: Arc<B>,
    // tag repo
    pub tr: Arc<T>,
}

#[derive(Debug, Clone, Serialize, SignalPiece, Deserialize)]
pub struct Bill {
    pub id: u64,
    pub user_id: u64,
    pub book_id: u64,
    pub amount: f64,
    pub tag_id_lv1: u64,
    pub tag_id_lv2: u64,
    pub create_at_sec: i64,
    pub update_at_sec: i64,
}

#[derive(Debug, Clone, Serialize, SignalPiece, Deserialize)]
pub enum TagLevel {
    Lv1,
    Lv2,
}

#[derive(Debug, Clone, Serialize, SignalPiece, Deserialize)]
pub struct TagInfo {
    pub id: u64,
    pub tag_key: String,
    pub level: TagLevel,
    pub parent_id: Option<u64>,
    pub label_en: String,
    pub label_zh: String,
    pub avatar: String,
    pub create_at_sec: i64,
    pub update_at_sec: i64,
}

pub trait BillRepo: Send + Sync + std::fmt::Debug {
    // 创建一笔交易
    fn create(&self, bill: &mut Bill) -> impl std::future::Future<Output = Result<()>> + Send;

    fn batch_create(
        &self,
        bills: &mut [Bill],
    ) -> impl std::future::Future<Output = Result<()>> + Send;

    // 获取用户最新的交易记录
    fn get_latest(
        &self,
        user_id: u64,
        book_id: u64,
    ) -> impl std::future::Future<Output = Result<Vec<Bill>>> + Send;
}

pub trait TagRepo: Send + Sync + std::fmt::Debug {
    fn create(&self, tag: &mut TagInfo) -> impl std::future::Future<Output = Result<()>> + Send;

    fn batch_create(
        &self,
        tags: &mut [TagInfo],
    ) -> impl std::future::Future<Output = Result<()>> + Send;
}

impl<B, T> BillBiz<B, T>
where
    B: BillRepo,
    T: TagRepo,
{
    pub fn new(br: Arc<B>, tr: Arc<T>) -> Self {
        BillBiz { br, tr }
    }

    pub async fn create_bill(
        &self,
        user_id: u64,
        book_id: u64,
        amount: f64,
        tag_id_lv1: u64,
        tag_id_lv2: u64,
    ) -> Result<Bill> {
        let now = Utc::now().timestamp();
        let mut bill = Bill {
            id: 0,
            user_id,
            book_id,
            amount,
            tag_id_lv1,
            tag_id_lv2,
            create_at_sec: now,
            update_at_sec: now,
        };
        self.br.create(&mut bill).await?;
        Ok(bill)
    }
}
