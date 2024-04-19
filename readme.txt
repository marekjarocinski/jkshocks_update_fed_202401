Updating Monetary Policy and Central Bank Information shocks originally constructed in:
Jarocinski, M. and Karadi, P. (2020) Deconstructing  Monetary Policy Surprises - The Role of Information Shocks, AEJ:Macro, DOI: 10.1257/mac.20180090

Updated shocks:
shocks_fed_jk_t.csv - Monetary Policy and Central Bank Information shocks, by FOMC announcement, indexed by date-time
shocks_fed_jk_m.csv - Monetary Policy and Central Bank Information shocks, aggregated to monthly frequency (zero if no shocks in a given month)

Construction of the shocks:
main.m - Matlab script (calls other Matlab functions)

Source data: 
fomc_surprises_jk.csv - narrow window (30 minutes) surprises around FOMC announcements from 1988 to 2023 updated by Jarocinski and Karadi.


---

Definitions of the variables in shocks_fed_jk_t.csv and shocks_fed_jk_m.csv:

pc1 - surprise in the "policy indicator", ie the 1st principal component of the surprises in interest rate derivatives with maturities from 1 month to 1 year (MP1, FF4, ED2, ED3, ED4)

sp500 - surprise in the S&P500

MP_pm,CBI_pm - Monetary Policy and Central Bank Information shocks obtained with simple ("Poor Man's") sign restrictions.

MP_median,CBI_median - Monetary Policy and Central Bank Information shocks obtained with the median rotation that implements the sign restrictions.

Construction of the shocks:

For the definition of Monetary Policy and Central Bank Information shocks and the motivation behind the sign restrictions see:
Jarocinski, M. and Karadi, P. (2020) Deconstructing  Monetary Policy Surprises - The Role of Information Shocks, AEJ:Macro, DOI: 10.1257/mac.20180090


More details on the source data fomc_surprises_jk.csv:

Dates and times of FOMC announcements:
From 1997 onwards we take the dates and times from Bloomberg. Before 1997 we take the dates and times from Michael Bauer and Eric Swanson https://www.michaeldbauer.com/files/FOMC_Bauer_Swanson.xlsx

High-frequency financial data sources:
We had access to TickData (1981-2019), Datascope Tick History (1996-2024), Pi Trading (1983-2024), with variables and samples determined by data availability and our licence constraints.

High-frequency financial variables:
FF1,FF2,FF3,FF4 - Fed Funds futures - Sources: Datascope Tick History from 1996 onwards; before 1996 we take these data from the Gurkaynak, Sack and Swanson (2005) dataset.
MP1 - obtained from FF1 and FF2 as in Gurkaynak, Sack and Swanson (2005)
ED1,ED2,ED3,ED4 - Eurodollar futures - Sources: TickData (until 2019), Datascope Tick History (2019-2022); from January 2023 onwards we use SOFR futures from Datascope Tick History
TFUT02,TFUT05,TFUT10,TFUT30 - Treasury futures (2,5,10,30 years) - Sources: TickData (until 2019), Datascope Tick History (2019-2024)
SP500 - S&P 500 stock index - pitrading.com
SP500FUT - S&P 500 futures - Sources: TickData (until 2008), from 2008 onwards we use E-mini S&P 500 futures from Datascope Tick History

Computation of the surprises:
- We aggregate high-frequency data to one-minute frequency.
- We compute the surprises over a 30-minute window as the value representing the variable 20 minutes after the announcement minus the value representing the variable 10 minutes before the announcement.
- The value representing the variable 20 minutes after the announcement is computed as the median in the window [t+15min,t+25min), where t is the time of the announcement. If there are less than 3 observations in this window, we extend the window until it includes 3 observations but by at most 24 hours. If even the 24 hour window includes no observations we record a missing value.
- The value representing the variable 10 minutes before the announcement is computed as the median in the window (t-15min,t-5min], and we proceed analogously in case this window has less than 3 observations.


Marek Jarocinski marek.jarocinski@ecb.europa.eu
Peter Karadi peter.karadi@ecb.europa.eu
