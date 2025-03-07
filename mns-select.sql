--T2-mns-select.sql

--Name: Abhishek Adhikary

/* Comments:
I have considered all null situtations, including provider title, first name and last name.
I have used trim before patient name for no spaces.
I have +ve and -ve scenarios as well.
I have considered the null values as well by using nvl.
*/

/*
List the id, description, standard cost and stock of all items which have a stock of at
least 50 items (a minimum of 50) and include the word composite in their item
description. Show the items with the highest stock first. If two items have the same
number of items on hand (stock), order them by their respective item id.
*/


SELECT
    item_id,
    item_desc,
    item_stdcost,
    item_stock
FROM
    mns.item
WHERE
        item_stock >= 50
    AND item_desc LIKE '%composite%'
ORDER BY
    item_stock DESC,
    item_id;

/*
List the provider code and provider name in the form of Title. FirstName LastName (e.g.
Dr. Bruce Striplin) for all providers who specialise in the area of PAEDIATRIC
DENTISTRY (this is the specialisation description). Order the list by the providers’ last
name and within this, if two providers have the same last name, order them by their
respective first names, then by their provider codes.
*/


SELECT
    p.provider_code,
    CASE
        WHEN p.provider_fname IS NULL THEN
            p.provider_title
            || '. '
            || p.provider_lname
        WHEN p.provider_title IS NULL THEN
            p.provider_fname
            || ' '
            || p.provider_lname
        WHEN p.provider_lname IS NULL THEN
            p.provider_title
            || '. '
            || p.provider_fname
        ELSE
            p.provider_title
            || '. '
            || p.provider_fname
            || ' '
            || p.provider_lname
    END AS provider_name
FROM
         mns.provider p
    JOIN mns.specialisation s ON p.spec_id = s.spec_id
WHERE
    upper(s.spec_name) = upper('PAEDIATRIC DENTISTRY')
ORDER BY
    p.provider_lname,
    p.provider_fname,
    p.provider_title;

/*
List the service code, description, and standard fee where the service is more expensive
than the average standard fee for all services. The output must show the most expensive
service first. The service standard fee must be right aligned and displayed with two decimal
digits and a leading $ symbol, for example as $250.50. Where two or more services have
the same standard fee, order the output by service code.
*/


SELECT
    service_code,
    service_desc,
    lpad(to_char(service_stdfee, '$99990.00'),
         20,
         ' ') AS service_stdfee
FROM
    mns.service
WHERE
    service_stdfee >= (
        SELECT
            AVG(service_stdfee)
        FROM
            mns.service
    )
ORDER BY
    service_stdfee DESC,
    service_code;

/*
List the appointment number, appointment date time, patient number, patient full name and
appointment total cost (service fee/s + item fee/s) for the most expensive appointment/s.
The appointment total cost must be right aligned and displayed with two decimal digits and
a leading $ symbol, for example as $2575.50. Where two or more appointments have the
same appointment total cost, order the output by appointment number.
*/

SELECT
    a.appt_no,
    to_char(a.appt_datetime, 'dd-Mon-yyyy hh24:mi') AS appt_datetime,
    p.patient_no,
    TRIM(p.patient_fname
         || ' '
         || p.patient_lname)                             AS patient_fullname,
    lpad(to_char(nvl(aps.apptserv_fee, 0) + nvl(aps.apptserv_itemcost, 0),
                 '$99990.00'),
         20,
         ' ')                                       AS appt_totalcost
FROM
         mns.appointment a
    JOIN mns.patient   p ON a.patient_no = p.patient_no
    JOIN mns.appt_serv aps ON a.appt_no = aps.appt_no
WHERE
    nvl(aps.apptserv_fee, 0) + nvl(aps.apptserv_itemcost, 0) = (
        SELECT
            MAX(nvl(aps.apptserv_fee, 0) + nvl(aps.apptserv_itemcost, 0))
        FROM
                 mns.appointment a
            JOIN mns.patient   p ON a.patient_no = p.patient_no
            JOIN mns.appt_serv aps ON a.appt_no = aps.appt_no
    )
ORDER BY
    ( nvl(aps.apptserv_fee, 0) + nvl(aps.apptserv_itemcost, 0) ) DESC,
    a.appt_no;
    
/*
Given a provider may charge more or less than the standard fee for a service carried out
during an appointment, the MNS administration is interested in finding out what variations
on the fee have been charged across all appointments. The clinic terms the difference
between the average actual charged service fee and the service standard fee as the
"Service Fee Differential"
. For all services which have been carried out during an
appointment, determine the service fee differential. The list should show the service code,
description, standard fee and the service fee differential in service code order.
For example service D001 Oral Examination has a standard fee of $65.00, it may have
been charged on average across all appointments for $75.00 - the fee differential here will
be 75 - 65 that is a fee differential +10.00. If the average charge had been say 57.50 the
fee differential will be -7.50.
*/

SELECT
    s.service_code,
    s.service_desc,
    lpad(to_char(s.service_stdfee, '$9990.00'), 20, ' ') AS service_stdfee,
    CASE
        WHEN AVG(aps.apptserv_fee) >= s.service_stdfee THEN
            lpad(to_char((AVG(aps.apptserv_fee) - s.service_stdfee), 'S9990.00'), 20, ' ')
        ELSE
            lpad(to_char((AVG(aps.apptserv_fee) - s.service_stdfee), '9990.00'), 20, ' ')
    END AS fee_differential
FROM
         mns.service s
    JOIN mns.appt_serv aps ON s.service_code = aps.service_code
GROUP BY
    s.service_code,
    s.service_desc,
    s.service_stdfee
ORDER BY
    s.service_code;

/*
List for all patients the percentage of their appointments which are follow up appointments.
For example if a patient has made three appointments, of which two were followup
appointments then this percentage will be 66.7%. Display the patient number, full name,
current age in years, number of appointments which have been made and the percentage
of those appointments which were followup appointments. The image below shows the
output you are required to produce, you must use the same column headings, data formats
and alignment.
*/


SELECT
    p.patient_no,
    TRIM(p.patient_fname
         || ' '
         || p.patient_lname)                                       AS patientname,
    to_char(sysdate, 'yyyy') - to_char(p.patient_dob, 'yyyy') AS currentage,
    COUNT(a.appt_no)                                          AS numappts,
    CASE
        WHEN nvl(COUNT(appt_prior_apptno),
                 0) = 0 THEN
            lpad('0.0%', 14, ' ')
        ELSE
            lpad(to_char(COUNT(a.appt_prior_apptno) * 100 / COUNT(a.appt_no),
                         '990.9')
                 || '%',
                 14,
                 ' ')
    END                                                       AS followups
FROM
         mns.patient p
    JOIN mns.appointment a ON p.patient_no = a.patient_no
GROUP BY
    p.patient_no,
    p.patient_fname,
    p.patient_lname,
    to_char(sysdate, 'yyyy') - to_char(p.patient_dob, 'yyyy')
ORDER BY
    p.patient_no;

/*
List for ALL providers the number of appointments they have had, the total fees they
have charged and the total quantity of all items that they have used for appointments
which took place between 9 AM on the 10th September 2023 and 5 PM on the 14th
September 2023 (inclusive). If a particular provider has had no appointments in this
period, or did not collect fees, or used no items the output columns must show a dash
(-) The image below shows the output you are required to produce, you must use the
same column headings, data formats and alignment (all output is right aligned).
*/

    
SELECT
    p.provider_code AS pcode,
    CASE
        WHEN COUNT(a.appt_no) = 0 THEN
            lpad('-', 16, ' ')
        ELSE
            lpad(to_char(COUNT(a.appt_no),
                         '999'),
                 16,
                 ' ')
    END             AS numberappts,
    CASE
        WHEN SUM(aps.apptserv_fee) IS NULL THEN
            lpad('-', 13, ' ')
        ELSE
            lpad(to_char(SUM(aps.apptserv_fee),
                         '$99990.00'),
                 13,
                 ' ')
    END             AS totalfees,
    CASE
        WHEN COUNT(apsi.as_item_quantity) = 0 THEN
            lpad('-', 12, ' ')
        ELSE
            lpad(to_char(COUNT(apsi.as_item_quantity),
                         '999'),
                 12,
                 ' ')
    END             AS no_items
FROM
    mns.provider         p
    LEFT OUTER JOIN (
        SELECT
            appt_no,
            provider_code
        FROM
            mns.appointment
        WHERE
            appt_datetime BETWEEN TO_DATE('10-Sep-2023 09:00', 'dd-Mon-yyyy hh24:mi'
            ) AND TO_DATE('14-Sep-2023 17:00', 'dd-Mon-yyyy hh24:mi')
    )                    a ON p.provider_code = a.provider_code
    LEFT OUTER JOIN mns.appt_serv        aps ON a.appt_no = aps.appt_no
    LEFT OUTER JOIN mns.apptservice_item apsi ON a.appt_no = apsi.appt_no
GROUP BY
    p.provider_code
ORDER BY
    p.provider_code;
