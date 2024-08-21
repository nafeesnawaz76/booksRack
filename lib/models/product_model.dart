// ignore: camel_case_types
class Productmodel {
  late String id;
  late String name;
  late List image;
  late bool isFavourite;
  late int price;
  late String description;
  late String status;
  late String author;
  late String categoryId;

  Productmodel(
      {required this.id,
      required this.name,
      required this.image,
      required this.isFavourite,
      required this.price,
      required this.description,
      required this.status,
      required this.categoryId,
      required this.author});

  Productmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    categoryId = json["categoryId"];
    isFavourite = json['isFavourite'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    author = json["author"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data["categoryId"] = this.categoryId;
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
