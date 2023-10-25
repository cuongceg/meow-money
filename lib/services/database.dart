import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monney_management/models/user.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection= FirebaseFirestore.instance.collection('user');
  Future updateData(String? username,String? fullname,String? gender) async{
    return await userCollection.doc(uid).set({
      "username":username,
      "fullname":fullname,
      "gender":gender
    });
  }
  List<UserInfo>_authDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserInfo(
        username:doc.data().toString().contains('username')?doc.get('username'):" ",
        fullname:doc.data().toString().contains('fullname')?doc.get('fullname'):" ",
        gender:doc.data().toString().contains('gender')?doc.get('gender'):" ",
    );
    }).toList();
  }

  Stream<List<UserInfo>> get authData{
    return userCollection.snapshots().map((_authDataFromSnapshot));
  }
}