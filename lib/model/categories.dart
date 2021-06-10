class Categories {
  String name;
  String pic;

  Categories({
    this.name = "",
    this.pic = "",
  });

  Categories.fromJson(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        pic = map['pic'] ?? "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'pic': pic,
      };

  Categories copyWith({
    required String name,
    required String pic,
  }) {
    return Categories(
      name: name,
      pic: pic,
    );
  }
}
