//class Company {
//  int id;
//  String name;
//
//  Company(this.id, this.name);
//
//  static List<Company> getCompanies() {
//    return <Company>[
//      Company(1, 'Apple'),
//      Company(2, 'Google'),
//      Company(3, 'Samsung'),
//      Company(4, 'Sony'),
//      Company(5, 'LG'),
//    ];
//  }
//}

class CompanyNames {
  String id;
  String itemCode;
  String itemName;
  String price;
  String stock;

  CompanyNames({this.id, this.itemCode, this.itemName, this.price, this.stock});

  CompanyNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['stock'] = this.stock;
    return data;
  }
}