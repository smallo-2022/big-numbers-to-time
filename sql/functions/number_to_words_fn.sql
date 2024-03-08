/*
    Author: Scott Mallory
    Email: scott.mallory@gmail.com
    LinkedIn: https://www.linkedin.com/in/scott-mallory/

    File Name: number_to_words_fn.sql
    Original file:
    https://www.postgresql.org/message-id/5192AD58.3000807%40hogranch.com
*/

CREATE OR REPLACE FUNCTION number_to_words_fn(n bigint)
RETURNS TEXT as $$
DECLARE
    e       TEXT;

    hu      int = pow(10, 2);       -- Hundred
    th      int = pow(10, 3);       -- Thousand
    mi      int = pow(10, 6);       -- Million
    bi      int = pow(10, 9);       -- Billion
    tr      bigint = pow(10, 12);   -- Trillion
    qu      bigint = pow(10, 15);   -- Quadrillion
    qi      bigint = pow(10, 18);   -- Quintillion

    -- https://en.wikipedia.org/wiki/Long_and_short_scales
    hu_9    bigint = repeat ('9', 3)::bigint;
    th_9    bigint = repeat ('9', 6)::bigint;
    mi_9    bigint = repeat ('9', 9)::bigint;
    bi_9    bigint = repeat ('9', 12)::bigint;
    tr_9    bigint = repeat ('9', 15)::bigint;
    qu_9    bigint = repeat ('9', 18)::bigint;
    qi_9    decimal = repeat ('9', 21)::decimal;

BEGIN

    WITH Below20(Word, Id) AS
        ( VALUES
            ('Zero', 0), ('One', 1),( 'Two', 2 ), ( 'Three', 3),
            ( 'Four', 4 ), ( 'Five', 5 ), ( 'Six', 6 ), ( 'Seven', 7 ),
            ( 'Eight', 8), ( 'Nine', 9), ( 'Ten', 10), ( 'Eleven', 11 ),
            ( 'Twelve', 12 ), ( 'Thirteen', 13 ), ( 'Fourteen', 14),
            ( 'Fifteen', 15 ), ('Sixteen', 16 ), ( 'Seventeen', 17),
            ('Eighteen', 18 ), ( 'Nineteen', 19 )
    ), Below100(Word, Id) AS
        ( VALUES
            ('Twenty', 2), ('Thirty', 3),('Forty', 4), ('Fifty', 5),
            ('Sixty', 6), ('Seventy', 7), ('Eighty', 8), ('Ninety', 9)
        )

    SELECT CASE
        WHEN n = 0 THEN  ''
        WHEN n BETWEEN 1 AND 19
            THEN (SELECT Word FROM Below20 WHERE ID = n)

        WHEN n BETWEEN 20 AND 99
            THEN (SELECT Word FROM Below100 WHERE ID = n/10) || '-' || number_to_words_fn( n % 10)

        WHEN n BETWEEN hu AND hu_9
            THEN (number_to_words_fn( n / hu)) || ' Hundred ' || number_to_words_fn( n % hu)

        WHEN n BETWEEN th AND th_9
            THEN (number_to_words_fn( n / th )) || ' Thousand ' || number_to_words_fn( n % th)

        WHEN n BETWEEN mi AND mi_9
            THEN (number_to_words_fn( n / mi )) || ' Million ' || number_to_words_fn( n % mi)

        WHEN n BETWEEN bi AND bi_9
            THEN (number_to_words_fn( n / bi )) || ' Billion ' || number_to_words_fn( n % bi)

        WHEN n BETWEEN tr AND tr_9
            THEN (number_to_words_fn( n / tr )) || ' Trillion ' || number_to_words_fn( n % tr)

        WHEN n BETWEEN qu AND qu_9
            THEN (number_to_words_fn( n / qu )) || ' Quadrillion ' || number_to_words_fn( n % qu)

        WHEN n BETWEEN qi AND qi_9
            THEN (number_to_words_fn( n / qi )) || ' Quintillion ' || number_to_words_fn( n % qi)

        ELSE ' INVALID INPUT'
        END
    INTO e;

  e := RTRIM(e);

  IF RIGHT(e, 1 ) = '-' THEN
    e := RTRIM(LEFT(e, length(e)-1));
  END IF;

  RETURN e;
END;
$$ LANGUAGE PLPGSQL;
