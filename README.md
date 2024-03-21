# big-numbers-to-time
This repo contains two simple SQL functions which will convert very large numbers (like money), which most people <b><em>cannot</em></b> appreciate, into an expression of time, which most people <b><em>can</em></b> appreciate. 

The goal is to help anyone understand the scale of wealth.<br/>

The SQL functions create a time expression using a simple formula: 
- 1 dollar is equal to 1 second 
- The results are approximate 


## The baseline values
<pre>
--------------------------------------------
1 minute    = 60 seconds  (         60 secs )   sixty seconds
1 hour      = 60 minutes  (      3,600 secs )   three thousand six hundred seconds
1 day       = 24 hours    (     86,400 secs )   eighty six thousand four hundred seconds
1 month     = 30 days     (  2,580,000 secs )   two million five hundred eighty thousand seconds
1 year      = 365 days    ( 31,536,000 secs )   thirty one million five hundred thirty six thousand seconds
- for leap time - 
1 month     = 30.44 days  (  2,630,016 secs )   two million six Hundred thirty thousand sixteen seconds
1 year      = 365.24 days ( 31,556,736 secs )   thirty-one million five hundred fifty-six thousand seven hundred thirty-six seconds
--------------------------------------------
</pre>

## Some big numbers

How many days in 1 hundred thousand seconds?
- 100,000 / 86,400 = 1.2 days

How many days in 1 million seconds?
- 1,000,000 / 86,400 = 11.6 days

How many days in 1 billion seconds?
- 1,000,000,000 / 86,400 = 11,627.9 days = 31.9 years
