<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

// Set a default query
$sqlbarterorder = "SELECT * FROM `tbl_orders`";

if (isset($_POST['sellerid'])) {
    $sellerid = $_POST['sellerid'];
    // Modify the query based on the sellerid
    $sqlbarterorder = "SELECT * FROM `tbl_orders` WHERE seller_id = '$sellerid'";
}

$result = $conn->query($sqlbarterorder);
if ($result->num_rows > 0) {
    $oderitems["orders"] = array();
    while ($row = $result->fetch_assoc()) {
        $orderlist = array();
        $orderlist['order_id'] = $row['order_id'];
        $orderlist['order_bill'] = $row['order_bill'];
        $orderlist['order_paid'] = $row['order_paid'];
        $orderlist['buyer_id'] = $row['buyer_id'];
        $orderlist['seller_id'] = $row['seller_id'];
        $orderlist['order_date'] = $row['order_date'];
        $orderlist['order_status'] = $row['order_status'];
        $orderlist['order_lat'] = $row['order_lat'];
        $orderlist['order_lng'] = $row['order_lng'];
        $orderlist['item_id'] = $row['item_id'];
        $orderlist['order_qty'] = $row['order_qty'];
        array_push($oderitems["orders"], $orderlist);
    }
    $response = array('status' => 'success', 'data' => $oderitems); // Include the order list in the response data
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null); // Return an empty array if there are no orders
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
