-- Add migration script here
CREATE TABLE IF NOT EXISTS bill
(
    id          INTEGER PRIMARY KEY NOT NULL,
    user_id     INTEGER NOT NULL,
    book_id     INTEGER NOT NULL,
    amount      REAL NOT NULL,
    tag_id_lv1  INTEGER NOT NULL,
    tag_id_lv2  INTEGER NOT NULL,
    date       TEXT NOT NULL,
    create_at_sec INTEGER NOT NULL,
    update_at_sec INTEGER NOT NULL
);