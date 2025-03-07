// T3-mns-mongo.mongodb.js

// --Name: Abhishek Adhikary


use("aadh0008");

// Create a new collection and insert all documents generated previously above into MongoDB.
// Provide a drop collection statement right above the create collection statement. After the
// documents have been inserted, use an appropriate db.find command to list all the
// documents you added.

// Drop collection 
db.mnsappointment.drop();

// Create collection and insert documents
db.mnsappointment.insertMany(
    [
        { "_id": 1, "datetime": "08/09/2023 10:00", "provider_code": "ORS001", "provider_name": "Dr. Jessica Jones", "item_totalcost": 80, "no_of_items": 2, "items": [{ "id": 20, "desc": "Phospor imaging plate", "standardcost": 75, "quantity": 1 }, { "id": 21, "desc": "Clinasept Film", "standardcost": 5, "quantity": 1 }] },
        { "_id": 3, "datetime": "08/09/2023 12:00", "provider_code": "ORS001", "provider_name": "Dr. Jessica Jones", "item_totalcost": 27, "no_of_items": 19, "items": [{ "id": 1, "desc": "Paper tips", "standardcost": 1, "quantity": 5 }, { "id": 15, "desc": "Absorbable suture", "standardcost": 3, "quantity": 2 }, { "id": 8, "desc": "Irrigation Needle and Syringe", "standardcost": 2, "quantity": 1 }, { "id": 7, "desc": "Portalimas sponges 1 cm", "standardcost": 0.5, "quantity": 10 }, { "id": 4, "desc": "Irrigation Solution 2% Chlorhexidine", "standardcost": 9, "quantity": 1 }] },
        { "_id": 5, "datetime": "08/09/2023 16:00", "provider_code": "GEN001", "provider_name": "Dr. Bruce Striplin", "item_totalcost": 75, "no_of_items": 1, "items": [{ "id": 20, "desc": "Phospor imaging plate", "standardcost": 75, "quantity": 1 }] },
        { "_id": 7, "datetime": "08/09/2023 12:00", "provider_code": "GEN002", "provider_name": "Dr. Amalia Morris", "item_totalcost": 78, "no_of_items": 1, "items": [{ "id": 18, "desc": "Fluid composite", "standardcost": 78, "quantity": 1 }] },
        { "_id": 8, "datetime": "08/09/2023 12:00", "provider_code": "END001", "provider_name": "Dr. Mark Stanton", "item_totalcost": 26, "no_of_items": 3, "items": [{ "id": 4, "desc": "Irrigation Solution 2% Chlorhexidine", "standardcost": 9, "quantity": 1 }, { "id": 8, "desc": "Irrigation Needle and Syringe", "standardcost": 2, "quantity": 1 }, { "id": 6, "desc": "Universal Clamp", "standardcost": 15, "quantity": 1 }] },
        { "_id": 9, "datetime": "11/09/2023 15:00", "provider_code": "ORS001", "provider_name": "Dr. Jessica Jones", "item_totalcost": 5, "no_of_items": 10, "items": [{ "id": 7, "desc": "Portalimas sponges 1 cm", "standardcost": 0.5, "quantity": 10 }] },
        { "_id": 10, "datetime": "11/09/2023 09:15", "provider_code": "PER002", "provider_name": "Dr. Joseph Hazelton", "item_totalcost": 8, "no_of_items": 2, "items": [{ "id": 2, "desc": "Sodium hypochlorite 5.25%", "standardcost": 6, "quantity": 1 }, { "id": 8, "desc": "Irrigation Needle and Syringe", "standardcost": 2, "quantity": 1 }] },
        { "_id": 11, "datetime": "11/09/2023 15:00", "provider_code": "PED002", "provider_name": "Dr. Lee", "item_totalcost": 80, "no_of_items": 2, "items": [{ "id": 20, "desc": "Phospor imaging plate", "standardcost": 75, "quantity": 1 }, { "id": 21, "desc": "Clinasept Film", "standardcost": 5, "quantity": 1 }] },
        { "_id": 18, "datetime": "14/09/2023 10:00", "provider_code": "PER001", "provider_name": "Dr. April Manahan", "item_totalcost": 10, "no_of_items": 3, "items": [{ "id": 2, "desc": "Sodium hypochlorite 5.25%", "standardcost": 6, "quantity": 1 }, { "id": 8, "desc": "Irrigation Needle and Syringe", "standardcost": 2, "quantity": 2 }] },
        { "_id": 19, "datetime": "14/09/2023 14:00", "provider_code": "END001", "provider_name": "Dr. Mark Stanton", "item_totalcost": 60, "no_of_items": 7, "items": [{ "id": 1, "desc": "Paper tips", "standardcost": 1, "quantity": 5 }, { "id": 16, "desc": "Universal composite", "standardcost": 48, "quantity": 1 }, { "id": 5, "desc": "Sterile K NiTi files", "standardcost": 7, "quantity": 1 }] },
        { "_id": 20, "datetime": "14/09/2023 09:00", "provider_code": "PED001", "provider_name": "Dr. Kevin Barr", "item_totalcost": 60, "no_of_items": 2, "items": [{ "id": 22, "desc": "Porcelain Etch", "standardcost": 35, "quantity": 1 }, { "id": 23, "desc": "Silane", "standardcost": 25, "quantity": 1 }] },
        { "_id": 22, "datetime": "14/09/2023 10:00", "provider_code": "ORT001", "provider_name": "Dr. Gerry Elliott", "item_totalcost": 70, "no_of_items": 44, "items": [{ "id": 9, "desc": "Metal Bracket", "standardcost": 1.5, "quantity": 20 }, { "id": 12, "desc": "Curved lingual button", "standardcost": 1, "quantity": 8 }, { "id": 11, "desc": "Archwire", "standardcost": 2, "quantity": 4 }, { "id": 10, "desc": "Molar mouth tube", "standardcost": 2, "quantity": 12 }] }
    ]
);

// List all documents you added
db.mnsappointment.find();

// List all appointments which use more than two different items or their total item cost are more than $50.

db.mnsappointment.find(
    { "$or": [{ "no_of_items": { "$gt": 2 } }, { "item_totalcost": { "$gt": 50 } }] },
    {}
);

// The management decided to change the description of item id 1 from ‘Paper tips’ into ‘Paper points’. Change the data within the collection to reflect this decision.

db.mnsappointment.updateOne(
    {
        "items.id": 1,
    },
    {
        "$set":
        {
            "items.$.desc": "Paper points"
        }
    }
);

// Illustrate/confirm changes made
db.mnsappointment.find(
    { "items.id": 1 }
);

// Insert three additional items into appointment number 20 (i.e. _id is 20):
// ● ‘EDTA Cleansing Gel 17%’ (item id: 3, standard cost: $8) x 1 used
// ● ‘Irrigation Solution 2% Chlorhexidine’ (item id: 4, standard cost: $9) x 1 used, and
// ● ‘Irrigation Needle and Syringe’ (item id: 8, standard cost: $2) x 2 used.
// Write the necessary MongoDB commands to add these new items into the collection.
// Use an appropriate db.find command after making the change so that you illustrate/confirm the change which was made.

db.mnsappointment.updateOne(
    { _id: 20 },
    {
        "$push":
        {
            "items":
            {
                "id": 3,
                "desc": "EDTA Cleansing Gel 17%",
                "standardcost": 8,
                "quantity": 1
            }
        }
    }
);

db.mnsappointment.updateOne(
    { _id: 20 },
    {
        "$push":
        {
            "items":
            {
                "id": 4,
                "desc": "Irrigation Solution 2% Chlorhexidine",
                "standardcost": 9,
                "quantity": 1
            }
        }
    }
);

db.mnsappointment.updateOne(
    { _id: 20 },
    {
        "$push":
        {
            "items":
            {
                "id": 8,
                "desc": "Irrigation Needle and Syringe",
                "standardcost": 2,
                "quantity": 2
            }
        }
    }
);

// Illustrate/confirm changes made
db.mnsappointment.find(
    { _id: 20 }
);