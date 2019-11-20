# BankClientProject

Performing Dimensionality Reduction on Bank Marketing Dataset using PCA. 

## Dataset Description:
The data is related with direct marketing campaigns of a Portuguese banking institution. The marketing campaigns were based on phone calls. Often, more than one contact to the same client was required, in order to access if the product (bank term deposit) would be ('yes') or not ('no') subscribed. The classification goal is to predict if the client will subscribe (yes/no) a term deposit (variable y).

## Attribute Information:

### Input variables:
#### bank client data:
1 - age (numeric)\
2 - job : type of job (categorical) 
3 - marital : marital status (categorical)
4 - education (categorical)
5 - default: has credit in default? (categorical)
6 - housing: has housing loan? (categorical)
7 - loan: has personal loan? (categorical)
#### related with the last contact of the current campaign:
8 - contact: contact communication type (categorical)
9 - month: last contact month of year (categorical)
10 - day_of_week: last contact day of the week (categorical)
11 - duration: last contact duration, in seconds (numeric). This attribute highly affects the output target (e.g., if duration=0 then y='no'). 
#### other attributes:
12 - campaign: number of contacts performed during this campaign and for this client (numeric)
13 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric)
14 - previous: number of contacts performed before this campaign and for this client (numeric)
15 - poutcome: outcome of the previous marketing campaign (categorical)
#### social and economic context attributes
16 - emp.var.rate: employment variation rate - quarterly indicator (numeric)
17 - cons.price.idx: consumer price index - monthly indicator (numeric)
18 - cons.conf.idx: consumer confidence index - monthly indicator (numeric)
19 - euribor3m: euribor 3 month rate - daily indicator (numeric)
20 - nr.employed: number of employees - quarterly indicator (numeric)

### Output variable (desired target):
21 - y - has the client subscribed a term deposit? (binary: 'yes','no')
