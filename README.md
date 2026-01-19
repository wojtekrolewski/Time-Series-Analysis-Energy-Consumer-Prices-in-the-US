# Time-Series-Analysis-Energy-Consumer-Prices-in-the-US

## 1. Project Overview
This project focuses on time series analysis and forecasting using real-world macroeconomic data from the Federal Reserve Economic Data (FRED) database.
The goal was to analyze long-term trends, seasonality, and temporal dependencies in selected economic indicators and evaluate classical statistical models for forecasting.

The project was carried out as part of academic coursework, but structured as a complete analytical pipeline, from data acquisition to interpretation of results.

## 2. Objectives
- Explore and understand temporal patterns in economic time series
- Identify trend and seasonality components
- Verify stationarity and apply appropriate transformations
- Build and compare classical time series models
- Generate short-term forecasts and interpret their limitations

## 3. Data
**Source:** Federal Reserve Economic Data (FRED)

**Type:** Monthly economic indicators (e.g. energy prices, consumer price indices)

**Characteristics:**

- Long historical horizon

- Clear seasonality and structural trends

- Real, noisy, non-synthetic data

## 4. Methods & Tools
**Programming language:** R

**Key techniques:**
- Exploratory Data Analysis (EDA)
- Time series decomposition (trend / seasonality / residuals)
- Stationarity testing (ADF test)
- Differencing and transformations
- Autoregressive models (AR, MA, ARMA)
- Model diagnostics and comparison
- Forecasting and confidence intervals

## 5. Key Steps
#### 1. Exploratory analysis
Visual inspection of trends, volatility, and seasonal effects.

<img width="1184" height="751" alt="image" src="https://github.com/user-attachments/assets/de1ec0b3-6255-40cd-bdb2-e757efe126c9" />


#### 2. Stationarity assessment
Statistical testing and differencing to meet model assumptions.

<p align="center">
  <img src="https://github.com/user-attachments/assets/57fc9464-02e4-409d-adf5-07c08ac2c8b0" width="45%" />
  <img src="https://github.com/user-attachments/assets/8597ce5c-7751-4ef3-a87d-badfcb27cabc" width="45%" />
</p>





#### 3.Model construction
Building and comparing autoregressive models with different parameters.

#### 4.Evaluation & forecasting
Assessing model fit and generating forecasts with uncertainty bounds.
<p align="center">
  <img src="https://github.com/user-attachments/assets/f944f18f-56b2-4263-9060-3cc21467bfe4" width="45%" />
  <img src="https://github.com/user-attachments/assets/607921e0-4ce5-4f98-b36f-dbced227dd98" width="45%" />
</p>


## 6. Results & Insights
- Strong seasonal patterns and long-term trends were identified in the analyzed series.
- Proper differencing significantly improved model stability.
- Classical autoregressive models can capture short-term dynamics, but their predictive power decreases with longer horizons.
- The project highlights the trade-off between model simplicity and forecasting accuracy in real economic data.

Report in details included in Time_series.pdf.
