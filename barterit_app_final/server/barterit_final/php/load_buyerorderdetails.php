<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

if (isset($_POST['buyerid']) && isset($_POST['orderbill'])) {
    $buyerid = $_POST['buyerid'];
    $orderbill = $_POST['orderbill'];
    $sellerid = $_POST['sellerid'];
    $sqlorderdetails = "SELECT * FROM `tbl_orders` INNER JOIN `tbl_items` ON tbl_orders.item_id = tbl_items.item_id WHERE tbl_orders.buyer_id = '$buyerid' AND tbl_orders.order_bill = '$orderbill' AND tbl_orders.seller_id = '$sellerid'";
} else {
    $sqlorderdetails = "NA";
}


$result = $conn->query($sqlorderdetails);
if ($result->num_rows > 0) {
    $oderdetails["orderdetails"] = array();
    while ($row = $result->fetch_assoc()) {
        $orderdetailslist = array();
        $orderdetailslist['order_id'] = $row['order_id'];
        $orderdetailslist['order_bill'] = $row['order_bill'];
        $orderdetailslist['order_paid'] = $row['order_paid'];
        $orderdetailslist['buyer_id'] = $row['buyer_id'];
        $orderdetailslist['seller_id'] = $row['seller_id'];
        $orderdetailslist['order_date'] = $row['order_date'];
        $orderdetailslist['order_status'] = $row['order_status'];
        $orderdetailslist['order_lat'] = $row['order_lat'];
        $orderdetailslist['order_lng'] = $row['order_lng'];
        $orderdetailslist['item_id'] = $row['item_id'];
        $orderdetailslist['order_qty'] = $row['order_qty'];
        $orderdetailslist['item_name'] = $row['item_name'];
        array_push($oderdetails["orderdetails"], $orderdetailslist);
    }
    $response = array('status' => 'success', 'data' => $oderdetails, 'mysql' => $sqlorderdetails);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null, 'mysql' => $sqlorderdetails);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
