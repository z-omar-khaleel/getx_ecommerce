class BestSelling {
  String subTitle;
  double price;
  String pic;
  String title;
  String id;

  BestSelling(
      {this.subTitle = "",
      this.price = 0.0,
      this.pic = "",
      this.title = "",
      required this.id});

  BestSelling.fromJson(Map<String, dynamic> map)
      : subTitle = map['subTitle'] ?? "",
        price = double.parse(map['price']),
        pic = map['pic'] ?? "",
        title = map['title'] ?? "",
        id = map['id'];

  Map<String, dynamic> toJson() => {
        'subTitle': subTitle,
        'price': price,
        'pic': pic,
        'title': title,
        'id': id
      };
}
