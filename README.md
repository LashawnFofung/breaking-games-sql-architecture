# Breaking Games — SQL & Database Architecture

SQL and database architecture project for **[Breaking Games](https://breakinggames.com)**, completed through the **Extern, Inc.** SQL & Database Architecture Externship (8 weeks, starting November 2026).

## About Breaking Games

Breaking Games is an indie tabletop game publisher in Netcong, New Jersey, and the publishing arm of Ad Magic, Inc. It sells everything from $10 party games like POOP and Sparkle*Kitty to $99+ strategy boxes like Dwellings of Eldervale. Ad Magic also manufactures and fulfills games for other publishers, including Cards Against Humanity.

## The Problem

Breaking Games' direct-to-consumer (Shopify) business runs on six disconnected data exports stitched together in a spreadsheet. None of the files share an ID, so basic questions take hours to answer by hand:

- Which of 100+ products actually make money, and what should be restocked before the holiday print-run deadline?
- Is the Meta (Facebook/Instagram) ad spend paying off, and where should the budget go next?
- How many abandoned carts are real shoppers, and how many are bots?

This project turns those exports into a connected, analytics-ready database and a recommendation the team can act on.

## Data Sources

All data comes from Shopify and Meta Ads Manager and is anonymized (customer names and emails are placeholders). Wholesale and Kickstarter sales are out of scope.

| Table | Source | Rows | What it holds | Date range |
|---|---|---:|---|---|
| `shopify_sales` | Shopify | 116 | Revenue, units, discounts, and returns per product | Summary |
| `shopify_orders` | Shopify | 277 | One row per order line item, plus shipping rows | Aug 2026 |
| `shopify_checkouts` | Shopify | 1,579 | Checkouts, including abandoned carts | Oct 2016 – Oct 2026 |
| `referrals` | Shopify Analytics | 4,450 | Traffic source, landing page, and conversion metrics | — |
| `meta_campaigns` | Meta Ads Manager | 42 | Campaign-level ad performance and spend | Jan 2025 – Sep 2026 |
| `meta_ad_sets` | Meta Ads Manager | 102 | Ad-set-level performance (campaigns contain ad sets) | Jan 2025 – Sep 2026 |

### Known data quirks

- **No shared keys.** Tables can only be linked by product title (which has variants and typos) or by cleaned-up traffic source.
- **Inconsistent values,** such as `Game` vs `game` in `shopify_sales.product_type`.
- **NULL vs zero.** Blank results in the Meta tables mean "not recorded," not zero, which changes averages.
- **Pipe-delimited product names,** such as `Expancity | Family Strategy City Building Game | 2-4 Players`.
- **Mismatched date windows** across files.
- **Bot-like checkouts** that inflate abandoned-cart counts.

## Project Roadmap

| # | Project | Outcome |
|---|---|---|
| 1 | Load and explore the raw data | Database verified; first queries against real revenue data |
| 2 | Design a database that connects the data | Tables, primary/foreign keys, and joins from ad click to purchase |
| 3 | Find out what's actually selling | Product revenue ranking, summary tables, restock recommendation |
| 4 | See which marketing is working | Traffic sources cleaned into channels; ad and channel ROI |
| 5 | Investigate why carts get abandoned | Bot filtering and a true abandonment rate |
| 6 | Build a dashboard and make a recommendation | Shareable HTML dashboard and final recommendation |

## Tech Stack

- **Database:** SQLite
- **Database tool:** [DB Browser for SQLite](https://sqlitebrowser.org)
- **AI co-pilot:** Claude, for drafting and cross-checking SQL
- **Dashboard:** HTML
- **Version control:** Git & GitHub

## Repository Structure

```
breaking-games-sql-architecture/
├── docs/
│   ├── erd/                    # Entity-relationship diagrams
│   ├── data-dictionary.md      # Table and column definitions
│   └── design-decisions.md     # Keys, cleaning, and modeling rationale
├── sql/
│   ├── 01_exploration.sql      # Project 1: first queries and row checks
│   ├── 02_schema.sql           # Project 2: tables, keys, and views
│   ├── 03_product_revenue.sql  # Project 3
│   ├── 04_marketing.sql        # Project 4
│   └── 05_abandoned_carts.sql  # Project 5
├── dashboard/
│   └── dashboard.html          # Project 6
├── beyond-the-externship/      # SQLite vs MongoDB architecture comparison
├── screenshots/
└── README.md
```

## Getting Started

1. Install [DB Browser for SQLite](https://sqlitebrowser.org).
2. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/breaking-games-sql-architecture.git
   ```
3. Open `breaking_games.db` in DB Browser. *(The database is provided by Extern, Inc. and may not be included in this repository.)*
4. Verify the row counts:
   ```sql
   SELECT COUNT(*) FROM shopify_sales;      -- 116
   SELECT COUNT(*) FROM shopify_orders;     -- 277
   SELECT COUNT(*) FROM shopify_checkouts;  -- 1579
   SELECT COUNT(*) FROM referrals;          -- 4450
   SELECT COUNT(*) FROM meta_campaigns;     -- 42
   SELECT COUNT(*) FROM meta_ad_sets;       -- 102
   ```
5. Run the scripts in `sql/` in order.

## Progress

- [ ] Project 1: Load and explore the raw data
- [ ] Project 2: Design a connected database
- [ ] Project 3: Product revenue analysis
- [ ] Project 4: Marketing attribution
- [ ] Project 5: Abandoned cart analysis
- [ ] Project 6: Dashboard and recommendation
- [ ] Beyond the Externship: SQLite vs MongoDB architecture comparison

## Beyond the Externship

A planned extension comparing the relational design built here with a document model in MongoDB: how the same order and marketing data would be shaped, queried, and scaled differently, and when each approach fits.

## Author

**_Your Name_** — SQL & Database Architecture Extern, Extern, Inc.
[LinkedIn](#) · [GitHub](#)

## Acknowledgments

Thanks to **Breaking Games** and **Extern, Inc.** for the opportunity to work on this project. Jess Walker and Mike Bradley are fictional characters from the externship scenario.

---

*Completed for educational purposes as part of an externship. Customer data is anonymized and does not identify real Breaking Games customers.*
