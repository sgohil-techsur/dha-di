# DBT Datapipeline

This repo contains DBT project for database creation for reporting and analytics purposes.

---

## Table of Contents
- [DBT Datapipeline](#dbt-datapipeline)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Source Tables](#source-tables)
  - [Table Descriptions](#table-descriptions)
  - [Folder Structure](#folder-structure)
  - [Resources](#resources)


## Overview

This project creates tables under analytics schema for Parks and Recreation reservation service and inventory service reporting. 

## Source Tables

This project uses data from other schemas within the data-service database. 

Please see sources.yml for source table descriptions.

## Table Descriptions

Tables are split into 3 categories:  
    - staging: Source tables cleaned with simple transformations  
    - intermediate: Tables from staging and sources joined for dimensional data  
    - analytics: Tables with more advanced calculations to be used in analytics reporting and dashboarding  

Please see schema.yml for table and column descriptions.

## Folder Structure

```
.
├── Dockerfile
├── README.md
├── dbt_project.yml
├── models
│   ├── analytics
│   │   └── daily_services_summary.sql
│   │   └── today_reservation_details.sql
│   ├── intermediate
│   │   ├── int_daily_services_reserved.sql
│   │   ├── int_reservation_details.sql
│   │   ├── int_service_details.sql
│   │   └── int_user_sites.sql
│   ├── schema.yml
│   ├── sources.yml
│   └── staging
│       ├── stg_date_range.sql
│       ├── stg_reservation.sql
│       └── stg_site.sql
└── packages.yml
```

## Resources

https://docs.getdbt.com/docs/introduction