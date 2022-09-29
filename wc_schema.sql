-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-04-28 02:21:55 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

--   group no:  13
--   names:     Lam Kim Ze, Vincent Yao, Jeremy Cameron

-- Capture run of script in file called wc_schema_output.txt
set echo on
SPOOL wc_schema_output.txt;

DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE cabin CASCADE CONSTRAINTS;

DROP TABLE comm_lang CASCADE CONSTRAINTS;

DROP TABLE country CASCADE CONSTRAINTS;

DROP TABLE cruise CASCADE CONSTRAINTS;

DROP TABLE language CASCADE CONSTRAINTS;

DROP TABLE manifest CASCADE CONSTRAINTS;

DROP TABLE operator CASCADE CONSTRAINTS;

DROP TABLE passenger CASCADE CONSTRAINTS;

DROP TABLE port CASCADE CONSTRAINTS;

DROP TABLE port_temp CASCADE CONSTRAINTS;

DROP TABLE ship CASCADE CONSTRAINTS;

DROP TABLE tour CASCADE CONSTRAINTS;

DROP TABLE tour_availability CASCADE CONSTRAINTS;

DROP TABLE tour_off CASCADE CONSTRAINTS;

DROP TABLE tour_part CASCADE CONSTRAINTS;

DROP TABLE visit CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    add_id       NUMBER(8) NOT NULL,
    add_street   VARCHAR2(50 CHAR) NOT NULL,
    add_suburb   VARCHAR2(50 CHAR) NOT NULL,
    add_postcode CHAR(4 CHAR) NOT NULL,
    add_country  VARCHAR2(50 CHAR) NOT NULL
);

COMMENT ON COLUMN address.add_id IS
    'A unique address ID as a surrogate key for the passenger''s address';

COMMENT ON COLUMN address.add_street IS
    'Address street';

COMMENT ON COLUMN address.add_suburb IS
    'Address suburb';

COMMENT ON COLUMN address.add_postcode IS
    'Address postcode';

COMMENT ON COLUMN address.add_country IS
    'Address country';

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( add_id );

ALTER TABLE address
    ADD CONSTRAINT address_nk UNIQUE ( add_street,
                                       add_suburb,
                                       add_postcode,
                                       add_country );

CREATE TABLE cabin (
    ship_code NUMBER(7) NOT NULL,
    cab_num   NUMBER(5) NOT NULL,
    cab_class VARCHAR2(10) NOT NULL
);

ALTER TABLE cabin
    ADD CONSTRAINT chk_cabin_class CHECK ( cab_class IN ( 'balcony', 'interior', 'ocean view',
    'suite' ) );

COMMENT ON COLUMN cabin.ship_code IS
    'Ship code to identify ship';

COMMENT ON COLUMN cabin.cab_num IS
    'Cabin number';

COMMENT ON COLUMN cabin.cab_class IS
    'Cabin class';

ALTER TABLE cabin ADD CONSTRAINT cabin_pk PRIMARY KEY ( ship_code,
                                                        cab_num );

CREATE TABLE comm_lang (
    port_code CHAR(5 CHAR) NOT NULL,
    tour_no   VARCHAR2(2 CHAR) NOT NULL,
    lang_code CHAR(2) NOT NULL
);

COMMENT ON COLUMN comm_lang.port_code IS
    'Port code';

COMMENT ON COLUMN comm_lang.tour_no IS
    'Tour number';

COMMENT ON COLUMN comm_lang.lang_code IS
    'Language represented using  ISO 3166-1 Alpha-2 codes';

ALTER TABLE comm_lang
    ADD CONSTRAINT comm_lang_pk PRIMARY KEY ( lang_code,
                                              port_code,
                                              tour_no );

CREATE TABLE country (
    country_code CHAR(2 CHAR) NOT NULL,
    country_name VARCHAR2(30 CHAR) NOT NULL
);

COMMENT ON COLUMN country.country_code IS
    'Country code in ISO 3166-1 Alpha-2';

COMMENT ON COLUMN country.country_name IS
    'Country name';

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_code );

CREATE TABLE cruise (
    cruise_id   NUMBER(7) NOT NULL,
    cruise_name VARCHAR2(50 CHAR) NOT NULL,
    cruise_desc VARCHAR2(100 CHAR) NOT NULL,
    ship_code   NUMBER(7) NOT NULL
);

COMMENT ON COLUMN cruise.cruise_id IS
    'ID of the cruise';

COMMENT ON COLUMN cruise.cruise_name IS
    'Cruise name';

COMMENT ON COLUMN cruise.cruise_desc IS
    'Cruise description';

COMMENT ON COLUMN cruise.ship_code IS
    'Ship code to identify ship';

ALTER TABLE cruise ADD CONSTRAINT cruise_pk PRIMARY KEY ( cruise_id );

CREATE TABLE language (
    lang_code CHAR(2) NOT NULL,
    lang_name VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN language.lang_code IS
    'Language represented using  ISO 3166-1 Alpha-2 codes';

COMMENT ON COLUMN language.lang_name IS
    'Languange full name';

ALTER TABLE language ADD CONSTRAINT language_pk PRIMARY KEY ( lang_code );

CREATE TABLE manifest (
    cruise_id                  NUMBER(7) NOT NULL,
    pass_id                    NUMBER(8) NOT NULL,
    manifest_boarding_datetime DATE NOT NULL,
    ship_code                  NUMBER(7) NOT NULL,
    cab_num                    NUMBER(5) NOT NULL
);

COMMENT ON COLUMN manifest.cruise_id IS
    'ID of the cruise';

COMMENT ON COLUMN manifest.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN manifest.manifest_boarding_datetime IS
    'Boarding date and time of passenger';

COMMENT ON COLUMN manifest.ship_code IS
    'Ship code to identify ship';

COMMENT ON COLUMN manifest.cab_num IS
    'Cabin number';

ALTER TABLE manifest ADD CONSTRAINT manifest_pk PRIMARY KEY ( cruise_id,
                                                              pass_id );

CREATE TABLE operator (
    op_id        NUMBER(8) NOT NULL,
    op_comp_name VARCHAR2(50 CHAR) NOT NULL,
    op_ceo_name  VARCHAR2(50 CHAR) NOT NULL
);

COMMENT ON COLUMN operator.op_id IS
    'Operator ID';

COMMENT ON COLUMN operator.op_comp_name IS
    'Operator company name';

COMMENT ON COLUMN operator.op_ceo_name IS
    'Operator''s company CEO name';

ALTER TABLE operator ADD CONSTRAINT operator_pk PRIMARY KEY ( op_id );

CREATE TABLE passenger (
    pass_id             NUMBER(8) NOT NULL,
    pass_fname          VARCHAR2(50 CHAR) NOT NULL,
    pass_lname          VARCHAR2(50 CHAR) NOT NULL,
    pass_dob            DATE NOT NULL,
    pass_gender         CHAR(1 CHAR) NOT NULL,
    pass_phone          VARCHAR2(15),
    pass_guard          NUMBER(8),
    pass_principal_lang CHAR(2) NOT NULL,
    add_id              NUMBER(8) NOT NULL,
    cruise_id           NUMBER(7) NOT NULL
);

ALTER TABLE passenger
    ADD CONSTRAINT chk_gender CHECK ( pass_gender IN ( 'F', 'M', 'O' ) );

COMMENT ON COLUMN passenger.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN passenger.pass_fname IS
    'Passenger first name';

COMMENT ON COLUMN passenger.pass_lname IS
    'Passenger last name';

COMMENT ON COLUMN passenger.pass_dob IS
    'Passenger date of birth';

COMMENT ON COLUMN passenger.pass_gender IS
    'Passenger gender';

COMMENT ON COLUMN passenger.pass_phone IS
    'Passenger phone number with conutry code';

COMMENT ON COLUMN passenger.pass_guard IS
    'Passenger ID';

COMMENT ON COLUMN passenger.pass_principal_lang IS
    'Language represented using  ISO 3166-1 Alpha-2 codes';

COMMENT ON COLUMN passenger.add_id IS
    'A unique address ID as a surrogate key for the passenger''s address';

COMMENT ON COLUMN passenger.cruise_id IS
    'ID of the cruise';

ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( pass_id );

CREATE TABLE port (
    port_code       CHAR(5 CHAR) NOT NULL,
    port_name       VARCHAR2(50 CHAR) NOT NULL,
    port_population NUMBER(7) NOT NULL,
    port_longitude  NUMBER(10, 7) NOT NULL,
    port_latitude   NUMBER(10, 7) NOT NULL,
    country_code    CHAR(2 CHAR) NOT NULL
);

COMMENT ON COLUMN port.port_code IS
    'Port code';

COMMENT ON COLUMN port.port_name IS
    'Port name';

COMMENT ON COLUMN port.port_population IS
    'Port population';

COMMENT ON COLUMN port.port_longitude IS
    'Port longitude';

COMMENT ON COLUMN port.port_latitude IS
    'Port latitude';

COMMENT ON COLUMN port.country_code IS
    'Country code in ISO 3166-1 Alpha-2';

ALTER TABLE port ADD CONSTRAINT port_pk PRIMARY KEY ( port_code );

CREATE TABLE port_temp (
    port_code   CHAR(5 CHAR) NOT NULL,
    pt_month    CHAR(3 CHAR) NOT NULL,
    pt_ave_high NUMBER(2) NOT NULL,
    pt_ave_low  NUMBER(2) NOT NULL
);

ALTER TABLE port_temp
    ADD CHECK ( pt_month IN ( 'Apr', 'Aug', 'Dec', 'Feb', 'Jan',
                              'Jul', 'Jun', 'Mar', 'May', 'Nov',
                              'Oct', 'Sep' ) );

COMMENT ON COLUMN port_temp.port_code IS
    'Port code';

COMMENT ON COLUMN port_temp.pt_month IS
    'Port month';

COMMENT ON COLUMN port_temp.pt_ave_high IS
    'Average high temperature at a given port';

COMMENT ON COLUMN port_temp.pt_ave_low IS
    'Average low temperature at a given port';

ALTER TABLE port_temp ADD CONSTRAINT port_temp_pk PRIMARY KEY ( port_code,
                                                                pt_month );

CREATE TABLE ship (
    ship_code        NUMBER(7) NOT NULL,
    ship_name        VARCHAR2(50 CHAR) NOT NULL,
    ship_comm_date   DATE NOT NULL,
    ship_tonnage     NUMBER(7, 2) NOT NULL,
    ship_max_cap     CHAR(5 CHAR) NOT NULL,
    ship_country_reg VARCHAR2(50 CHAR) NOT NULL,
    op_id            NUMBER(8) NOT NULL
);

COMMENT ON COLUMN ship.ship_code IS
    'Ship code to identify ship';

COMMENT ON COLUMN ship.ship_name IS
    'Name of the ship';

COMMENT ON COLUMN ship.ship_comm_date IS
    'Ship commission date';

COMMENT ON COLUMN ship.ship_tonnage IS
    'Ship tonnage';

COMMENT ON COLUMN ship.ship_max_cap IS
    'Ship max capacity';

COMMENT ON COLUMN ship.ship_country_reg IS
    'The ship''s country of registration';

COMMENT ON COLUMN ship.op_id IS
    'Operator ID';

ALTER TABLE ship ADD CONSTRAINT ship_pk PRIMARY KEY ( ship_code );

CREATE TABLE tour (
    port_code              CHAR(5 CHAR) NOT NULL,
    tour_no                VARCHAR2(2 CHAR) NOT NULL,
    tour_name              VARCHAR2(50 CHAR) NOT NULL,
    tour_desc              VARCHAR2(100 CHAR) NOT NULL,
    tour_hour_req          NUMBER(4, 2) NOT NULL,
    tour_cost_person       NUMBER(6, 2) NOT NULL,
    tour_wheelchair_access CHAR(1) NOT NULL,
    tour_start_time        DATE NOT NULL,
    tour_min_part          NUMBER(3) NOT NULL,
    tour_avail_id          NUMBER(3) NOT NULL
);

ALTER TABLE tour
    ADD CONSTRAINT chk_wheelchair CHECK ( tour_wheelchair_access IN ( 'N', 'Y' ) );

COMMENT ON COLUMN tour.port_code IS
    'Port code';

COMMENT ON COLUMN tour.tour_no IS
    'Tour number';

COMMENT ON COLUMN tour.tour_name IS
    'Tour name';

COMMENT ON COLUMN tour.tour_desc IS
    'Tour description';

COMMENT ON COLUMN tour.tour_hour_req IS
    'Hours required for the tour';

COMMENT ON COLUMN tour.tour_cost_person IS
    'Tour cost per person';

COMMENT ON COLUMN tour.tour_wheelchair_access IS
    'Wheelchair access (Y/N)';

COMMENT ON COLUMN tour.tour_start_time IS
    'Start time';

COMMENT ON COLUMN tour.tour_min_part IS
    'Minimum number of participants required for the tour to run';

COMMENT ON COLUMN tour.tour_avail_id IS
    'Tour availability id represents the intervals of tour runs which allows for many combinations';

ALTER TABLE tour ADD CONSTRAINT tour_pk PRIMARY KEY ( port_code,
                                                      tour_no );

ALTER TABLE tour ADD CONSTRAINT tour_unique UNIQUE ( tour_no );

CREATE TABLE tour_availability (
    tour_avail_id   NUMBER(3) NOT NULL,
    tour_avail_days VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tour_availability.tour_avail_id IS
    'Tour availability id represents the intervals of tour runs which allows for many combinations';

COMMENT ON COLUMN tour_availability.tour_avail_days IS
    'The days which the tour runs';

ALTER TABLE tour_availability ADD CONSTRAINT tour_availability_pk PRIMARY KEY ( tour_avail_id );

CREATE TABLE tour_off (
    tour_off_id NUMBER(5) NOT NULL,
    port_code   CHAR(5 CHAR) NOT NULL,
    tour_no     VARCHAR2(2 CHAR) NOT NULL,
    tour_date   DATE NOT NULL
);

COMMENT ON COLUMN tour_off.tour_off_id IS
    'The ID for an offering of a tour';

COMMENT ON COLUMN tour_off.port_code IS
    'Port code';

COMMENT ON COLUMN tour_off.tour_no IS
    'Tour number';

COMMENT ON COLUMN tour_off.tour_date IS
    'Date of the tour';

ALTER TABLE tour_off ADD CONSTRAINT tour_off_pk PRIMARY KEY ( tour_off_id );

ALTER TABLE tour_off
    ADD CONSTRAINT tour_off_nk UNIQUE ( port_code,
                                        tour_no,
                                        tour_date );

CREATE TABLE tour_part (
    tour_off_id            NUMBER(5) NOT NULL,
    pass_id                NUMBER(8) NOT NULL,
    tour_part_pay_received CHAR(1 CHAR) NOT NULL
);

ALTER TABLE tour_part
    ADD CONSTRAINT chk_payment CHECK ( tour_part_pay_received IN ( 'F', 'T' ) );

COMMENT ON COLUMN tour_part.tour_off_id IS
    'The ID for an offering of a tour';

COMMENT ON COLUMN tour_part.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN tour_part.tour_part_pay_received IS
    'Payment received boolean';

ALTER TABLE tour_part ADD CONSTRAINT tour_part_pk PRIMARY KEY ( pass_id,
                                                                tour_off_id );

CREATE TABLE visit (
    cruise_id  NUMBER(7) NOT NULL,
    visit_date DATE NOT NULL,
    visit_time DATE NOT NULL,
    port_code  CHAR(5 CHAR) NOT NULL
);

COMMENT ON COLUMN visit.cruise_id IS
    'ID of the cruise';

COMMENT ON COLUMN visit.visit_date IS
    'Date the cruise made a visit';

COMMENT ON COLUMN visit.visit_time IS
    'Time the cruise made a visit';

COMMENT ON COLUMN visit.port_code IS
    'Port code';

ALTER TABLE visit ADD CONSTRAINT visit_pk PRIMARY KEY ( cruise_id );

ALTER TABLE manifest
    ADD CONSTRAINT cabin_manifest FOREIGN KEY ( ship_code,
                                                cab_num )
        REFERENCES cabin ( ship_code,
                           cab_num );

ALTER TABLE passenger
    ADD CONSTRAINT child_guardian FOREIGN KEY ( pass_guard )
        REFERENCES passenger ( pass_id );

ALTER TABLE comm_lang
    ADD CONSTRAINT comm_lang_language FOREIGN KEY ( lang_code )
        REFERENCES language ( lang_code );

ALTER TABLE manifest
    ADD CONSTRAINT cruise_manifest FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE passenger
    ADD CONSTRAINT cruise_passenger FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE visit
    ADD CONSTRAINT cruise_visit FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE passenger
    ADD CONSTRAINT pass_lang FOREIGN KEY ( pass_principal_lang )
        REFERENCES language ( lang_code );

ALTER TABLE passenger
    ADD CONSTRAINT passenger_address FOREIGN KEY ( add_id )
        REFERENCES address ( add_id );

ALTER TABLE manifest
    ADD CONSTRAINT passenger_manifest FOREIGN KEY ( pass_id )
        REFERENCES passenger ( pass_id );

ALTER TABLE tour_part
    ADD CONSTRAINT passenger_tour_part_det FOREIGN KEY ( pass_id )
        REFERENCES passenger ( pass_id );

ALTER TABLE port
    ADD CONSTRAINT port_tour_country FOREIGN KEY ( country_code )
        REFERENCES country ( country_code );

ALTER TABLE port_temp
    ADD CONSTRAINT port_tour_port_temp FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE tour
    ADD CONSTRAINT port_tour_tour FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE visit
    ADD CONSTRAINT port_tour_visit FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE cabin
    ADD CONSTRAINT ship_cabin FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE cruise
    ADD CONSTRAINT ship_cruise FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE ship
    ADD CONSTRAINT ship_operator FOREIGN KEY ( op_id )
        REFERENCES operator ( op_id );

ALTER TABLE comm_lang
    ADD CONSTRAINT tour_comm_lang FOREIGN KEY ( port_code,
                                                tour_no )
        REFERENCES tour ( port_code,
                          tour_no );

ALTER TABLE tour_part
    ADD CONSTRAINT tour_off_part_det FOREIGN KEY ( tour_off_id )
        REFERENCES tour_off ( tour_off_id );

ALTER TABLE tour
    ADD CONSTRAINT tour_tour_availability FOREIGN KEY ( tour_avail_id )
        REFERENCES tour_availability ( tour_avail_id );

ALTER TABLE tour_off
    ADD CONSTRAINT tour_tour_det FOREIGN KEY ( port_code,
                                               tour_no )
        REFERENCES tour ( port_code,
                          tour_no );

SPOOL off
set echo off


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             46
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
