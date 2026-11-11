# Data Quality Report

What's wrong in each table, what I did about it, and what Breaking Games should **not** trust yet. Profiled 2026-11-10. Decision IDs refer to [`design-decisions.md`](design-decisions.md).

## Summary

| Table | Trust | Biggest issue | Handling | Don't trust yet |
|---|---|---|---|---|
| `shopify_sales` | High | No date column | Rank only; never claim a period (D-06) | Any "this season" or trend claim |
| `shopify_orders` | High, small sample | One month, 92 orders | Use for basket mix and order size only | Anything holiday-related |
| `shopify_checkouts` | Medium | Totals only on the first line of each checkout | `COUNT(DISTINCT name)` (D-12) | Cart value, until the bot rule runs (D-09) |
| `referrals` | Medium for volume, medium-low for rates | No dates; rates on tiny samples | Weight rates by pageviews; group into channels (D-08) | Row-level conversion rates |
| `meta_campaigns` | Medium | `results` mixes units | Compare within `result_indicator` (D-02) | Any total or average of `results` |
| `meta_ad_sets` | Medium | No campaign link; duplicate names | Report at the ad set level only | Which campaign an ad set belongs to |

## Issues by Table

### `shopify_sales`

- **Fixed:** lowercase `game` merged into `Game` (D-10).
- **Labelled, not guessed:** 7 blank categories become "Uncategorized."
- **Flagged:** 3 products with $0 sales, including two holiday gift-wrap items.
- **Verified:** `net_sales` and `total_sales` reconcile on all 116 rows.

### `shopify_orders`

- **Handled:** 92 shipping rows left out of product metrics, kept in order totals (D-04).
- **Flagged:** "Pairs: Wild West - Blue" doesn't match any `shopify_sales` title; to be mapped in Project 2.
- **Limit:** no customer column, so orders can't be tied to a customer or a checkout.

### `shopify_checkouts`

- **Handled:** 382 rows that look blank are extra line items, not missing data.
- **Flagged:** only 91 of 176 product names match `shopify_sales` exactly; needs the title mapping (D-03).
- **Flagged:** Blackbox (96 rows) and Secret Hitler (18 rows) items; scope pending (D-11).
- **Flagged, not fixed:** 25 checkouts show a refunded amount ($2,841) despite never being paid.
- **Flagged:** `source` codes 88312 and 580111 are unexplained.
- **Uneven years:** 523 checkouts in 2025 and 272 in 2021, but only 17–40 in most other years.
- **Not usable:** `financial_status` is always blank; `lineitem_discount` is always 0; `payment_method` is blank on 63% of rows.

### `referrals`

- **Handled:** rates weighted by pageviews.
- **To group:** 469 referrers into channels, with spam referrers separated (D-08).
- **Flagged:** facebook, instagram, and internalfb are all Meta; google and googlesyndication are different things.
- **Not usable:** all six previous-year columns are empty.

### `meta_campaigns` and `meta_ad_sets`

- **Handled:** `results` only compared within the same `result_indicator`; blanks treated as not recorded (D-02).
- **Verified:** spend ($98,543) and impressions match exactly between the two tables.
- **Flagged:** 28 campaigns with no recorded result spent $22,126.
- **Not usable:** `shop_clicks` is always empty.

## Questions for the Mentor

1. What period does `shopify_sales` cover?
2. What period does `referrals` cover?
3. Are Blackbox and Secret Hitler products in scope?
4. Why do some abandoned checkouts show a refunded amount?
5. What do `source` codes 88312 and 580111 mean?
6. Should a blank `referrer` count as Direct?
