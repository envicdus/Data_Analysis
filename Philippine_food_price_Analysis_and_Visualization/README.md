# Philippine Food Price Analysis and Visualization

## Overview
This project analyzes food price trends in the Philippines using Python. It involves data cleaning, visualization, statistical analysis, and forecasting to uncover insights into food price fluctuations.

## Features & Functionalities
- Data Scraping
- Data cleaning and preprocessing
- Interactive visualizations using Matplotlib and plotly
- Time series analysis of food prices
- Dashboard creation for easy data interpretation


## Data & Sources
- Data is sourced from publicly available datasets from (Worldbank.org)[https://microdata.worldbank.org/index.php/home]
- The dataset includes food prices over different time periods.

## Project Structure
```
├── Data/                                       # data
    ├── External/                               # data scraping folder
        ├── food_prices_scraper.ipynb           # first time scraping of data
        ├── full_dataset.csv                    # scraped data saved as csv  
        ├── updater.ipynb                       # scraping data for updating the dataset
    ├── Interim/                                # cleaning data folder
        ├── cleaning.ipynb                      # data cleaning notebook
        ├── clean_food_prices.csv               # cleaned dataset
    ├── Processed/                              # folder for data analysis
        ├── EDA.ipynb                           # EDA notebook
        ├── hypothesis_testing.ipynb            # Hypothesis testing process notebook
        ├── eda_results.csv                     # EDA results dataset
        ├── range_results.csv                   # another EDA results dataset
├── Reports                                     # Data Reporting/Visualization Folder
    ├── PowerBI/                                # Visualization using PowerBI
    ├── Tableau/                                # Visualization using Tableau
    ├── forecast.ipynb                          # data forecasting
    ├── dunns_test_results.csv                  # Dunn's Test results dataset
    ├── forecasts.csv                           # ARIMA forecasting Dataset
    ├── full_report.ipynb                       # Full Summary of Analysis
├── README.md                                   # Project documentation

```

## Metadata of the scraped dataset
- Please refer to this (link)[https://microdata.worldbank.org/index.php/catalog/6172/data-dictionary/PHL_2021_RTFP_MKT?file_name=PHL_RTFP_mkt_2007_2025-01-27.csv]

## Future Improvements
- Implement machine learning models for price prediction
- Add more interactive dashboards using Dash
- Automate data collection from APIs

