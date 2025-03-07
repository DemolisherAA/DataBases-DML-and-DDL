# MNS Database Project

This repository contains SQL scripts and related files for creating, managing, and querying the MNS database. The project involves various aspects such as schema creation, data insertion, schema modifications, and interactions with both relational and NoSQL databases.

---

## Contents

### SQL Scripts

1. **`T1-mns-schema.sql`**
   - Defines the initial schema for the MNS database, including table creation and relationships.

2. **`T2-mns-insert.sql`**
   - Contains SQL scripts for inserting sample data into the MNS database.

3. **`T2-mns-select.sql`**
   - Includes various SQL queries to retrieve data from the database for analytical and reporting purposes.

4. **`T3-mns-dm.sql`**
   - Represents data manipulation scripts, including updates and transformations applied to the MNS database.

5. **`T4-mns-alter.sql`**
   - Includes SQL commands for altering the database schema, such as adding new columns, modifying constraints, etc.

6. **`T3-mns-json.sql`**
   - Provides SQL scripts for working with JSON data within the relational database.

7. **`mns_schema_insert.sql`**
   - Combines schema creation and data insertion into a single script for streamlined database setup.

---

### NoSQL Scripts

8. **`T3-mns-mongo.mongodb.js`**
   - Contains MongoDB scripts for creating collections, inserting documents, and querying NoSQL data.

---

## Setup and Usage

### Prerequisites
- **Database Server:** Ensure you have access to a relational database server (e.g., MySQL, PostgreSQL).
- **MongoDB:** Install MongoDB if you wish to execute the NoSQL scripts.

### Steps to Run

#### Relational Database
1. Execute `T1-mns-schema.sql` to create the database schema.
2. Run `T2-mns-insert.sql` to populate the tables with sample data.
3. Use `T2-mns-select.sql` for querying data.
4. Apply `T4-mns-alter.sql` to modify the schema if required.
5. Optionally, run `T3-mns-json.sql` for handling JSON data in the database.

#### MongoDB
1. Use `T3-mns-mongo.mongodb.js` to interact with the NoSQL database.
2. Modify the script as needed to match your MongoDB instance.

---

## File Details

- **`T1-mns-schema.sql`**: Establishes the foundation of the MNS database.
- **`T2-mns-insert.sql`**: Populates the database with initial data.
- **`T2-mns-select.sql`**: Demonstrates various SELECT queries for data retrieval.
- **`T3-mns-dm.sql`**: Provides data manipulation commands to refine the data.
- **`T4-mns-alter.sql`**: Alters and updates the schema.
- **`T3-mns-json.sql`**: Handles JSON operations in the database.
- **`mns_schema_insert.sql`**: Combines schema creation and data insertion in one script.
- **`T3-mns-mongo.mongodb.js`**: MongoDB scripts for NoSQL data management.

---

## Contributing
Contributions are welcome! If you have any suggestions or improvements, please create a pull request.

---

## License
This project is licensed GNU (General Public License).

