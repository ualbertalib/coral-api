 <?php

header('Content-Type: text/html');
// this file contains MySQL login info
require 'credentials.php';


// Include the database class
require_once("class.db.php");
 

// connect to DB
$db_connection=$db_connection . 'dbname=coral_licensing_prod';
$db = new db($db_connection, $db_user, $db_passwd);


$q = "SELECT l.licenseID, l.shortName AS licenseName, d.shortName AS documentName, s.shortName AS sfxProvider
FROM Document d, License l, SFXProvider s,
(SELECT shortName, COUNT(shortName) FROM SFXProvider GROUP BY shortName HAVING COUNT(shortName) > 1) dup
WHERE s.documentID = d.documentID AND l.licenseID = d.licenseID AND s.shortName = dup.shortName
ORDER BY sfxProvider
";

$results = $db->run($q);

echo "<table>";
echo "<tr><th>Licence ID</th><th>License Name </th><th>Document Name</th><th>SFX Provider</th></tr>";
foreach($results as $row){
    
	echo "<tr><td>{$row['licenseID']}</td><td><a href='https://erms.library.ualberta.ca/licensing/license.php?licenseID={$row['licenseID']}'>" . $row['licenseName'] . '</a></td>
	<td> ' . $row['documentName'] .	"</td><td> " . $row['sfxProvider'] . "</td></tr>";
		
}			
echo "</table>";