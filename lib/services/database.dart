import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/models/money.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection= FirebaseFirestore.instance.collection('user');
  final CollectionReference userGoalsMoneyCollection= FirebaseFirestore.instance.collection('money');
  final CollectionReference billCollection=FirebaseFirestore.instance.collection("bill");
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final formatMonth=DateFormat('MM-yyyy');

  //user information
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
  Future setGoals(String money,String option)async{
    return await userGoalsMoneyCollection.doc(uid).collection(option).doc(uid).set({
      "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,
    });
  }
  Future updateGoals(String money,String options,String mode,String? month)async{
    if(mode=="Every Month"){
      switch(options){
        case "Cosmetic":
          return await userGoalsMoneyCollection.doc(uid).collection("Cosmetic").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        case "Clothes":
          return await userGoalsMoneyCollection.doc(uid).collection("Clothes").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        case "Food":
          return await userGoalsMoneyCollection.doc(uid).collection("Food").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        case "Pet":
          return await userGoalsMoneyCollection.doc(uid).collection("Pet").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        case "Travel":
          return await userGoalsMoneyCollection.doc(uid).collection("Travel").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        case "Vehicles":
          return await userGoalsMoneyCollection.doc(uid).collection("Vehicles").doc(uid).update({
            "Jan": money, "Feb": money, "Mar": money, "Apr": money, "May": money, "Jun": money, "Jul": money, "August": money, "Sep": money, "Oct": money, "Nov": money,"Dec": money,},
          );
        default:
          return;
      }
    }
    else if(mode=="Only Month"&& month!=null){
      switch(options){
        case "Cosmetic":
          return await userGoalsMoneyCollection.doc(uid).collection('Cosmetic').doc(uid).update({month:money});
        case "Clothes":
          return await userGoalsMoneyCollection.doc(uid).collection('Clothes').doc(uid).update({month:money});
        case "Food":
          return await userGoalsMoneyCollection.doc(uid).collection('Food').doc(uid).update({month:money});
        case "Pet":
          return await userGoalsMoneyCollection.doc(uid).collection('Pet').doc(uid).update({month:money});
        case "Travel":
          return await userGoalsMoneyCollection.doc(uid).collection('Travel').doc(uid).update({month:money});
        case "Vehicles":
          return await userGoalsMoneyCollection.doc(uid).collection('Vehicles').doc(uid).update({month:money});
      }
    }
  }
  List<Goals>_moneyDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Goals(
        jan: doc.data().toString().contains('Jan')?doc.get('Jan'):"1",
        feb: doc.data().toString().contains('Feb')?doc.get('Feb'):"1",
        mar: doc.data().toString().contains('Mar')?doc.get('Mar'):"1",
        apr: doc.data().toString().contains('Apr')?doc.get('Apr'):"1",
        may: doc.data().toString().contains('May')?doc.get('May'):"1",
        jun: doc.data().toString().contains('Jun')?doc.get('Jun'):"1",
        jul: doc.data().toString().contains('Jul')?doc.get('Jul'):"1",
        aug: doc.data().toString().contains('Aug')?doc.get('Aug'):"1",
        sep: doc.data().toString().contains('Sep')?doc.get('Sep'):"1",
        oct: doc.data().toString().contains('Oct')?doc.get('Oct'):"1",
        nov: doc.data().toString().contains('Nov')?doc.get('Nov'):"1",
        dec: doc.data().toString().contains('Dec')?doc.get('Dec'):"1",

      );
    }).toList();
  }
  Stream<List<Goals>> get goalsCosmeticData{
    return userGoalsMoneyCollection.doc(uid).collection("Cosmetic").snapshots().map(_moneyDataFromSnapshot);
  }
  Stream<List<Goals>> get goalsClothesData{
    return userGoalsMoneyCollection.doc(uid).collection("Clothes").snapshots().map(_moneyDataFromSnapshot);
  }
  Stream<List<Goals>> get goalsFoodData{
    return userGoalsMoneyCollection.doc(uid).collection("Food").snapshots().map(_moneyDataFromSnapshot);
  }
  Stream<List<Goals>> get goalsPetData{
    return userGoalsMoneyCollection.doc(uid).collection("Pet").snapshots().map(_moneyDataFromSnapshot);
  }
  Stream<List<Goals>> get goalsTravelData{
    return userGoalsMoneyCollection.doc(uid).collection("Travel").snapshots().map(_moneyDataFromSnapshot);
  }
  Stream<List<Goals>> get goalsVehiclesData{
    return userGoalsMoneyCollection.doc(uid).collection("Vehicles").snapshots().map(_moneyDataFromSnapshot);
  }

  //bill user
  Future updateBillData(String money,String? note,String options,DateTime dateTime,DateTime nowDateTime) async{
    return await billCollection.doc(uid).collection(options).add({
      "money":money,
      "note":note,
      "date":Timestamp.fromDate(dateTime),
      "nowDate":Timestamp.fromDate(nowDateTime),
    });
  }
  List<Bills>_billsDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Bills(
          money: doc.data().toString().contains('money') ? doc.get('money') : "0",
          note: doc.data().toString().contains('note') ? doc.get('note') : "0",
          dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
          nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
      );
    }).toList();
  }
  Stream<List<Bills>> get billsData {
    return firestore.collection('bill/izbFkTMPYiSeWrHlatRdwzXblf42/Cosmetic').snapshots().map((_billsDataFromSnapshot));
  }
}