# Rejected

What this project deliberately does not do, and why. Each entry also says what would change my mind.

## Out of Scope

| Idea | Why not | What would change my mind |
|---|---|---|
| Wholesale and Kickstarter sales | The externship covers Shopify direct-to-consumer only, and none of the six tables includes those channels | A wholesale or Kickstarter export added to the dataset |
| Customer-level attribution (which ad led to which buyer) | No field links a customer or order to a campaign, so any link would be invented | Order-level UTM or campaign IDs |
| A demand forecast | No dated sales history to build or test one on; a forecast would look precise and be guesswork | 12 or more months of dated sales |
| Year-over-year holiday comparison | No dated sales history, and the referrals table's previous-year columns are all empty | Dated sales for at least the last holiday season |
| Publishing a cleaned copy of the database | Cleaning edits would be hidden inside the file. The original is published unchanged and all cleaning lives in SQL scripts (D-13) | Never; cleaning stays in scripts |

## Done Only With a Stated Assumption

These are in the roadmap, so they get built, but never as a bare number.

| Metric | The limitation | How it's reported |
|---|---|---|
| Ad and channel ROI (Project 4) | `shopify_sales` has no dates, and Meta reports one total for Jan 2025 – Sep 2026, so the two don't cover a known common period | Channel-level, with the time assumption printed beside the figure (D-06, D-07) |
| Abandonment rate (Project 5) | Abandoned checkouts span 2016–2026; completed orders cover August 2026 only | For a matched period, or labelled an estimate with its period stated |
| Ad-click-to-purchase joins (Project 2) | Nothing links an ad to an order | Built as a channel path: Meta spend → Meta-referred traffic → checkouts (D-07) |

## Never

| Practice | Why |
|---|---|
| Summing or averaging Meta `results` across campaigns | It mixes purchases, landing page views, and reach into one meaningless number (D-02) |
| Averaging referral rates row by row | 1,921 rows show a 100% rate on fewer than 5 pageviews; a plain average rewards tiny samples |
| "Fixing" the 25 abandoned checkouts that show a refunded amount | Unclear what they mean; changing them would hide a question for the mentor |
| A dashboard tile for every metric I can compute | Each extra tile pulls attention from the decisions that matter |
