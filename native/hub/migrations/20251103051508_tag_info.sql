-- Add migration script here
CREATE TABLE IF NOT EXISTS tag_info
(
    id          INTEGER PRIMARY KEY NOT NULL,
    name        TEXT NOT NULL,
    parent_id   INTEGER NOT NULL,
    label_en    TEXT NOT NULL,
    label_zh    TEXT NOT NULL,
    avatar      TEXT NOT NULL,
    create_at_sec INTEGER NOT NULL,
    update_at_sec INTEGER NOT NULL
)