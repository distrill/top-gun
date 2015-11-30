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
