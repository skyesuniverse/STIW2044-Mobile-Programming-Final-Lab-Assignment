<?php
// Include the database connection file
include_once("dbconnect.php");

// Replace the following line with your own validation for payment success
$paidStatus = true; // Assuming payment is successful for this example

if ($paidStatus) {
    // Payment is successful

    // Generate a unique order bill number (e.g., 'ORD12345')
    $orderBill = 'ORD' . rand(10000, 99999);

    // Calculate the total order amount based on order details
    // Replace this with your own logic to calculate the total order amount.
    $orderpaid = $_POST['orderpaid'];
    $buyerid = $_POST['buyerid'];
    $sellerid = $_POST['sellerid'];
    $orderDate = date('Y-m-d H:i:s'); // Current date and time
    $orderStatus = 'New'; // You can set the initial status to 'New'.
    $orderLat = $_POST['orderlat'];
    $orderLng = $_POST['orderlng'];
    $itemid = $_POST['itemid'];
    $orderqty = $_POST['orderqty'];

    // Insert order data into 'tbl_orders' table
    $insertOrderQuery = "INSERT INTO `tbl_orders`(`order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_date`, `order_status`, `order_lat`, `order_lng`, `item_id`, `order_qty`) VALUES ('$orderBill','$orderpaid','$buyerid','$sellerid','$orderDate','$orderStatus','$orderLat','$orderLng','$itemid','$orderqty')";
    $updateItemQuantityQuery = "UPDATE `tbl_items` SET `item_qty` = (`item_qty` - $orderqty) WHERE `item_id` = '$itemid'";
    $conn->query($updateItemQuantityQuery);

    if ($conn->query($insertOrderQuery) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response =  array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
} else {
    // Payment faileds
    $response = array('status' => 'error', 'message' => 'Payment failed.');
    echo json_encode($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

// Close the database connection
// $conn->close();
