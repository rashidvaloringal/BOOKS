-- ================================================================
-- ADD COLUMNS FOR SYNC
-- ================================================================

-- master_catalog
ALTER TABLE master_catalog
ADD COLUMN IF NOT EXISTS version INTEGER DEFAULT 1;

ALTER TABLE master_catalog
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE master_catalog
ADD COLUMN IF NOT EXISTS estimated_size INTEGER DEFAULT 0;

ALTER TABLE master_catalog
ADD COLUMN IF NOT EXISTS total_pages INTEGER DEFAULT 0;

-- contents tables
ALTER TABLE ruh_al_bayan_contents
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE fathul_mueen_contents
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE ihya_ulumuddin_contents
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE al_kamil_fe_thareeq_contents
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Indexes for updated_at
CREATE INDEX IF NOT EXISTS idx_ruh_updated ON ruh_al_bayan_contents(updated_at);
CREATE INDEX IF NOT EXISTS idx_fathul_updated ON fathul_mueen_contents(updated_at);
CREATE INDEX IF NOT EXISTS idx_ihya_updated ON ihya_ulumuddin_contents(updated_at);
CREATE INDEX IF NOT EXISTS idx_kamil_updated ON al_kamil_fe_thareeq_contents(updated_at);
