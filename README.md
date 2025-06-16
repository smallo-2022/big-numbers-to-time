# big-numbers-to-time
This repo contains two simple SQL functions which will convert very large numbers (like money), which most people <b><em>cannot</em></b> appreciate, into an expression of time, which most people <b><em>can</em></b> appreciate. 

The goal is to help anyone understand the scale of wealth.<br>

The SQL functions create a time expression using a simple formula: 
- 1 dollar is equal to 1 second 
- Note that the results are approximate


## The baseline values
<pre>
---------------------------------------------
1 minute    = 60 seconds  (         60 secs )   sixty seconds
1 hour      = 60 minutes  (      3,600 secs )   three thousand six hundred seconds
1 day       = 24 hours    (     86,400 secs )   eighty six thousand four hundred seconds
1 month     = 30 days     (  2,580,000 secs )   two million five hundred eighty thousand seconds
1 year      = 365 days    ( 31,536,000 secs )   thirty one million five hundred thirty six thousand seconds
- leap time yields greater accuracy - 
1 month     = 30.44 days  (  2,630,016 secs )   two million six Hundred thirty thousand sixteen seconds
1 year      = 365.24 days ( 31,556,736 secs )   thirty-one million five hundred fifty-six thousand seven hundred thirty-six seconds
---------------------------------------------
</pre>

## Usage
I wrote these SQL functions in Postgres. They should work for any SQL engine of your choosing (but choose wisely!).<br/>
There are no tables.

`$ select numbers_to_time_fn(<numeric>)`

### Some examples
#### The average American income in 2022 was $74,580.00
<pre>
select numbers_to_time_fn(74580);
-- output
You entered: $74,580.00.
Which written out is: Seventy-Four Thousand Five Hundred Eighty dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
0 years 0 months 0 days 20 hours 43 minutes 0 seconds
</pre>
https://www.census.gov/library/publications/2023/demo/p60-279.html

#### S&P 500 chief executives made $16.7 million on average in 2022
<pre>
select numbers_to_time_fn(16700000);
-- output 
You entered: $16,700,000.00.
Which written out is: Sixteen Million Seven Hundred Thousand dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then `money as time` can expressed as: 
0 years 6 months 13 days 6 hours 53 minutes 20 seconds
</pre>
https://www.reuters.com/business/ceo-pay-averaged-167-million-last-year-sp-500-companies-decline-2023-08-03/


#### Bloomberg Billionaires Index
Changes daily - Top person as of 3/20/24
<pre>
select numbers_to_time_fn(201000000000);
-- output
You entered: $201,000,000,000.00
Which written out is: Two Hundred One Billion dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
6,373 years 8 months 3 days 21 hours 20 minutes 0 seconds
-- note that 1 billion dollars is about 31 years
</pre>

https://www.bloomberg.com/billionaires/


#### National Deficit as of 3/21/24
<pre>
select numbers_to_time_fn(828134668631);
-- output
You entered: $828,134,668,631.00.
Which written out is: Eight Hundred Twenty-Eight Billion One Hundred Thirty-Four Million Six Hundred Sixty-Eight Thousand Six Hundred Thirty-One dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
26,259 years 11 months 26 days 23 hours 57 minutes 11 seconds
</pre>
https://fiscaldata.treasury.gov/americas-finance-guide/national-deficit/

### More examples

<pre>
You entered: $100,000.00.
Which written out is: One Hundred Thousand dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
0 years 0 months 1 days 3 hours 46 minutes 40 seconds
</pre>
<pre>
You entered: $1,000,000.00.
Which written out is: One Million dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
0 years 0 months 11 days 13 hours 46 minutes 40 seconds
</pre>
<pre>
You entered: $100,000,000.00.
Which written out is: One Hundred Million dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
3 years 2 months 2 days 9 hours 46 minutes 40 seconds
</pre>
<pre>
You entered: $1,000,000,000.00.
Which written out is: One Billion dollars.
Now consider if 1 Dollar (USD) is equal to 1 Second, then 'money as time' can expressed as: 
31 years 8 months 19 days 1 hours 46 minutes 40 seconds
</pre>
