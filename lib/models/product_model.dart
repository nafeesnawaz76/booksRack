// ignore: camel_case_types
class Product_model {
  late String id;
  late String name;
  late String image;
  late bool isFavourite;
  late int price;
  late String description;
  late String status;
  late String author;

  Product_model(
      {required this.id,
      required this.name,
      required this.image,
      required this.isFavourite,
      required this.price,
      required this.description,
      required this.status,
      required this.author});

  Product_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isFavourite = json['isFavourite'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    author = json["author"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['isFavourite'] = this.isFavourite;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data["author"] = this.author;
    return data;
  }
}
