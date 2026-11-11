# Data Dictionary

Table and column definitions for `breaking_games.db`, profiled 2026-11-10. For what each table can be trusted for, see [`data-quality-report.md`](data-quality-report.md).

## Tables at a Glance

| Table | Rows | One row is… | Date range | Key figures |
|---|---:|---|---|---|
| `shopify_sales` | 116 | One product, totals for an unstated period | None | $159,612 total sales · $150,883 net sales · 6,560 units |
| `shopify_orders` | 277 | One order line item, or one shipping charge | Aug 1–31, 2026 | 92 orders · $4,058 total |
| `shopify_checkouts` | 1,579 | One line item in an abandoned checkout | Oct 2016 – Oct 2026 | 1,197 checkouts · 1,171 customers · $94,320 cart value |
| `referrals` | 4,450 | One referring site and landing page pair | None | 823,393 pageviews · 2,726 checkout sessions |
| `meta_campaigns` | 42 | One campaign, lifetime totals | Jan 1, 2025 – Sep 7, 2026 | $98,543 spend |
| `meta_ad_sets` | 102 | One ad set, lifetime totals | Jan 1, 2025 – Sep 7, 2026 | $98,543 spend (matches campaigns) |

## `shopify_sales`

Shopify's product sales report.

| Column | Meaning | Notes |
|---|---|---|
| `product_title` | Product name | 116 unique; 17 use the pipe format |
| `product_vendor` | Vendor | Always "Breaking Games" |
| `product_type` | Category | Game 95 · Game Accessory 10 · Gift 2 · Toy 1 · `game` 1 · blank 7 |
| `net_items_sold` | Units sold after returns | 1 to 396 |
| `gross_sales` | Revenue before discounts and returns | |
| `discounts`, `returns` | Reductions | Stored as negative numbers |
| `net_sales` | `gross_sales + discounts + returns` | Reconciles on every row |
| `taxes` | Sales tax collected | |
| `total_sales` | `net_sales + taxes` | Reconciles on every row |

## `shopify_orders`

Line-item detail for completed orders in August 2026.

| Column | Meaning | Notes |
|---|---|---|
| `day` | Order date | Aug 1–31, 2026; orders on 29 days |
| `sale_id` | Line ID | Ends in `-1`, `-2`… for products, `-S` for shipping |
| `order_name` | Order number | 92 orders, `BREAKING-GAMES-59795` to `-59886` |
| `product_title` | Product | Blank on all 92 shipping rows |
| `gross_sales` … `total_sales` | Line amounts | Same structure as `shopify_sales` |
| `shipping_charges` | Shipping fee | Only on `-S` rows; mostly a $5 flat rate |
| `returns`, `return_fees` | Returns | Always 0 this month |

## `shopify_checkouts`

Shopify's abandoned-checkout export. Every row is unfulfilled.

| Column group | Columns | Notes |
|---|---|---|
| Checkout ID | `name` | 1,197 checkouts across 1,579 rows |
| Customer | `email`, `customer_id`, `customer_name` | 1,171 customers; anonymized ("Customer 001") |
| Cart amounts | `subtotal`, `shipping`, `taxes`, `total`, `discount_code`, `discount_amount` | Only on the first row of each checkout |
| Line item | `lineitem_quantity`, `lineitem_name`, `lineitem_price`, `lineitem_sku` | SKUs like `BGZ110192` |
| Location | `billing_*`, `shipping_*` | 56 countries; the US leads with 534 checkouts |
| Other | `created_at`, `accepts_marketing`, `payment_method`, `refunded_amount`, `vendor`, `risk_level`, `source` | `created_at` is text with a time zone, e.g. `2025-07-29 08:20:35 -0400` |

## `referrals`

Shopify Analytics traffic report.

| Column | Meaning | Notes |
|---|---|---|
| `referrer` | Referring site | 469 values; blank on 2,167 rows |
| `landing_page` | First page viewed | 2,350 unique paths |
| `pageviews` | Pageviews | 1 to 87,087 |
| `added_to_cart_rate`, `conversion_rate`, `bounce_rate` | Rates, 0 to 1 | Weight by pageviews before combining |
| `pageviews_per_session` | Depth of visit | |
| `checkout_sessions` | Sessions that reached checkout | |
| `*_previous_year` (6 columns) | Last year's comparison | All empty |

## `meta_campaigns`

Meta Ads Manager export, one row per campaign.

| Column | Meaning | Notes |
|---|---|---|
| `reporting_starts`, `reporting_ends` | Report window | Same on every row: Jan 1, 2025 – Sep 7, 2026 |
| `campaign_name` | Campaign | 42 campaigns; 2 active. Names carry structure, e.g. `DA \| Sales \| Advantage Plus \| MoF` |
| `results`, `result_indicator` | What the campaign optimized for, and how many | Different units per campaign; compare within one indicator |
| `reach`, `impressions`, `frequency` | Audience and exposure | |
| `spend_usd` | Ad spend | $98,543 total; 16 campaigns spent anything |
| `cost_per_result`, `cpm_usd`, `cpc_usd`, `ctr_*`, `clicks_all`, `link_clicks` | Efficiency metrics | |
| `shop_clicks` | Shop clicks | Always empty |

## `meta_ad_sets`

The same export one level down. Columns match `meta_campaigns`, with `ad_set_name` in place of `campaign_name`, plus a third status, `not_delivering` (55 rows). There is no campaign column, and 11 names repeat across 31 rows.

## Planned Tables (Project 2)

| Table | Purpose | Decision |
|---|---|---|
| `dim_product` | One row per product with a stable `product_id` | D-03 |
| `product_title_map` | Every title variant mapped to its `product_id` | D-03 |
| `dim_channel` | The 469 referrers grouped into a handful of channels | D-08 |
