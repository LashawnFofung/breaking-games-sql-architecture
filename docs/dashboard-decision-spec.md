# Dashboard Decision Spec

Written **before** the dashboard is built. A tile earns its place only if it names the decision it informs and the threshold that triggers action. Thresholds marked TBD are agreed with the mentor before Project 6.

## Tiles

| # | Tile | Question | Decision it informs | Action threshold | Metric |
|---|---|---|---|---|---|
| 1 | Top products by net revenue | Which titles matter most? | Print priority | Titles in the top 20% get priority print slots | Product net revenue |
| 2 | Units vs revenue rank | Are we printing for volume or value? | Print quantity per title | A title ranking 10+ places apart on the two lists gets a manual review | Units sold, product net revenue |
| 3 | Checkout sessions by channel | Which channels bring buyers, not just visitors? | Q4 channel budget | High pageviews with a low weighted checkout share marks a channel to cut | Checkout sessions by channel |
| 4 | Meta cost per purchase | Is Meta purchase spend paying back? | Meta budget | Above [average order value or product margin, TBD] triggers a budget review | Meta cost per purchase |
| 5 | Real abandoned-cart value | Is cart recovery worth funding? | Cart-recovery email or discount | [TBD] in recoverable value after the bot rule | Abandoned-cart value |

Metric formulas are in [`metric-definitions.md`](metric-definitions.md).

## What This Dashboard Doesn't Show

This note ships on the dashboard itself.

- **When products sold.** The sales data has no dates.
- **Exact return on ad spend.** Sales and ad data don't cover a known common period, so ROI is shown at the channel level with its time assumption.
- **Which ad drove which sale.** Nothing links customers to campaigns.
- **Wholesale and Kickstarter.** Out of scope.

## Cut From the Dashboard

See [`../rejected.md`](../rejected.md). Every tile I chose not to build is listed there with the reason.
