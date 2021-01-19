class OrdersList {
  int status;
  List<OrdersData> data;

  OrdersList({this.status, this.data});

  OrdersList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<OrdersData>();
      json['data'].forEach((v) {
        data.add(new OrdersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersData {
  int id;
  int cost;
  String created;

  OrdersData({this.id, this.cost, this.created});

  OrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cost'] = this.cost;
    data['created'] = this.created;
    return data;
  }
}
