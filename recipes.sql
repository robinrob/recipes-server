drop table recipes;

CREATE TABLE recipes (
    id                serial PRIMARY KEY,
    name              varchar(100) NOT NULL,
    origin            varchar(100),
    ingredients       json[] DEFAULT ARRAY[]::json[],
    method            json[] DEFAULT ARRAY[]::json[]
);

INSERT INTO recipes (name, origin, ingredients, method) VALUES ('Apple Crumble', 'Mum', ARRAY['{"name":"Cooking Apples","unit":"quantity","amount":"4"}'::json,'{"name":"Flour","unit":"grams","amount":500}'::json,'{"name":"Cooking Margarine","unit":"grams","amount":250}'::json,'{"name":"Brown Sugar","unit":"grams","amount":500}'::json],ARRAY ['{"description":"Chop Apples","steps":["Chop the apples into slices"]}'::json,'{"description":"Make the crumble","steps":["Put flour, margarine and brown sugar into bowl","Using hands, gradually rub the margarine into the flour and sugar","One mixture is breaking into smaller pieces, gently crumb the mixture until finely crumbed"]}'::json,'{"description":"Grease oven dish","steps":["Grease the oven dish using margarine & pastry brush"]}'::json,'{"description":"Put into oven","steps":["Put into oven at 180 deg C for 30 mins"]}'::json]);
INSERT INTO recipes (name, origin, ingredients, method) VALUES ('Spaghetti Bolognaise', 'Mum', ARRAY['{"name":"Spaghetti","unit":"grams","amount":"500"}'::json,'{"name":"Onions","unit":"quantity","amount":2}'::json,'{"name":"Mushrooms","unit":"grams","amount":"200"}'::json,'{"name":"Garlic cloves","unit":"quantity","amount":2}'::json,'{"name":"Tinned Peeled Plum Tomatoes","unit":"quantity","amount":"1"}'::json],ARRAY ['{"description":"Chop vegetables","steps":["Chop onions into small pieces","Chop mushrooms into medium pieces","Chop garlic into small pieces"]}'::json,'{"description":"Fry vegetables","steps":["Put olive oil into pan and heat","Fry onion for 2 mins","Add mushrooms for 3 mins","Add garlic for 1 min"]}'::json,'{"description":"Simmer the sauce","steps":["Add tomatoes and simmer on low heat for 20 mins"]}'::json,'{"description":"Cook the pasta","steps":["Boil large pan of water with salt added","Add the pasta to boiling water","Cook for 15 mins"]}'::json]);
INSERT INTO recipes (name, origin) VALUES ('Chilli Con Carne', 'Zack''s Mum');