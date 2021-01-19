class CartModel {
  int status;
  List<OrderData> data;
  int count;
  int total;

  CartModel({this.status, this.data, this.count, this.total});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<OrderData>();
      json['data'].forEach((v) {
        data.add(new OrderData.fromJson(v));
      });
    }
    count = json['count'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['total'] = this.total;
    return data;
  }
}

class OrderData {
  int id;
  int productId;
  int quantity;
  CartProduct product;

  OrderData({this.id, this.productId, this.quantity, this.product});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new CartProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class CartProduct {
  int id;
  String name;
  int cost;
  String productCategory;
  String productImages;
  int subTotal;

  CartProduct(
      {this.id,
        this.name,
        this.cost,
        this.productCategory,
        this.productImages,
        this.subTotal});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cost = json['cost'];
    productCategory = json['product_category'];
    productImages = json['product_images'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['product_category'] = this.productCategory;
    data['product_images'] = this.productImages;
    data['sub_total'] = this.subTotal;
    return data;
  }
}
