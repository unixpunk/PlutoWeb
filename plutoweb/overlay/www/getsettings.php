<?php
header('Content-type: text/plain');
// open database in www               
$db = new SQLite3("settings.sqlite3");
                    
// retrieve the data                           
$result = $db->query("SELECT * FROM settings");
while ($row = $result->fetchArray()) {                        
        echo "{$row['setting']} = {$row['value']} \n";    
} 
?>
