-- 00_verification.sql
-- Question:  Did the data load as expected?
-- Decision:  Whether the database is safe to build on.
-- Window:    All rows, no filtering.
-- Expected results recorded 2026-11-10.

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
