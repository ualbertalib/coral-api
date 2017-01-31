<?php
function getURL($text)
{
    preg_match_all('!https?://\S+!', $text, $matches);
    return $matches[0];
}
?>



<?php
/**
 * Created by PhpStorm.
 * User: astrilets
 * Date: 2016-07-11
 * Time: 1:05 PM
 */

header('Content-Type: text/html');
// this file contains MySQL login info
require 'credentials.php';


// Include the database class
require_once("class.db.php");


// connect to DB
$db_connection=$db_connection . 'dbname=coral_api_prod';
$db = new db($db_connection, $db_user, $db_passwd);
$db->setErrorCallbackFunction("echo");

// retrieve all SFX targets and corresponding Coral names
$results = $db->run("call GetXLinks()");

// set up table header to display results



foreach($results as $value){
    $linkID = $value["linkID"];
    $coralName = $value["coralName"];
    $sfxTag = $value["SFXTarget"];
    $foundId = $value["documentID"];
    $ourRights = $value["OURLink"];

    $url = getURL($ourRights)[0];
    $url = str_replace("sfx/?tag=", "", $url);
    $url = str_replace("\"", "", $url);
    $url = str_replace("http", "https", $url);
//    print_r($coralName . " | ". $sfxTag . " | " . $url . "\n");

    if(!empty($url))
    {
        $bind = array(
            ":search" => $url
        );
        $statement = "select LicdataID from OURlicdata where URL = '$url'";
        $licresults = $db->run($statement);
        foreach($licresults as $lic){
            $licdataID = $lic["LicdataID"];
 //           print_r("Licdata ID is :" . $licdataID . "\n");
            $updateStatement = "update XloadLink set ourID = $licdataID where linkID = $linkID";
            $db->run($updateStatement);
        }
    }



}

?>
