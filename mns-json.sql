--T3-mns-json.sql

--Name: Abhishek Adhikary

/* Comments:
I have considered all null situtations, including provider title, first name and last name.
*/

/*
Write an SQL statement in T3-mns-json.sql to generate a collection of JSON documents
using the following structure/format from the MNS tables. Each document in the collection
represents an appointment’s provider and item details. The list must only include
appointments which used at least one item.
*/

SET PAGESIZE 300

SELECT
        JSON_OBJECT(
            '_id' VALUE appt_no,
                    'datetime' VALUE to_char(appt_datetime, 'dd/mm/yyyy hh24:mi'),
                    'provider_code' VALUE provider_code,
                    'provider_name' VALUE
                CASE
                    WHEN provider_fname IS NULL THEN
                        provider_title
                        || '. '
                        || provider_lname
                    WHEN provider_title IS NULL THEN
                        provider_fname
                        || ' '
                        || provider_lname
                    WHEN provider_lname IS NULL THEN
                        provider_title
                        || '. '
                        || provider_fname
                    ELSE
                        provider_title
                        || '. '
                        || provider_fname
                        || ' '
                        || provider_lname
                END,
                    'item_totalcost' VALUE SUM(item_stdcost * as_item_quantity),
                    'no_of_items' VALUE SUM(as_item_quantity),
                    'items' VALUE JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE item_id,
                    'desc' VALUE item_desc,
                    'standardcost' VALUE item_stdcost,
                    'quantity' VALUE as_item_quantity
                )
            )
        FORMAT JSON)
        || ','
FROM
         mns.appointment
    NATURAL JOIN mns.provider
    NATURAL JOIN mns.apptservice_item
    NATURAL JOIN mns.item
GROUP BY
    appt_no,
    appt_datetime,
    provider_code,
    provider_title,
    provider_fname,
    provider_lname
ORDER BY
    appt_no;