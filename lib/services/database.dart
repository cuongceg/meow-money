import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/models/money.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection= FirebaseFirestore.instance.collection('user');
  final CollectionReference userGoalsMoneyCollection= FirebaseFirestore.instance.collection('money');
  final CollectionReference testBillCollection=FirebaseFirestore.instance.collection("bill");
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final formatMonth=DateFormat('MM-yyyy');
  final format=DateFormat('hh-mm-ss-dd-MM-yyyy');

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
      if(doc.exists){
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
      }
      else{
        return Goals(jan: '1000', feb:'1000', mar:'1000', apr: '1000', may: '1000', jun: '1000', jul: '1000', aug: '1000', sep: '1000', oct: '1000', nov: '1000', dec:'1000');
      }
    }).toList();
  }
  Stream<List<Goals>> get goalsCosmeticData{
    return firestore.collection("money/izbFkTMPYiSeWrHlatRdwzXblf42/Cosmetic").snapshots().map(_moneyDataFromSnapshot);
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
  Future addTestBillData(String money,String? note,String options,DateTime dateTime,DateTime nowDateTime,String? userid) async{
    return await testBillCollection.doc(options).collection(formatMonth.format(dateTime)).add({
      "money":money,
      "note":note,
      "date":Timestamp.fromDate(dateTime),
      "option":options,
      "nowDate":Timestamp.fromDate(nowDateTime),
      "uid":userid,
      "idTouch":format.format(nowDateTime),
    });
  }

  void updateDocument(String searchValue,String option,String money,String? note,DateTime dateTime) async {
    String collectPath='';
    switch(option){
      case "Clothes":
        collectPath="bill/Clothes/11-2023";
        break;
      case "Cosmetic":
        collectPath="bill/Cosmetic/11-2023";
        break;
      case "Food":
        collectPath="bill/Food/11-2023";
        break;
      case "Pet":
        collectPath="bill/Pet/11-2023";
        break;
      case "Travel":
        collectPath="bill/Travel/11-2023";
        break;
      case "Vehicles":
        collectPath="bill/Vehicles/11-2023";
        break;
      default:
        collectPath='bill/Cosmetic/11-2023';
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectPath)
        .where("idTouch", isEqualTo: searchValue)
        .get();
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      // Lấy ID của document
      String documentId = document.id;

      // Lấy dữ liệu từ document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Cập nhật dữ liệu (thay đổi giá trị của một trường)
      data['money'] = money;
      data['note']=note;
      data['date']=Timestamp.fromDate(dateTime);

      // Cập nhật document với dữ liệu mới
      await FirebaseFirestore.instance
          .collection(collectPath)
          .doc(documentId)
          .update(data);
    }
  }
  void deleteDocument(String searchValue,String option) async {
    String collectPath='';
    switch(option){
      case "Clothes":
        collectPath="bill/Clothes/11-2023";
        break;
      case "Cosmetic":
        collectPath="bill/Cosmetic/11-2023";
        break;
      case "Food":
        collectPath="bill/Food/11-2023";
        break;
      case "Pet":
        collectPath="bill/Pet/11-2023";
        break;
      case "Travel":
        collectPath="bill/Travel/11-2023";
        break;
      case "Vehicles":
        collectPath="bill/Vehicles/11-2023";
        break;
      default:
        collectPath='bill/Cosmetic/11-2023';
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectPath)
        .where("idTouch", isEqualTo: searchValue)
        .get();
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      String documentId = document.id;
      await FirebaseFirestore.instance
          .collection(collectPath)
          .doc(documentId)
          .delete();
    }
  }

  List<BillsClothes>_billsClothesDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsClothes(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }
  List<BillsCosmetic>_billsCosmeticDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsCosmetic(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }
  List<BillsFood>_billsFoodDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsFood(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }
  List<BillsPet>_billsPetDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsPet(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }
  List<BillsTravel>_billsTravelDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsTravel(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }
  List<BillsVehicles>_billsVehiclesDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BillsVehicles(
        money: doc.data().toString().contains('money') ? doc.get('money') : "0",
        option: doc.data().toString().contains('option') ? doc.get('option') : "0",
        note: doc.data().toString().contains('note') ? doc.get('note') : "0",
        dateTime:doc.data().toString().contains('date')?doc.get('date').toDate():DateTime.now(),
        nowDateTime:doc.data().toString().contains('nowDate')?doc.get('nowDate').toDate():DateTime.now(),
        uid:doc.data().toString().contains('uid')?doc.get('uid'):'0',
        idTouch:doc.data().toString().contains('idTouch')?doc.get('idTouch'):'0',
      );
    }).toList();
  }

  Stream<List<BillsClothes>> get clothesBillsData {
    return firestore.collection('bill/Clothes/${formatMonth.format(DateTime.now())}').snapshots().map((_billsClothesDataFromSnapshot));
  }
  Stream<List<BillsCosmetic>> get cosmeticBillsData {
    return firestore.collection('bill/Cosmetic/${formatMonth.format(DateTime.now())}').snapshots().map((_billsCosmeticDataFromSnapshot));
  }
  Stream<List<BillsFood>> get foodBillsData {
    return firestore.collection('bill/Food/${formatMonth.format(DateTime.now())}').snapshots().map((_billsFoodDataFromSnapshot));
  }
  Stream<List<BillsPet>> get petBillsData {
    return firestore.collection('bill/Pet/${formatMonth.format(DateTime.now())}').snapshots().map((_billsPetDataFromSnapshot));
  }
  Stream<List<BillsTravel>> get travelBillsData {
    return firestore.collection('bill/Travel/${formatMonth.format(DateTime.now())}').snapshots().map((_billsTravelDataFromSnapshot));
  }
  Stream<List<BillsVehicles>> get vehiclesBillsData {
    return firestore.collection('bill/Vehicles/${formatMonth.format(DateTime.now())}').snapshots().map((_billsVehiclesDataFromSnapshot));
  }
}