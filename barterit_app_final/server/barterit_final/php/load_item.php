<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
$itemid = $_POST['itemid'];

include_once("dbconnect.php");

$sqlloaditem = "SELECT * FROM `tbl_items` WHERE item_id = '$itemid'";
$result = $conn->query($sqlloaditem);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $itemarray = array();
        $itemarray['itemId'] = $row['item_id'];
        $itemarray['userId'] = $row['user_id'];
        $itemarray['itemName'] = $row['item_name'];
        $itemarray['itemCategory'] = $row['item_category'];
        $itemarray['itemDesc'] = $row['item_desc'];
        $itemarray['itemPrice'] = $row['item_price'];
        $itemarray['itemQty'] = $row['item_qty'];
        $itemarray['itemLat'] = $row['item_lat'];
        $itemarray['itemLong'] = $row['item_long'];
        $itemarray['itemState'] = $row['item_state'];
        $itemarray['itemLocality'] = $row['item_locality'];
        $itemarray['itemDate'] = $row['item_date'];
        $response = array('status' => 'success', 'data' => $itemarray);
        sendJsonResponse($response);
    }
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
