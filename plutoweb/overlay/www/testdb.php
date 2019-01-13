<?php
// create new database in www
$db = new SQLite3("testdb.sqlite3");

// create table names and insert sample data
$db->query("BEGIN;
CREATE TABLE names (id INTEGER PRIMARY KEY, name CHAR(80));
INSERT INTO names (name) VALUES('Foo');
INSERT INTO names (name) VALUES('Bar');
COMMIT;");

// retrieve the data
$result = $db->query("SELECT * FROM names");
// iterate through the retrieved rows
var_dump($result->fetchArray())
?>
