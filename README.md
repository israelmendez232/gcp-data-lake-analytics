# [GCP] Data Lake and Analytics
Creating a data lake using Terraform and Google Cloud stack for analytics purpose. The objective of this project is to consume from a public API data and send to a infrastructure to analyze by using BigQuery.

## Summary
- [[GCP] Data Lake](#gcp-data-lake)
  - [Summary](#summary)
  - [1. Start](#1-start)
  - [2. Main Architecture](#2-main-architecture)
  - [3. ETL, Data Lake and Data Warehouse](#3-etl-data-lake-and-data-warehouse)
    - [3.1 ETL](#31-etl)
    - [3.2 Data Lake](#32-data-lake)
    - [3.3 Data Warehouse](#33-data-warehouse)

## 1. Start
1. Clone the repo here:
``` bash
git clone https://github.com/israelmendez232/gcp-data-lake-analytics.git
cd ./gcp-data-lake-analytics/
```

2. Clone and change the name of the `.env-sample` file:
``` bash
cp .env-sample .env
```

3. Modify the `.env` file to have all the credentations needed.

4. To test the code locally, just use Docker to start:
``` bash
docker image 
```

## 2. Main Architecture
Decided to follow by the these solutions:
1. **Public API:** collect data using a financial API, because of the frequency of the data to be quite high in this market. Specially on crypto. Also choosed the [Bitfinex API v2](https://docs.bitfinex.com/docs/introduction) because they have a good documentation and to collect the main data doesn't need to be authenticated;
2. **ETL:** decided to use Python with [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine?hl=pt-br) to store the code;
3. **Data Lake:** using [Cloud Storage](https://cloud.google.com/storage?hl=pt-br) to save encoded [.parquet](https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-parquet?hl=pt-br#:~:text=Parquet%20%C3%A9%20um%20formato%20de,%2C%20bem%20como%20substitu%C3%AD%2Dlas.) files as structured data;
4.  **CI/CD:** to use GitHub to store the code and modifications, such as the documention on this README. And use [Cloud Build](https://cloud.google.com/build?hl=pt-br) to connect to the repository and update the GKE envoiroment;
5.  **Data Warehouse:** read the data transformed from [Cloud Storage](https://cloud.google.com/storage?hl=pt-br) from [BigQuery](https://cloud.google.com/bigquery?hl=pt-br);
6.  **Infrastructure as Code:** decided to manage and script all infrastructure using [Terraform](https://www.terraform.io/).

## 3. ETL, Data Lake and Data Warehouse

### 3.1 ETL


### 3.2 Data Lake
The objective here is to divide the data lake in zones to avoid repeating code and provide a better envoiroment for data quality. 
1. **Raw:** Receive the raw data, such as .json or .csv - No transformation and neighter a partition now
1. **Trusted:** Retreive the data in raw, transform in a structured format and encoded in .parquet - Partition by date
1. **Analytics:** Get the data in trusted, run all the complex aggregations and main tables, without the need for partitioning, for consumption of the final user.

Here is a table to explain better:
| Zones     | File              | Partition | Source                |
|-----------|-------------------|-----------|-----------------------|
| Raw       | .json/.csv/others | No        | System of Record      |
| Trusted   | .parquet          | Yes       | Raw                   |
| Analytics | .parquet          | No        | Trusted + Custom Code |

### 3.3 Data Warehouse
The point here is to show all the layers 
