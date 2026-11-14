# Data

`breaking_games.db` is the original SQLite database provided by Extern, Inc. for the SQL & Database Architecture Externship. It is published here **unchanged**, so anyone can re-run every query in [`../sql/`](../sql/) from the same starting point.

## Rules

- **Never edit this file.** All cleaning, mapping, and new tables happen in the SQL scripts, which work on a copy or create views.
- **Work on a copy.** Before running a script that writes, copy the file (for example, `breaking_games_work.db`). `.gitignore` keeps working copies out of Git.
- Any change to the original would be logged as a reopened D-13 in [`../docs/design-decisions.md`](../docs/design-decisions.md).

## Checksum

The SHA-256 checksum proves the file hasn't changed since it was added.

```
2e14521a10d097ed9b48bcdef51cf6ad5f7d6ba2338662ea36ec247ad9681482  breaking_games.db
```

To check it on a Mac, open Terminal in this folder and run:

```bash
shasum -a 256 breaking_games.db
```

The result should match the line above exactly.

## Contents

| Table | Rows |
|---|---:|
| `shopify_sales` | 116 |
| `shopify_orders` | 277 |
| `shopify_checkouts` | 1,579 |
| `referrals` | 4,450 |
| `meta_campaigns` | 42 |
| `meta_ad_sets` | 102 |

Column definitions are in [`../docs/data-dictionary.md`](../docs/data-dictionary.md).

## Privacy

The database contains no real customer data. Confirmed on Nov 11, 2026 that it can be used in a portfolio and published on GitHub (D-13).

- Customer names are placeholders ("Customer 001").
- Emails are placeholders (`customer_001@example.com`).
- Location is kept only at the city, region, and country level.
