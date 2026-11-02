# Breaking Games — SQL & Database Architecture

SQL and database architecture project for **[Breaking Games](https://breakinggames.com)**, completed through the **Extern, Inc.** SQL & Database Architecture Externship.

## About Breaking Games

Breaking Games is an indie tabletop game publishing imprint of Ad Magic, Inc., based in Netcong, New Jersey. The company works directly with game designers on development, art, and promotion, and publishes party, family, strategy, and hobby games. Its parent business also handles manufacturing, direct-to-consumer fulfillment, and Kickstarter fulfillment for clients, which makes reliable, well-structured data central to its operations.

## Project Goals

- Design a normalized relational database that models Breaking Games' core business
- Document the data model with an entity-relationship diagram (ERD)
- Write SQL to create, populate, and query the database
- Produce queries and reports that answer real business questions
- Recommend improvements for scalability, integrity, and performance

## Data Domains

| Domain | Example entities |
|---|---|
| Catalog | Games, editions, expansions, designers, categories |
| Inventory | Products/SKUs, warehouses, stock levels |
| Sales | Customers, orders, order items, payments |
| Fulfillment | Shipments, carriers, returns |
| Crowdfunding | Campaigns, backers, pledge tiers, rewards |
| Partners | Retailers, distributors, wholesale orders |

*Domains will be refined as project requirements are confirmed.*

## Repository Structure

```
breaking-games-sql-architecture/
├── docs/
│   ├── erd/                 # Entity-relationship diagrams
│   ├── data-dictionary.md   # Table and column definitions
│   └── design-decisions.md  # Normalization and design rationale
├── schema/
│   ├── 01_create_tables.sql
│   ├── 02_constraints.sql
│   └── 03_indexes.sql
├── data/
│   └── seed_data.sql        # Sample data for testing
├── queries/
│   ├── business_reports.sql
│   └── analysis.sql
├── views/
│   └── views.sql
└── README.md
```

## Tech Stack

- **Database:** _PostgreSQL / MySQL / SQL Server (update as applicable)_
- **Modeling:** _dbdiagram.io / Lucidchart / draw.io (update as applicable)_
- **Version control:** Git & GitHub

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/breaking-games-sql-architecture.git
   cd breaking-games-sql-architecture
   ```
2. Create a new database in your SQL environment.
3. Run the scripts in order:
   ```
   schema/01_create_tables.sql
   schema/02_constraints.sql
   schema/03_indexes.sql
   data/seed_data.sql
   views/views.sql
   ```
4. Explore the queries in `queries/`.

## Example Business Questions

- Which games and editions generate the most revenue?
- Which SKUs are running low on stock across warehouses?
- What is the average time from order to shipment?
- How do Kickstarter backer rewards map to fulfilled shipments?
- Which retailers and distributors order most frequently?

## Progress

- [ ] Requirements gathering
- [ ] Conceptual and logical data model
- [ ] ERD
- [ ] Physical schema (DDL)
- [ ] Seed data
- [ ] Business queries and views
- [ ] Indexing and performance review
- [ ] Final documentation and presentation

## Author

**_Lashawn Fofung_** — SQL & Database Architecture Extern, Extern, Inc.
[LinkedIn](#) · [GitHub](#)

## Acknowledgments

Thanks to **Breaking Games** and **Extern, Inc.** for the opportunity to work on this project.

---

*This project was completed for educational purposes as part of an externship. Any sample data is fictional and does not represent actual Breaking Games customers or business records.*
