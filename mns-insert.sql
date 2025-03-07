--T2-mns-insert.sql

--Name: Abhishek Adhikary

/* Comments:
The EMERGENCY_CONTACT, PATIENT and APPOINTMENT tables are loaded with my own test data using the supplied T2-mns-insert.sql script file.
It is ensured that the data inserted will make full use of the various features coded in Task1.
All the data added is treated as a single transaction since we are setting up the initial test state for the database.
The primary key values for this data are hardcoded values.
The data added must be sensible (e.g. the patient data must mimic the real data; the
patient, provider, nurse and room must not be double booked; the following appointment for a provider must not be 
scheduled before the previous appointment for that provider is completed; and other real scenario constraints).
*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
INSERT INTO emergency_contact VALUES (
    1,
    'Lionel',
    'Messi',
    '0458990878'
);

INSERT INTO emergency_contact VALUES (
    2,
    'Cristiano',
    'Ronaldo',
    '0477590998'
);

INSERT INTO emergency_contact VALUES (
    3,
    'Neymar',
    NULL,
    '0466778996'
);

INSERT INTO emergency_contact VALUES (
    4,
    NULL,
    'Pele',
    '0476876676'
);

INSERT INTO emergency_contact VALUES (
    5,
    'Diego',
    'Maraddona',
    '0498789997'
);

--------------------------------------
--INSERT INTO patient
--------------------------------------
INSERT INTO patient VALUES (
    1,
    'Virat',
    'Kohli',
    '1 Main Rd',
    'Clayton South',
    'VIC',
    '3169',
    TO_DATE('15-04-1987', 'dd-mm-yyyy'),
    '0451678900',
    'vk18@email.com',
    2
);

INSERT INTO patient VALUES (
    2,
    NULL,
    'de Villiers',
    '17 South Street',
    'Adelaide',
    'SA',
    '5015',
    TO_DATE('18-08-1985', 'dd-mm-yyyy'),
    '0458976767',
    'abd17@email.com',
    4
);

INSERT INTO patient VALUES (
    3,
    'Sourav',
    'Ganguly',
    '15 West Rd',
    'Sydney',
    'NSW',
    '2000',
    TO_DATE('11-07-1975', 'dd-mm-yyyy'),
    '0446787906',
    'dada@email.com',
    5
);

INSERT INTO patient VALUES (
    4,
    'Sachin',
    'Tendulkar',
    '100 Southern Ave',
    'Perth',
    'WA',
    '1150',
    TO_DATE('25-03-1986', 'dd-mm-yyyy'),
    '5551234567',
    'srt10@email.com',
    5
);

INSERT INTO patient VALUES (
    5,
    'Virushka',
    NULL,
    '1 Main Rd',
    'Clayton South',
    'VIC',
    '3169',
    TO_DATE('15-04-2020', 'dd-mm-yyyy'),
    '0451678900',
    'virushka@email.com',
    2
);

INSERT INTO patient VALUES (
    6,
    NULL,
    'Dhoni',
    '97 East Bvd',
    'Brisbane',
    'QLD',
    '6060',
    TO_DATE('17-07-1980', 'dd-mm-yyyy'),
    '0467890696',
    'msd@email.com',
    3
);

INSERT INTO patient VALUES (
    7,
    'Ziva',
    'Dhoni',
    '97 East Bvd',
    'Brisbane',
    'QLD',
    '6060',
    TO_DATE('15-04-2015', 'dd-mm-yyyy'),
    '0467890696',
    'ziva@email.com',
    3
);

INSERT INTO patient VALUES (
    8,
    'Thiago',
    'Messi',
    '45 White Ave',
    'Hobart',
    'TAS',
    '8900',
    TO_DATE('23-05-2009', 'dd-mm-yyyy'),
    '0451234567',
    'thiagomessi@email.com',
    1
);

INSERT INTO patient VALUES (
    9,
    'Mateo',
    'Messi',
    '45 White Ave',
    'Hobart',
    'TAS',
    '8900',
    TO_DATE('05-08-2014', 'dd-mm-yyyy'),
    '0451234567',
    'mateomessi@email.com',
    1
);

INSERT INTO patient VALUES (
    10,
    'Ciro',
    NULL,
    '45 White Ave',
    'Hobart',
    'TAS',
    '8900',
    TO_DATE('15-04-2018', 'dd-mm-yyyy'),
    '0451234567',
    'ciromessi@email.com',
    1
);

--------------------------------------
--INSERT INTO appointment
--------------------------------------
INSERT INTO appointment VALUES (
    1,
    TO_DATE('16-05-2023 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    2,
    'S',
    8,
    'GEN001',
    1,
    NULL
);

INSERT INTO appointment VALUES (
    2,
    TO_DATE('16-05-2023 13:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    3,
    'S',
    9,
    'GEN002',
    2,
    NULL
);

INSERT INTO appointment VALUES (
    3,
    TO_DATE('16-05-2023 14:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    4,
    'S',
    10,
    'GEN003',
    3,
    NULL
);

INSERT INTO appointment VALUES (
    4,
    TO_DATE('16-05-2023 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    6,
    'T',
    3,
    'PED001',
    5,
    NULL
);

INSERT INTO appointment VALUES (
    5,
    TO_DATE('16-05-2023 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    7,
    'T',
    4,
    'PED002',
    6,
    NULL
);

INSERT INTO appointment VALUES (
    6,
    TO_DATE('24-06-2023 11:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    11,
    'L',
    3,
    'PER001',
    12,
    4
);

INSERT INTO appointment VALUES (
    7,
    TO_DATE('24-06-2023 13:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    13,
    'L',
    4,
    'PRO001',
    15,
    5
);

INSERT INTO appointment VALUES (
    8,
    TO_DATE('24-06-2023 13:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    10,
    'T',
    7,
    'AST002',
    9,
    NULL
);

INSERT INTO appointment VALUES (
    9,
    TO_DATE('24-06-2023 13:30:00', 'dd-mm-yyyy hh24:mi:ss'),
    4,
    'S',
    5,
    'GEN003',
    3,
    NULL
);

INSERT INTO appointment VALUES (
    10,
    TO_DATE('24-06-2023 14:30:00', 'dd-mm-yyyy hh24:mi:ss'),
    2,
    'S',
    2,
    'GEN001',
    1,
    NULL
);

INSERT INTO appointment VALUES (
    11,
    TO_DATE('15-07-2023 09:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    7,
    'T',
    4,
    'PED002',
    6,
    7
);

INSERT INTO appointment VALUES (
    12,
    TO_DATE('15-07-2023 09:30:00', 'dd-mm-yyyy hh24:mi:ss'),
    8,
    'T',
    1,
    'ORT001',
    14,
    NULL
);

INSERT INTO appointment VALUES (
    13,
    TO_DATE('15-07-2023 12:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    9,
    'T',
    6,
    'AST001',
    9,
    NULL
);

INSERT INTO appointment VALUES (
    14,
    TO_DATE('15-07-2023 11:30:00', 'dd-mm-yyyy hh24:mi:ss'),
    13,
    'L',
    5,
    'PRO001',
    15,
    NULL
);

INSERT INTO appointment VALUES (
    15,
    TO_DATE('15-07-2023 15:00:00', 'dd-mm-yyyy hh24:mi:ss'),
    13,
    'L',
    7,
    'PRO001',
    15,
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