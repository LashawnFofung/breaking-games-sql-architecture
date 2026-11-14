-- 01_exploration.sql — Project 1: first queries and row checks
-- Question:  Did the data load as expected, and how far can each table be trusted?
-- Decision:  Whether the database is safe to build on.
-- Period:    All rows, no filtering.
-- Expected results recorded 2026-11-10; module queries added 2026-11-14. Decision IDs refer to docs/design-decisions.md.
-- Run on a copy, or click Revert Changes after the UPDATE, so data/breaking_games.db stays unchanged (D-13).

-- Row counts (expected: 116, 277, 1579, 4450, 42, 102)
SELECT 'shopify_sales' AS tbl, COUNT(*) AS n FROM shopify_sales
UNION ALL SELECT 'shopify_orders', COUNT(*) FROM shopify_orders
UNION ALL SELECT 'shopify_checkouts', COUNT(*) FROM shopify_checkouts
UNION ALL SELECT 'referrals', COUNT(*) FROM referrals
UNION ALL SELECT 'meta_campaigns', COUNT(*) FROM meta_campaigns
UNION ALL SELECT 'meta_ad_sets', COUNT(*) FROM meta_ad_sets;

-- Checkouts vs checkout rows (expected: 1197 vs 1579)  -- D-12
SELECT COUNT(DISTINCT name) AS checkouts, COUNT(*) AS line_rows
FROM shopify_checkouts;

-- Shipping rows in orders (expected: 92)  -- D-04
SELECT COUNT(*) AS shipping_rows
FROM shopify_orders
WHERE sale_id LIKE '%-S';

-- Meta results by what they measure  -- D-02
SELECT result_indicator,
       COUNT(*)                AS campaigns,
       SUM(results)            AS results,
       ROUND(SUM(spend_usd),2) AS spend
FROM meta_campaigns
GROUP BY result_indicator;

-- Sales arithmetic reconciles (expected: 0 rows)
SELECT product_title
FROM shopify_sales
WHERE ROUND(gross_sales + discounts + returns, 2) <> ROUND(net_sales, 2)
   OR ROUND(net_sales + taxes, 2) <> ROUND(total_sales, 2);

-- Meta spend agrees across campaign and ad set tables (expected: equal)
SELECT (SELECT ROUND(SUM(spend_usd),2) FROM meta_campaigns) AS campaign_spend,
       (SELECT ROUND(SUM(spend_usd),2) FROM meta_ad_sets)   AS ad_set_spend;


-- ============================================================
-- Module: Asking the Database a Question
-- Question:  Which products should Mike reorder before the holiday print deadline?
-- Decision:  Holiday print quantities (PRD Priority 1).
-- Period:    shopify_sales has no date column; period unknown (open question 1).
-- ============================================================

-- See the whole table first (expected: 116 rows, 10 columns)
SELECT * FROM shopify_sales;

-- Just product and revenue
SELECT product_title, total_sales
FROM shopify_sales;

-- Just product and units
SELECT product_title, net_items_sold
FROM shopify_sales;

-- Products that sold more than 50 units (expected: 38 rows)
SELECT product_title, total_sales
FROM shopify_sales
WHERE net_items_sold > 50;

-- Stricter cut: more than 100 units (expected: 14 rows)
SELECT product_title, total_sales
FROM shopify_sales
WHERE net_items_sold > 100;

-- Ranked by revenue (expected #1: Dwellings of Eldervale - LEGENDARY Upgrade Kit, 28190.64)
SELECT product_title, total_sales
FROM shopify_sales
WHERE net_items_sold > 50
ORDER BY total_sales DESC;

-- Ranked by units  -- D-05
-- Expected: free gift-wrap items (Holiday Insert 2025 Gift Tag, Holiday Bow 2025)
-- rank 9th and 10th with 230 units each and $0 revenue.
SELECT product_title, net_items_sold
FROM shopify_sales
WHERE net_items_sold > 50
ORDER BY net_items_sold DESC;

-- Mike's reorder list: top 10 by revenue
SELECT product_title, total_sales
FROM shopify_sales
WHERE net_items_sold > 50
ORDER BY total_sales DESC
LIMIT 10;

-- Check: does the revenue measure change the list?  -- D-01
-- Expected: the same 10 products in the same order; figures about 5% lower (tax removed).
SELECT product_title, net_sales, total_sales
FROM shopify_sales
WHERE net_items_sold > 50
ORDER BY net_sales DESC
LIMIT 10;

-- Check: what does the > 50 filter actually remove?
-- Expected: the top 10 is unchanged without the filter. The highest earner it drops is
-- Dwellings of Eldervale - Exclusive Game Mat (2138.64 on 35 units).
SELECT product_title, total_sales, net_items_sold
FROM shopify_sales
WHERE net_items_sold <= 50
ORDER BY total_sales DESC
LIMIT 5;


-- ============================================================
-- Module: How to Clean Data Before You Trust the Numbers
-- Question:  Do category totals and Meta averages mean what they appear to mean?
-- Decision:  Which cleaning rules to apply before any total reaches Mike or Jess.
-- Period:    All rows.
-- ============================================================

-- Revenue by category (expected: Game 95 / 139340.40 and a separate game 1 / 593.68)  -- D-10
SELECT product_type,
       COUNT(*)                 AS n_products,
       ROUND(SUM(total_sales), 2) AS revenue
FROM shopify_sales
GROUP BY product_type
ORDER BY revenue DESC;

-- Which product is lowercase? (expected: Political Animals, 593.68)
SELECT product_title, product_type, total_sales
FROM shopify_sales
WHERE product_type = 'game';

-- Preview the fix without changing the database
-- (expected: Game 96 / 139934.08; no lowercase row)
SELECT CASE WHEN product_type = 'game' THEN 'Game' ELSE product_type END AS product_type,
       COUNT(*)                   AS n_products,
       ROUND(SUM(total_sales), 2) AS revenue
FROM shopify_sales
GROUP BY 1
ORDER BY revenue DESC;

-- The fix itself (expected: 1 row changed)  -- D-10
-- In DB Browser, click Revert Changes afterward so data/breaking_games.db stays unchanged (D-13).
-- The permanent version of this UPDATE belongs in the Project 2 cleaning script.
UPDATE shopify_sales
SET product_type = 'Game'
WHERE product_type = 'game';

-- Confirm the fix: re-run the category query (expected: Game 96 / 139934.08)
SELECT product_type,
       COUNT(*)                 AS n_products,
       ROUND(SUM(total_sales), 2) AS revenue
FROM shopify_sales
GROUP BY product_type
ORDER BY revenue DESC;

-- Blank vs zero (expected: 28, then 2)
SELECT COUNT(*) AS blank_results FROM meta_campaigns WHERE results IS NULL;
SELECT COUNT(*) AS zero_results  FROM meta_campaigns WHERE results = 0;

-- Average skips blanks (expected: 106991.29)
SELECT AVG(results) AS avg_recorded_only
FROM meta_campaigns;

-- Average with blanks counted as zero (expected: 35663.76)
SELECT AVG(COALESCE(results, 0)) AS avg_blanks_as_zero
FROM meta_campaigns;

-- Totals don't change (expected: 1497878.0 both)
SELECT SUM(results)              AS sum_recorded,
       SUM(COALESCE(results, 0)) AS sum_blanks_as_zero
FROM meta_campaigns;

-- Check: did every blank campaign never run?  -- D-02
-- Expected: 4 blank campaigns spent 22126.16, so a blank is not always "never ran."
SELECT COUNT(*)                 AS blank_campaigns_with_spend,
       ROUND(SUM(spend_usd), 2) AS spend
FROM meta_campaigns
WHERE results IS NULL
  AND spend_usd > 0;

-- Check: what the average is mixing  -- D-02
-- Expected: results measure different things (purchases, reach, landing page views),
-- so neither average above is a usable business metric.
SELECT result_indicator,
       COUNT(*)     AS campaigns,
       SUM(results) AS results
FROM meta_campaigns
GROUP BY result_indicator
ORDER BY results DESC;


-- ============================================================
-- Holiday Game Plan 1.1: Five Instant Answers (Mike's Monday questions)
-- Question:  The five numbers Mike asks for every Monday.
-- Decision:  Weekly reorder and ad-budget check-in.
-- Period:    shopify_sales: unknown (no dates). meta_campaigns: Jan 1, 2025 – Sep 7, 2026.
--            shopify_checkouts: Oct 29, 2016 – Oct 6, 2026.
-- ============================================================

-- Q1: Top 10 products by units sold
-- Expected #1: Dwellings of Eldervale - LEGENDARY Upgrade Kit, 396 units.
-- Note: #9 and #10 are free gift-wrap items (230 units, $0 revenue)  -- D-05
SELECT product_title, net_items_sold
FROM shopify_sales
ORDER BY net_items_sold DESC
LIMIT 10;

-- Q2: Top 10 products by revenue
-- Expected #1: Dwellings of Eldervale - LEGENDARY Upgrade Kit, 28190.64.
-- 7 of these 10 are also in the units top 10. Together they make 100050.99 of 159612.11 (62.7%).
-- total_sales includes tax; net_sales gives the same order  -- D-01
SELECT product_title, total_sales
FROM shopify_sales
ORDER BY total_sales DESC
LIMIT 10;

-- Q3: Products in the catalog (expected: 116, all distinct titles)
SELECT COUNT(*) AS products
FROM shopify_sales;

-- Q4: Total Meta ad spend (expected: 98542.56; 16 of 42 campaigns spent anything)
SELECT ROUND(SUM(spend_usd), 2) AS total_spend
FROM meta_campaigns;

-- Q5: Unique checkout sessions (expected: 1197, not 1579)  -- D-12
-- shopify_checkouts has one row per line item, so COUNT(*) over-counts.
SELECT COUNT(*)             AS line_item_rows,
       COUNT(DISTINCT name) AS checkout_sessions
FROM shopify_checkouts;


-- ============================================================
-- Holiday Game Plan 1.1: Five Instant Answers
-- Question:  The five questions Mike asks every Monday morning.
-- Decision:  Weekly reorder and ad-budget check-ins (replaces ~2 hours of manual work for Jess).
-- Period:    Each table's full range. shopify_sales: unknown; meta_campaigns: Jan 2025 – Sep 2026;
--            shopify_checkouts: Oct 2016 – Oct 2026.
-- Sanity checks: Q3 = 116, Q4 = 98542.56, Q5 = 1197.
-- ============================================================

-- Q1: Top 10 products by units sold  -- D-05
-- Expected #1: Dwellings of Eldervale - LEGENDARY Upgrade Kit (396).
-- Note: Holiday Insert 2025 Gift Tag and Holiday Bow 2025 rank 9th and 10th (230 units, $0 sales).
SELECT product_title, net_items_sold
FROM shopify_sales
ORDER BY net_items_sold DESC
LIMIT 10;

-- Q2: Top 10 products by total revenue  -- D-01
-- Expected #1: Dwellings of Eldervale - LEGENDARY Upgrade Kit (28190.64).
-- Note: the Oracle Hex Tile, #2 by units, is not in the revenue top 10.
SELECT product_title, total_sales
FROM shopify_sales
ORDER BY total_sales DESC
LIMIT 10;

-- Q3: How many products are in the catalog? (expected: 116)
-- Note: 3 of the 116 have $0 sales, including the two gift-wrap items.
SELECT COUNT(*) AS products
FROM shopify_sales;

-- Q4: Total Meta ad spend (expected: 98542.56)  -- D-06
-- Note: only 16 of the 42 campaigns spent anything.
SELECT ROUND(SUM(spend_usd), 2) AS total_meta_spend
FROM meta_campaigns;

-- Q5: How many unique checkout sessions started? (expected: 1197, not 1579)  -- D-12
-- COUNT(*) counts line items; each checkout session has one name.
SELECT COUNT(*)             AS line_item_rows,
       COUNT(DISTINCT name) AS checkout_sessions
FROM shopify_checkouts;
