# Rules for the SQL co-pilot

Read this before writing any query in this repo. Claude does the typing; I do the thinking. These rules exist because each trap below was found in the data on 2026-11-10 and would otherwise be rediscovered every session.

## How we work

1. Before writing SQL, restate the business question and the decision it informs. If neither is clear, ask.
2. Every query states its time window in a comment. If a table has no dates, say so.
3. When a query involves a choice with a real alternative, stop and propose an entry for `docs/decision-log.md` instead of choosing silently.
4. When I ask for help with a decision, give the strongest argument **against** my current pick before agreeing.
5. Never change `PRD.md` by appending. Rewrite the affected section.

## Data rules (do not break)

| Table | Rule | Why |
|---|---|---|
| `shopify_checkouts` | Count checkouts with `COUNT(DISTINCT name)`, never `COUNT(*)` | 1,579 rows = 1,197 checkouts; extra rows are extra line items |
| `shopify_checkouts` | Take money fields only from the row that carries them | Only the first line of a multi-line checkout has totals |
| `shopify_orders` | Exclude `sale_id LIKE '%-S'` from product metrics; keep for order totals | Shipping rows have a blank product title |
| `shopify_sales` | Use `net_sales` for revenue | `total_sales` includes tax (D-01) |
| `shopify_sales` | Never claim a period for its figures | No date column (D-06) |
| `meta_campaigns`, `meta_ad_sets` | Filter or group by `result_indicator` before touching `results` | `results` counts different things per campaign (D-02) |
| `meta_campaigns`, `meta_ad_sets` | Treat blank `results` as not recorded, not zero | D-02 |
| `meta_ad_sets` | Don't identify an ad set by name alone | 11 names repeat across 31 rows |
| `referrals` | Weight rates by pageviews; never average row by row | Tiny samples show 100% rates |
| `referrals` | Map referrers to channels via `dim_channel`, not ad hoc `LIKE` filters | D-08 |
| Any join across products | Join through `dim_product.product_id`, not raw titles | D-03 |
| Any cross-table metric | Only with an overlapping, stated time window | D-06; see `rejected.md` |

## Output conventions

- One SQL file per business question in `sql/`, numbered.
- Each file opens with a header: question, decision it informs, tables used, time window, decisions it depends on.
- Money rounded to 2 decimals; percentages to 1.
