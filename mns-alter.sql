--T4-mns-alter.sql

--Name: Abhishek Adhikary


/* Comments:
Before carrying out the work below, it is ensured that tasks 1, 2 and 3 are completed.
ALL necessary calculations are carried out as part of the SQL code.
Select statement is used to show any data changes which have occurred and desc tablename is used to show any table structural changes.
The total number of appointments for each patient in the system are calucated by adding a new attribute.
A patient is allowed to register more than one emergency contact person if they wish. The database 
is changed to meet this requirement. A new table is added to suit this many-many relationship.
To ensure that nurse skills are kept up to date, nurses may be required to undertake initial/refresher training. This training 
is provided by other nurses. A given nurse may be trained by many other nurses. A given nurse may act as a trainer for many 
other nurses. The database is changed to meet this requirement. Three new tables are added which takes into consideration the 3nf form
and the any-many relationships.
The transactions are managed by using suitable commit statements.
*/


ALTER TABLE patient ADD (
    patient_total_appts NUMBER(2) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN patient.patient_total_appts IS
    'The total number of appointments for each patient';

UPDATE patient p
SET
    patient_total_appts = (
        SELECT
            COUNT(appt_no)
        FROM
            appointment a
        WHERE
            a.patient_no = p.patient_no
    );

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    patient_no,
    patient_fname
    || ' '
    || patient_lname AS patient_fullname,
    patient_total_appts
FROM
    patient
ORDER BY
    patient_no;

DESC patient;



DROP TABLE emergency_contact_patient CASCADE CONSTRAINTS;

CREATE TABLE emergency_contact_patient (
    ec_p_no    NUMBER(4),
    patient_no NUMBER(4),
    ec_id      NUMBER(8) NOT NULL
);

COMMENT ON COLUMN emergency_contact_patient.ec_p_no IS
    'EmergencyContact_Patient number (identifier)';

COMMENT ON COLUMN emergency_contact_patient.patient_no IS
    'Patient number of the patient';

COMMENT ON COLUMN emergency_contact_patient.ec_id IS
    'Emergency Contact identifier';

ALTER TABLE emergency_contact_patient ADD CONSTRAINT ec_patient_pk PRIMARY KEY ( ec_p_no
);

ALTER TABLE emergency_contact_patient ADD CONSTRAINT ec_patient_un UNIQUE ( patient_no
,
                                                                            ec_id );

ALTER TABLE emergency_contact_patient
    ADD CONSTRAINT ec_patient_patient_fk FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE emergency_contact_patient
    ADD CONSTRAINT ec_patient_emergency_contact_fk FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );

DROP SEQUENCE emergency_contact_patient_seq;

CREATE SEQUENCE emergency_contact_patient_seq START WITH 100 INCREMENT BY 5;

INSERT INTO emergency_contact_patient (
    ec_p_no,
    patient_no,
    ec_id
)
    SELECT
        emergency_contact_patient_seq.NEXTVAL,
        p.patient_no,
        ec.ec_id
    FROM
             patient p
        JOIN emergency_contact ec ON p.ec_id = ec.ec_id;

COMMIT;

ALTER TABLE patient ADD ec_p_no NUMBER(4);

COMMENT ON COLUMN patient.ec_p_no IS
    'EmergencyContact_Patient number';

UPDATE patient p
SET
    p.ec_p_no = (
        SELECT
            ecp.ec_p_no
        FROM
            emergency_contact_patient ecp
        WHERE
            ecp.patient_no = p.patient_no
    );

COMMIT;

/*

Note: the use of selects here AFTER the transaction is to prove that the DML
made the required changes, i.e. this is being used as a POST transaction check. 

*/

SELECT
    ecp.ec_p_no,
    p.patient_no,
    ec.ec_id,
    ec.ec_fname
    || ' '
    || ec.ec_lname AS emergency_contact_fullname
FROM
         patient p
    JOIN emergency_contact_patient ecp ON p.ec_p_no = ecp.ec_p_no
    JOIN emergency_contact         ec ON ecp.ec_id = ec.ec_id;

DESC patient;
DESC emergency_contact_patient;



DROP TABLE training CASCADE CONSTRAINTS;

DROP TABLE nurse_trainer CASCADE CONSTRAINTS;

DROP TABLE nurse_training CASCADE CONSTRAINTS;

CREATE TABLE training (
    training_no             NUMBER(3) NOT NULL,
    nurse_trainer_no        NUMBER(3) NOT NULL,
    training_start_datetime DATE NOT NULL,
    training_end_datetime   DATE NOT NULL,
    training_description    VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN training.training_no IS
    'Training identifier (unique)';

COMMENT ON COLUMN training.nurse_trainer_no IS
    'Nurse trainer number';

COMMENT ON COLUMN training.training_description IS
    'Training description';

COMMENT ON COLUMN training.training_start_datetime IS
    'Training start date and time';

COMMENT ON COLUMN training.training_end_datetime IS
    'Training start date and time';

ALTER TABLE training ADD CONSTRAINT training_pk PRIMARY KEY ( training_no );

ALTER TABLE training
    ADD CONSTRAINT training_un UNIQUE ( nurse_trainer_no,
                                        training_start_datetime,
                                        training_end_datetime );

CREATE TABLE nurse_trainer (
    nurse_trainer_no    NUMBER(3) NOT NULL,
    nurse_trainer_fname VARCHAR2(30),
    nurse_trainer_lname VARCHAR2(30)
);

COMMENT ON COLUMN nurse_trainer.nurse_trainer_no IS
    'Nurse trainer number(identifier)';

COMMENT ON COLUMN nurse_trainer.nurse_trainer_fname IS
    'Nurse trainer first name';

COMMENT ON COLUMN nurse_trainer.nurse_trainer_lname IS
    'Nurse trainer last name';

ALTER TABLE nurse_trainer ADD CONSTRAINT nurse_trainer_pk PRIMARY KEY ( nurse_trainer_no
);

CREATE TABLE nurse_training (
    training_no NUMBER(3) NOT NULL,
    nurse_no    NUMBER(3) NOT NULL
);

COMMENT ON COLUMN nurse_training.training_no IS
    'Training identifier (unique)';

COMMENT ON COLUMN nurse_training.nurse_no IS
    'Nurse identifier (unique)';

ALTER TABLE nurse_training ADD CONSTRAINT nurse_training_pk PRIMARY KEY ( training_no
,
                                                                          nurse_no );
                                                                        
-- Adding all missing FK Constraints below here

ALTER TABLE training
    ADD CONSTRAINT training_nurse_trainer_fk FOREIGN KEY ( nurse_trainer_no )
        REFERENCES nurse_trainer ( nurse_trainer_no );

ALTER TABLE nurse_training
    ADD CONSTRAINT nurse_training_training_fk FOREIGN KEY ( training_no )
        REFERENCES training ( training_no );

ALTER TABLE nurse_training
    ADD CONSTRAINT nurse_training_nurse_fk FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

DESC nurse;
DESC nurse_trainer;
DESC nurse_training;
DESC training;