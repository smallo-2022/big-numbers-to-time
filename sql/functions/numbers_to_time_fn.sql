/*
    Author: Scott Mallory
    Email: scott.mallory@gmail.com
    LinkedIn: https://www.linkedin.com/in/scott-mallory/
    
    File Name: numbers_to_time_fn.sql
*/
CREATE OR REPLACE FUNCTION numbers_to_time_fn(in p_money numeric)
RETURNS text AS $$
DECLARE
    /* for super accuracy(tm) use leap time year and month       */
    /* src https://www.jpl.nasa.gov/edu/pdfs/leapday_answers.pdf */
    /*                            s    m    h    y               */
    secs_in_lp_mt       numeric = 60 * 60 * 24 * 30.43685;
    secs_in_lp_yr       numeric = 60 * 60 * 24 * 365.2422;

    /* approximate year and month                                */
    secs_in_min         numeric = 60;
    secs_in_hour        numeric = 60 * 60;
    secs_in_dy          numeric = 60 * 60 * 24;
    secs_in_mt          numeric = 60 * 60 * 24 * 30;
    secs_in_yr          numeric = 60 * 60 * 24 * 365;

    v_secs              int;
    v_minute            int;
    v_hour              int;
    v_day               int;
    v_month             int;
    v_year              int;

    v_minute_remainder  numeric;
    v_hour_remainder    numeric;
    v_day_remainder     numeric;
    v_month_remainder   numeric;
    v_year_remainder    numeric;

    r_long_text         text;
    r_result            text;

BEGIN
    
    /* Round down */
    SELECT floor(p_money / secs_in_yr) INTO v_year;
    /* Get the remainder */
    SELECT (p_money % secs_in_yr) INTO v_year_remainder;

    SELECT floor(v_year_remainder / secs_in_mt) INTO v_month;
    SELECT (v_year_remainder % secs_in_mt) INTO v_month_remainder;

    SELECT floor(v_month_remainder / secs_in_dy ) INTO v_day;
    SELECT (v_month_remainder % secs_in_dy ) INTO v_day_remainder;

    SELECT floor(v_day_remainder / secs_in_hour ) INTO v_hour;
    SELECT (v_day_remainder % secs_in_hour ) INTO v_hour_remainder;

    SELECT floor(v_hour_remainder / secs_in_min ) INTO v_minute;
    SELECT (v_hour_remainder % secs_in_min ) INTO v_secs;

    /* Pretty words for big numbers */
    SELECT number_to_words_fn(p_money::bigint) INTO r_long_text;

    /* Simple OUTPUT format 
     * This could be JSON formatted or whatever... 
     * Go nuts 
     */
    r_result = format('You entered: %1$s.'
    || chr(10) || 'Which written out is: %2$s dollars.'
    || chr(10) || 'Now, consider if 1 Dollar (USD) is equal to 1 Second, then `money as time` can expressed as: '
    || chr(10) || '%3$s years %4$s months %5$s days %6$s hours %7$s seconds'
    , cast(p_money as money) , r_long_text, to_char(v_year, 'FM9,999,999,999'), v_month, v_day, v_hour, v_minute, v_secs);

    RETURN r_result;
END
$$ LANGUAGE plpgsql;
