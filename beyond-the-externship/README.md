# Beyond the Externship — SQLite vs MongoDB

A planned white paper comparing the relational design built in this project with a document model in MongoDB.

## The Question

How would the same Breaking Games order and marketing data be shaped, queried, and scaled in each model, and when does each one fit?

## Working Thesis

The two fit together rather than compete. Raw JSON from the Shopify and Meta APIs lands in MongoDB as it arrives, then an extract-transform-load step moves it into relational tables for analysis.

## Planned Comparison

| Dimension | SQLite (relational) | MongoDB (document) |
|---|---|---|
| Ingesting raw API data | | |
| Handling messy or changing fields | | |
| Joining across sources | | |
| Analytical queries | | |
| Scaling | | |
| Fit for Breaking Games today | | |

## Ground Rules

- Any example that includes marketing attribution is labelled **hypothetical**. The externship data can't support customer-level attribution (see D-07 in [`../docs/design-decisions.md`](../docs/design-decisions.md)).
- Examples use the externship's table structures, not real customer data.
