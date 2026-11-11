# Rejected

What this project deliberately does not do, and why. Saying no with a reason is part of the work.

| Request or idea | Why not | What would change my mind |
|---|---|---|
| Include wholesale and Kickstarter sales | Program scope is Shopify direct-to-consumer only, and none of the six tables covers those channels | A wholesale or Kickstarter export added to the dataset |
| Customer-level attribution (which ad led to which buyer) | No field links a customer or order to a campaign; any link would be invented | Order-level UTM or campaign IDs |
| A single ROAS figure (Shopify revenue ÷ Meta spend) | `shopify_sales` has no dates and Meta is one lifetime block, so the two don't cover a common period | Monthly Meta spend plus dated sales |
| A true cart abandonment rate | Abandoned checkouts span 2016–2026; completed orders cover August 2026 only | Completed orders for the same period as the checkouts |
| Year-over-year holiday comparison | No dated sales history; the referrals table's previous-year columns are all empty | Dated sales for at least the last holiday season |
| A demand forecasting model | No time series to train or test on; a forecast would look precise and be guesswork | 12+ months of dated sales |
| Summing or averaging Meta `results` across campaigns | It mixes purchases, landing page views and reach into one meaningless number | Never; compare within one `result_indicator` |
| Averaging referral rates row by row | 1,921 rows show a 100% rate on fewer than 5 pageviews; a plain average rewards tiny samples | Never; weight rates by pageviews |
| Fixing the 25 abandoned checkouts with a refunded amount | Unclear what they mean; "fixing" them would hide a question | Mentor explains them (open question 4 in the data report) |
| A dashboard tile for every metric I can compute | More tiles means less attention on the three decisions that matter | A stakeholder names a decision a missing tile would inform |
| Publishing the `.db` file and CSVs | Not yet confirmed with Extern | Written confirmation from Extern |
