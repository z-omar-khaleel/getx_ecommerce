class UserInfor {
  String? email;
  String? name;
  String? pic;
  String? uid;

  UserInfor(
      {required this.email,
      required this.name,
      required this.pic,
      required this.uid});

  UserInfor.fromJson(Map<dynamic, dynamic> map) {
    email = map['email'];
    name = map['name'];
    pic = map['pic'];
    uid = map['uid'];
  }

  toJson() {
    return {'email': email, 'name': name, 'pic': pic, 'uid': uid};
  }
}
