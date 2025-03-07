--T3-mns-dm.sql

--Name: Abhishek Adhikary

/* Comments:
The CREATE SEQUENCE statements to create three sequences are provided which is used to provide primary key values for these three tables.
Jonathan Robey is an emergency contact to Laura and Lachlan who are two patient entries and two appointment entries.
Lachlan needed a follow up appointment and that is recorded as an appointment entry.
The follow up appointment of Lachlan was shifted to four days later (i.e. 14 days after the first appointment) and 
that is updated as an appointment entry.
All Dr. Bruce STRIPLIN appointments between 15th September and 22nd September (inclusive) had to be cancelled and those entries
are deleted from the appointment table.
ALL necessary calculations are carried out as part of the SQL code.
The transactions are managed by using suitable commit statements.
*/


DROP SEQUENCE emergency_contact_seq;

CREATE SEQUENCE emergency_contact_seq START WITH 100 INCREMENT BY 5;

DROP SEQUENCE patient_seq;

CREATE SEQUENCE patient_seq START WITH 100 INCREMENT BY 5;

DROP SEQUENCE appointment_seq;

CREATE SEQUENCE appointment_seq START WITH 100 INCREMENT BY 5;



INSERT INTO emergency_contact VALUES (
    emergency_contact_seq.NEXTVAL,
    'Jonathan',
    'Robey',
    '0412523122'
);

COMMIT;

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    NULL,
    '45 Flinder Street',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('25-08-2016', 'dd-mm-yyyy'),
    '0412523122',
    'JonathanRobey@email.com',
    (
        SELECT
            ec_id
        FROM
            emergency_contact
        WHERE
                upper(ec_fname) = upper('Jonathan')
            AND upper(ec_lname) = upper('Robey')
    )
);

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    NULL,
    '45 Flinder Street',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('10-07-2018', 'dd-mm-yyyy'),
    '0412523122',
    'JonathanRobey@email.com',
    (
        SELECT
            ec_id
        FROM
            emergency_contact
        WHERE
                upper(ec_fname) = upper('Jonathan')
            AND upper(ec_lname) = upper('Robey')
    )
);

COMMIT;

INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('04-09-2023 15:30:00', 'dd-mm-yyyy hh24:mi:ss'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
            upper(patient_fname) = upper('Laura')
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    (
        SELECT
            nurse_no
        FROM
            nurse
        WHERE
                upper(nurse_fname) = upper('Chelsea')
            AND upper(nurse_lname) = upper('Ford')
    ),
    NULL
);

INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('04-09-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
            upper(patient_fname) = upper('Lachlan')
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    (
        SELECT
            nurse_no
        FROM
            nurse
        WHERE
                upper(nurse_fname) = upper('Chelsea')
            AND upper(nurse_lname) = upper('Ford')
    ),
    NULL
);

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    *
FROM
    emergency_contact;

SELECT
    *
FROM
    patient;

SELECT
    *
FROM
    appointment;



INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('04-09-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss') + 10,
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'L',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
            upper(patient_fname) = upper('Lachlan')
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    (
        SELECT
            nurse_no
        FROM
            nurse
        WHERE
            upper(nurse_fname) = upper('Katie')
    ),
    (
        SELECT
            appt_no
        FROM
            appointment
        WHERE
                appt_datetime = TO_DATE('04-09-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss'
                )
            AND patient_no = (
                SELECT
                    patient_no
                FROM
                    patient
                WHERE
                    upper(patient_fname) = upper('Lachlan')
            )
            AND provider_code = (
                SELECT
                    provider_code
                FROM
                    provider
                WHERE
                        upper(provider_title) = upper('Dr')
                    AND upper(provider_fname) = upper('Bruce')
                    AND upper(provider_lname) = upper('STRIPLIN')
            )
    )
);

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    *
FROM
    emergency_contact;

SELECT
    *
FROM
    patient;

SELECT
    *
FROM
    appointment;



UPDATE appointment
SET
    appt_datetime = TO_DATE('04-09-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss') + 14
WHERE
        appt_datetime = TO_DATE('14-09-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss')
    AND patient_no = (
        SELECT
            patient_no
        FROM
            patient
        WHERE
            upper(patient_fname) = upper('Lachlan')
    )
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    );

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    *
FROM
    emergency_contact;

SELECT
    *
FROM
    patient;

SELECT
    *
FROM
    appointment;



DELETE FROM appointment
WHERE
    appt_datetime BETWEEN TO_DATE('15-09-2023', 'dd-mm-yyyy') AND TO_DATE('22-09-2023'
    , 'dd-mm-yyyy')
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    );

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    *
FROM
    emergency_contact;

SELECT
    *
FROM
    patient;

SELECT
    *
FROM
    appointment;