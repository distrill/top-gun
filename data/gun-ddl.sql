CREATE TABLE GunToken (
    tid INT,
    classification VARCHAR(12),
    expirationDate DATE,
    PRIMARY KEY (tid)
);

CREATE TABLE GunProduct (
    pid INT,
    name VARCHAR(40),
    quantity INT,
    classification VARCHAR(12),
    price NUMERIC(7, 2),
    PRIMARY KEY (pid)
);

CREATE TABLE GunWarehouse (
    wid INT,
    address VARCHAR(100),
    PRIMARY KEY (wid)
);

CREATE TABLE GunGun (
    gid VARCHAR(40),
    pid INT,
    PRIMARY KEY (gid),
    FOREIGN KEY (pid) REFERENCES GunProduct(pid)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE GunCustomer (
    cid INT,
    name VARCHAR(40),
    address VARCHAR(100),
    province CHAR(2),
    tid INT,
    email VARCHAR(40),
    password VARCHAR(255),
    PRIMARY KEY (cid),
    FOREIGN KEY (tid) REFERENCES GunToken(tid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE GunOrder (
    oid INT,
    orderDate DATE,
    price NUMERIC(12, 2),
    wid INT,
    cid INT,
    PRIMARY KEY (oid),
    FOREIGN KEY (wid) REFERENCES GunWarehouse(wid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (cid) REFERENCES GunCustomer(cid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE GunImage (
    url VARCHAR(100),
    pid INT,
    PRIMARY KEY (url),
    FOREIGN KEY (pid) REFERENCES GunProduct(pid)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE GunReview (
    cid INT,
    pid INT,
    date DATE,
    description VARCHAR(255),
    rating INT,
    PRIMARY KEY (cid, pid),
    FOREIGN KEY (cid) REFERENCES GunCustomer(cid)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (pid) REFERENCES GunProduct(pid)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE GunShipped (
    oid INT,
    gid INT,
    PRIMARY KEY (oid, gid),
    FOREIGN KEY (oid) REFERENCES GunOrder(oid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

INSERT INTO GunToken VALUES(123, 'classified', '2015-11-11');
INSERT INTO GunToken VALUES(234, 'classified', '2015-11-11');
INSERT INTO GunToken VALUES(345, 'classified', '2015-10-11');
INSERT INTO GunToken VALUES(456, 'classified', '2015-12-11');
INSERT INTO GunToken VALUES(567, 'classified', '2015-10-11');
INSERT INTO GunToken VALUES(678, 'classified', '2015-12-11');
INSERT INTO GunToken VALUES(789, 'classified', '2015-11-11');
INSERT INTO GunToken VALUES(890, 'classified', '2015-10-11');

INSERT INTO GunProduct VALUES (1234, 'Hand Gun', 150, 'restricted', 123.34);
INSERT INTO GunProduct VALUES (2345, 'Rifle', 150, 'unrestricted', 99.99);
INSERT INTO GunProduct VALUES (3456, 'Big Huting Rifle', 150, 'restricted', 120.50);
INSERT INTO GunProduct VALUES (4567, 'Shotgun', 200, 'unrestricted', 120.50);
INSERT INTO GunProduct VALUES (5678, 'Big Shotgun', 200, 'restricted', 159.90);
INSERT INTO GunProduct VALUES (6789, 'Bigger Shotgun', 150, 'restricted', 180.00);
INSERT INTO GunProduct VALUES (7890, 'Giant Hunting Rifle', 150, 'restricted', 159.90);
INSERT INTO GunProduct VALUES (8901, 'Assault Rifle', 20, 'prohibited', 280.00);

INSERT INTO GunWarehouse VALUES (01, 'Ontario Top Gun');
INSERT INTO GunWarehouse VALUES (02, 'Quebec Top Gun');
INSERT INTO GunWarehouse VALUES (03, 'Nova Scotia Top Gun');
INSERT INTO GunWarehouse VALUES (04, 'New Brunswick Top Gun');
INSERT INTO GunWarehouse VALUES (05, 'Manitoba Top Gun');
INSERT INTO GunWarehouse VALUES (06, 'British Columbia Top Gun');
INSERT INTO GunWarehouse VALUES (07, 'Prince Edward Island Top Gun');
INSERT INTO GunWarehouse VALUES (08, 'Saskatchewan Top Gun');
INSERT INTO GunWarehouse VALUES (09, 'Alberta Top Gun');
INSERT INTO GunWarehouse VALUES (10, 'Newfoundland and Labrador Top Gun');
INSERT INTO GunWarehouse VALUES (11, 'Northwest Territories Top Gun');
INSERT INTO GunWarehouse VALUES (12, 'Other Northwest Territories Top Gun');
INSERT INTO GunWarehouse VALUES (13, 'Yukon Top Gun');
INSERT INTO GunWarehouse VALUES (14, 'Nunavut Top Gun');

INSERT INTO GunGun VALUES ('123456', 1234);
INSERT INTO GunGun VALUES ('123457', 1234);
INSERT INTO GunGun VALUES ('123458', 1234);
INSERT INTO GunGun VALUES ('123459', 1234);
INSERT INTO GunGun VALUES ('123460', 1234);
INSERT INTO GunGun VALUES ('123461', 1234);
INSERT INTO GunGun VALUES ('123462', 2345);
INSERT INTO GunGun VALUES ('123463', 2345);
INSERT INTO GunGun VALUES ('123464', 2345);
INSERT INTO GunGun VALUES ('123465', 2345);
INSERT INTO GunGun VALUES ('123466', 3456);
INSERT INTO GunGun VALUES ('123467', 3456);
INSERT INTO GunGun VALUES ('123468', 3456);
INSERT INTO GunGun VALUES ('123469', 3456);
INSERT INTO GunGun VALUES ('123470', 3456);
INSERT INTO GunGun VALUES ('123471', 3456);
INSERT INTO GunGun VALUES ('123472', 4567);
INSERT INTO GunGun VALUES ('123473', 4567);
INSERT INTO GunGun VALUES ('123474', 5678);
INSERT INTO GunGun VALUES ('123475', 5678);
INSERT INTO GunGun VALUES ('123476', 5678);
INSERT INTO GunGun VALUES ('123477', 6789);
INSERT INTO GunGun VALUES ('123478', 6789);
INSERT INTO GunGun VALUES ('123479', 7890);
INSERT INTO GunGun VALUES ('123480', 7890);
INSERT INTO GunGun VALUES ('123481', 7890);
INSERT INTO GunGun VALUES ('123482', 7890);
INSERT INTO GunGun VALUES ('123483', 8901);
INSERT INTO GunGun VALUES ('123484', 8901);
INSERT INTO GunGun VALUES ('123485', 8901);

INSERT INTO GunCustomer VALUES (111, 'James Jameson', 'Some Address, British Columbia', 'BC', 123);
INSERT INTO GunCustomer VALUES (112, 'Jimmie John', 'Some Address, Alberta', 'AB', 234);
INSERT INTO GunCustomer VALUES (113, 'Mitch Hedberg', 'Some Address, Northwest Territories', 'NT', 345);
INSERT INTO GunCustomer VALUES (114, 'Steve Heder', 'Some Address, Saskatchewan', 'SK', 456);
INSERT INTO GunCustomer VALUES (115, 'Louis Sekay', 'Some Address, Alberta', 'AB', 567);
INSERT INTO GunCustomer VALUES (115, 'Kevin Carter Comer the Third', 'Some Address, Northwest Territories', 'NT', 678);
INSERT INTO GunCustomer VALUES (115, 'Dustin James', 'Some Address, Ontario', 'ON', 789);
INSERT INTO GunCustomer VALUES (115, 'Sean Patrick Hickey', 'Some Address, Prince Edward Island', 'PE', 890);
