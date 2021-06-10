import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/model/user_info.dart';

class FirestoreAdd {
  final CollectionReference ref = FirebaseFirestore.instance.collection('user');

  Future<void> addToFire({required UserInfor info}) async {
    return await ref.doc(info.uid).set(info.toJson());
  }
}
