import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/models/money.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection= FirebaseFirestore.instance.collection('user');
  final CollectionReference userGoalsMoneyCollection= FirebaseFirestore.instance.collection('money');
  Future updateData(String? username,String? fullname,String? assets) async{
    return await userCollection.doc(uid).set({
      "username":username,
      "fullname":fullname,
      "assets":assets,
      "uid":uid
    });
  }
  List<UserInformation>_authDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserInformation(
        username:doc.data().toString().contains('username')?doc.get('username'):" ",
        fullname:doc.data().toString().contains('fullname')?doc.get('fullname'):" ",
        asset:doc.data().toString().contains('assets')?doc.get('assets'):" ",
        uid:doc.data().toString().contains('uid')?doc.get('uid'):" ",
    );
    }).toList();
  }

  Stream<List<UserInformation>> get authData{
    return userCollection.snapshots().map((_authDataFromSnapshot));
  }

  //goals user
  Future setGoals(String money)async{
    return await userGoalsMoneyCollection.doc(uid).set({
      "Cosmetic":{
        "Jan":money,
        "Feb":money,
      },
    });
  }
  Future updateGoals(String money,String options)async{
    switch(options){
      case "Cosmetic":
        return await userGoalsMoneyCollection.doc(uid).update({
          "Cosmetic":{"Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
        });
      case "Clothes":
        return await userGoalsMoneyCollection.doc(uid).update({
          "Clothes":{"Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
        });
      case "Food":
        return await userGoalsMoneyCollection.doc(uid).update({
          "Food":{"Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
        });
      case "Pet":
        return await userGoalsMoneyCollection.doc(uid).update({
          "Pet":{"Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
        });
      case "Travel":
        return await userGoalsMoneyCollection.doc(uid).update({
          "Travel":{"Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
        });
    }
  }
  List<Goals>_moneyDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Goals(
        money: doc.data().toString().contains('money')?doc.get('money'):"1",
        time: doc.data().toString().contains('time')?doc.get('time'):"1 month",
        options: doc.data().toString().contains('options')?doc.get('options'):"food"
      );
    }).toList();
  }
  Stream<List<Goals>> get goalsData{
    return userGoalsMoneyCollection.snapshots().map(_moneyDataFromSnapshot);
  }
}