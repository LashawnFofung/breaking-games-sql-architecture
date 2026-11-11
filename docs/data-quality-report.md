# Data Quality and Trust Report

Profiled 2026-11-10. For each table: what's wrong, what I did about it, and what the business should **not** trust yet.

## Summary

| Table | Trust | Biggest issue | Handling | Don't trust yet |
|---|---|---|---|---|
| `shopify_sales` | High | No date column | Rank only; never claim a period (D-06) | Any "this season" or trend claim |
| `shopify_orders` | High, small | One month, 92 orders | Use for basket mix and order size only | Anything holiday-related |
| `shopify_checkouts` | Medium | Totals only on the first line of each checkout | `COUNT(DISTINCT name)` (D-12) | Cart value until the bot rule runs (D-09) |
| `referrals` | Medium / medium-low | No dates; rates on tiny samples | Weight rates by pageviews; map to channels (D-08) | Row-level conversion rates |
| `meta_campaigns` | Medium | `results` mixes units | Compare within `result_indicator` (D-02) | Any total or average of `results` |
| `meta_ad_sets` | Medium | No campaign link; duplicate names | Report at ad set level only | Which campaign an ad set belongs to |

## Issues by table

### `shopify_sales`
- **Fixed:** lowercase `game` merged into `Game` (D-10).
- **Labelled, not guessed:** 7 blank categories → "Uncategorized".
- **Flagged:** 3 products with $0 sales, including two holiday gift-wrap items.
- **Verified:** `net_sales` and `total_sales` reconcile on all 116 rows.

### `shopify_orders`
- **Handled:** 92 shipping rows excluded from product metrics, kept for order totals (D-04).
- **Flagged:** "Pairs: Wild West - Blue" doesn't match any `shopify_sales` title; to be mapped in `dim_product`.

### `shopify_checkouts`
- **Handled:** 382 apparently blank rows are extra line items, not missing data.
- **Flagged:** only 91 of 176 product names match `shopify_sales` exactly; needs the mapping table (D-03).
- **Flagged:** Blackbox (96 rows) and Secret Hitler (18 rows) items; scope pending (D-11).
- **Flagged, not fixed:** 25 checkouts carry a refunded amount ($2,841) despite never being paid.
- **Flagged:** `source` codes 88312 and 580111 are unexplained.
- **Not usable:** `financial_status` always blank; `lineitem_discount` always 0.

### `referrals`
- **Handled:** rates weighted by pageviews.
- **To map:** 469 referrers into channels; spam referrers separated (D-08).
- **Not usable:** all six previous-year columns are empty.

### `meta_campaigns` and `meta_ad_sets`
- **Handled:** `results` only compared within the same `result_indicator`; blanks treated as not recorded (D-02).
- **Verified:** spend ($98,543) and impressions match exactly between the two tables.
- **Not usable:** `shop_clicks` always empty.

## Questions for the mentor

1. What period does `shopify_sales` cover?
2. What period does `referrals` cover?
3. Are Blackbox and Secret Hitler products in scope?
4. Why do some abandoned checkouts have a refunded amount?
5. What do `source` codes 88312 and 580111 mean?
6. Should a blank `referrer` be treated as Direct?
