class OrderDetails {
  String? orderId;
  String? orderBill;
  String? orderPaid;
  String? buyerId;
  String? sellerId;
  String? orderDate;
  String? orderStatus;
  String? orderLat;
  String? orderLng;
  String? itemId;
  String? orderQty;
  String? itemName;

  OrderDetails(
      {this.orderId,
      this.orderBill,
      this.orderPaid,
      this.buyerId,
      this.sellerId,
      this.orderDate,
      this.orderStatus,
      this.orderLat,
      this.orderLng,
      this.itemId,
      this.orderQty,
      this.itemName});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderBill = json['order_bill'];
    orderPaid = json['order_paid'];
    buyerId = json['buyer_id'];
    sellerId = json['seller_id'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    orderLat = json['order_lat'];
    orderLng = json['order_lng'];
    itemId = json['item_id'];
    orderQty = json['order_qty'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_bill'] = orderBill;
    data['order_paid'] = orderPaid;
    data['buyer_id'] = buyerId;
    data['seller_id'] = sellerId;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['order_lat'] = orderLat;
    data['order_lng'] = orderLng;
    data['item_id'] = itemId;
    data['order_qty'] = orderQty;
    data['item_name'] = itemName;
    return data;
  }
}
