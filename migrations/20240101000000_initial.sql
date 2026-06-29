-- ================================================================
-- INITIAL SCHEMA
-- ================================================================

-- master_catalog
CREATE TABLE IF NOT EXISTS master_catalog (
  id TEXT PRIMARY KEY,
  title_ar TEXT,
  title_ml TEXT,
  author TEXT,
  cover_url TEXT,
  description TEXT,
  parts INTEGER DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE master_catalog DISABLE ROW LEVEL SECURITY;

-- ruh_al_bayan_contents
CREATE TABLE IF NOT EXISTS ruh_al_bayan_contents (
  "ID" INT8 PRIMARY KEY,
  "Part Number" INT8,
  "Page Number" INT8,
  "Arabic Text" TEXT,
  "Malayalam Text" TEXT,
  "English Text" TEXT,
  "Status" TEXT
);

ALTER TABLE ruh_al_bayan_contents DISABLE ROW LEVEL SECURITY;

-- Indexes
CREATE INDEX IF NOT EXISTS idx_ruh_part ON ruh_al_bayan_contents("Part Number");
CREATE INDEX IF NOT EXISTS idx_ruh_page ON ruh_al_bayan_contents("Page Number");
CREATE INDEX IF NOT EXISTS idx_ruh_seek ON ruh_al_bayan_contents("Part Number", "Page Number", "ID");
