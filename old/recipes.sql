drop table ingredients;
drop table recipes;
drop table methods;

CREATE TABLE methods (
    id                  serial PRIMARY KEY,
    description         varchar(100) NOT NULL,
    steps               varchar(100)[] NOT NULL
);

CREATE TABLE ingredients (
    id                  serial PRIMARY KEY,
    name                varchar(100) UNIQUE NOT NULL,
    unit                varchar(100) NOT NULL,
    amount              integer NOT NULL
);

CREATE TABLE recipes (
    id                  serial PRIMARY KEY,
    name                varchar(100) UNIQUE NOT NULL,
    origin		          varchar(100) NOT NULL,
    ingredients         integer[] NOT NULL,
    method		          integer[] NOT NULL
);

INSERT INTO methods VALUES (1, 'Chop Apples', '{"Chop the apples into slices"}');
INSERT INTO methods VALUES (2, 'Grease dish', '{"Grease the oven dish"}');

INSERT INTO ingredients VALUES (1, 'Apples', 'quantity', 4);
INSERT INTO ingredients VALUES (2, 'Flour', 'grams', 500);
INSERT INTO ingredients VALUES (3, 'Brown Sugar', 'grams', 250);

INSERT INTO recipes VALUES (1, 'Apple Crumble', 'Mum', '{"1", "2", "3"}', '{"1", "2"}');


