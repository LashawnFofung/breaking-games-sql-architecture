# Dashboard Decision Spec

Written **before** the dashboard is built. A tile earns its place only if it names the decision it informs and the threshold that triggers action. Thresholds below are placeholders to agree with the mentor.

| # | Tile | Question it answers | Decision it informs | Action threshold | Metric (see definitions) |
|---|---|---|---|---|---|
| 1 | Top products by net revenue | Which titles matter most? | Print priority | Titles in the top 20% get priority print slots | Product net revenue |
| 2 | Units vs revenue rank | Are we printing for volume or value? | Print quantity per title | Any title ranking 10+ places apart on the two lists gets a manual review | Units sold, product net revenue |
| 3 | Checkout sessions by channel | Which channels bring buyers, not just visitors? | Q4 channel budget | A channel with high pageviews and a low weighted checkout share is a candidate to cut | Checkout sessions by channel |
| 4 | Meta cost per purchase | Is Meta purchase spend paying back? | Meta budget | Cost per purchase above [average order value or product margin, TBD] triggers a budget review | Cost per purchase |
| 5 | Real abandoned cart value | Is cart recovery worth funding? | Cart recovery email or discount | [TBD] in recoverable value after the bot rule | Abandoned cart value |

## What this dashboard doesn't show

This note ships on the dashboard itself.

- **When** products sold: sales data has no dates.
- **Return on ad spend**: sales and ad data don't share a time window.
- **Which ad drove which sale**: nothing links customers to campaigns.
- **Wholesale and Kickstarter**: out of scope.

## Cut from the dashboard

See [`../rejected.md`](../rejected.md). Every tile I chose not to build is listed there with the reason.
