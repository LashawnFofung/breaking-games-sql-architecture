# Metric Definitions

Every number on the dashboard is defined here before it is computed. A metric with a blank window or caveat is not ready to ship.

| Metric | Formula | Grain | Source | Window | Owner (decision) | Caveat |
|---|---|---|---|---|---|---|
| Product net revenue | `SUM(net_sales)` | Product | `shopify_sales` | Unknown period (open question 1) | Mike (print priority) | Period unknown; excludes tax (D-01) |
| Revenue share, top 20% of products | Net revenue of top 20% ÷ total net revenue | Catalog | `shopify_sales` | Unknown period | Mike | First pass used total sales (79.5%); recompute on net sales |
| Units sold | `SUM(net_items_sold)` | Product | `shopify_sales` | Unknown period | Mike (print quantity) | Cheap add-ons rank high (D-05) |
| Checkout sessions by channel | `SUM(checkout_sessions)` grouped by `dim_channel` | Channel | `referrals` | Unknown period | Jess (channel budget) | Depends on referrer mapping (D-08) |
| Weighted add-to-cart rate | `SUM(added_to_cart_rate × pageviews) ÷ SUM(pageviews)` | Channel | `referrals` | Unknown period | Jess | Never averaged row by row |
| Cost per purchase (Meta-reported) | `SUM(spend_usd) ÷ SUM(results)` where indicator = purchases | Campaign group | `meta_campaigns` | Jan 2025 – Sep 2026 | Jess | Meta's count, not verified against Shopify |
| Abandoned checkouts | `COUNT(DISTINCT name)` after bot rule | Checkout | `shopify_checkouts` | State the years used | Jess (cart recovery) | Uneven years; bot rule pending (D-09) |
| Abandoned cart value | `SUM(total)` from the row carrying totals, after bot rule | Checkout | `shopify_checkouts` | State the years used | Jess | Third-party vendors pending (D-11) |
| Average order value | Order total ÷ orders | Order | `shopify_orders` | Aug 2026 | Mike | One month only; includes shipping |
