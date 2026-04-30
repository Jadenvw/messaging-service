CREATE TABLE IF NOT EXISTS businesses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    google_review_url TEXT NOT NULL,
    reply_to_email TEXT NOT NULL,
    tone TEXT DEFAULT 'warm and professional',
    delay_hours INTEGER DEFAULT 4,
    followup_enabled INTEGER DEFAULT 0,
    followup_delay_days INTEGER DEFAULT 5
);

CREATE TABLE IF NOT EXISTS clients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    business_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    do_not_contact INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(id)
);

CREATE TABLE IF NOT EXISTS service_events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    service_type TEXT NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    email_sent_at TIMESTAMP,
    followup_sent_at TIMESTAMP,
    email_status TEXT DEFAULT 'pending',
    email_body TEXT,
    followup_body TEXT,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);