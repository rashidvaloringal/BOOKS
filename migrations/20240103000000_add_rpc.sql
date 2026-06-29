-- ================================================================
-- RPC FUNCTIONS
-- ================================================================

-- get_books_updates
CREATE OR REPLACE FUNCTION get_books_updates(
  p_last_sync TIMESTAMPTZ DEFAULT '1970-01-01'
)
RETURNS TABLE(
  id TEXT,
  version INTEGER,
  updated_at TIMESTAMPTZ
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    b.id,
    b.version,
    b.updated_at
  FROM master_catalog b
  WHERE b.updated_at > p_last_sync
  ORDER BY b.updated_at DESC;
END;
$$;

-- get_updated_pages
CREATE OR REPLACE FUNCTION get_updated_pages(
  p_book_id TEXT,
  p_last_sync TIMESTAMPTZ DEFAULT '1970-01-01',
  p_limit INT DEFAULT 500
)
RETURNS TABLE(
  id INT8,
  part_number INT8,
  page_number INT8,
  arabic_text TEXT,
  malayalam_text TEXT,
  english_text TEXT,
  status TEXT,
  updated_at TIMESTAMPTZ
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY EXECUTE format('
    SELECT 
      t."ID" as id,
      t."Part Number" as part_number,
      t."Page Number" as page_number,
      t."Arabic Text" as arabic_text,
      t."Malayalam Text" as malayalam_text,
      t."English Text" as english_text,
      t."Status" as status,
      t.updated_at
    FROM %I t
    WHERE t.updated_at > $1
    ORDER BY t.updated_at
    LIMIT $2
  ', p_book_id || '_contents')
  USING p_last_sync, p_limit;
END;
$$;

-- get_book_pages (existing)
CREATE OR REPLACE FUNCTION get_book_pages(
  p_book_id TEXT,
  p_part_num INT,
  p_page_start INT DEFAULT 1,
  p_limit INT DEFAULT 20
)
RETURNS TABLE(
  id INT8,
  part_number INT8,
  page_number INT8,
  arabic_text TEXT,
  malayalam_text TEXT,
  english_text TEXT,
  status TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY EXECUTE format('
    SELECT 
      t."ID" as id,
      t."Part Number" as part_number,
      t."Page Number" as page_number,
      t."Arabic Text" as arabic_text,
      t."Malayalam Text" as malayalam_text,
      t."English Text" as english_text,
      t."Status" as status
    FROM %I t
    WHERE t."Part Number" = $1
      AND t."Page Number" >= $2
    ORDER BY t."Part Number", t."Page Number", t."ID"
    LIMIT $3
  ', p_book_id || '_contents')
  USING p_part_num, p_page_start, p_limit;
END;
$$;
