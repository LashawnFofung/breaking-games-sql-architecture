# Metric Definitions

Every number on the dashboard is defined here before it's calculated. A metric with a blank period or caveat isn't ready to ship. Decision IDs refer to [`design-decisions.md`](design-decisions.md).

| Metric | Formula | Source | Period | Used for | Caveat |
|---|---|---|---|---|---|
| Product net revenue | `SUM(net_sales)` by product | `shopify_sales` | Unknown (open question 1) | Mike: print priority | Excludes tax (D-01) |
| Revenue share of top 20% of products | Net revenue of the top 20% ÷ total net revenue | `shopify_sales` | Unknown | Mike: print priority | The first pass used total sales (79.5%); recompute on net sales |
| Units sold | `SUM(net_items_sold)` by product | `shopify_sales` | Unknown | Mike: print quantity | Cheap add-ons rank high (D-05) |
| Average order value | Order total ÷ number of orders | `shopify_orders` | Aug 2026 | Mike: pricing context | One month only; includes shipping |
| Checkout sessions by channel | `SUM(checkout_sessions)` grouped by channel | `referrals` | Unknown | Jess: channel budget | Depends on the channel mapping (D-08) |
| Weighted add-to-cart rate | `SUM(added_to_cart_rate × pageviews) ÷ SUM(pageviews)` | `referrals` | Unknown | Jess: channel budget | Never averaged row by row |
| Meta cost per purchase | `SUM(spend_usd) ÷ SUM(results)` where the indicator is purchases | `meta_campaigns` | Jan 2025 – Sep 2026 | Jess: Meta budget | Meta's own purchase count, not checked against Shopify |
| Estimated Meta ROI | (Meta-reported purchases × average order value) ÷ Meta spend | `meta_campaigns`, `shopify_orders` | State the assumption | Jess: Meta budget | An estimate: no table holds revenue by channel, the AOV comes from August 2026 only, and the periods don't match (D-06) |
| Abandoned checkouts | `COUNT(DISTINCT name)` after the bot rule | `shopify_checkouts` | State the years used | Jess: cart recovery | Uneven years; bot rule pending (D-09) |
| Abandoned-cart value | `SUM(total)` from the row carrying totals, after the bot rule | `shopify_checkouts` | State the years used | Jess: cart recovery | Third-party vendors pending (D-11) |
| Abandonment rate | Abandoned ÷ (abandoned + completed) for the same period | `shopify_checkouts`, `shopify_orders` | Must match | Jess: cart recovery | Completed orders cover Aug 2026 only |
