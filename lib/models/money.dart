class Goals{
  String jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec;
  Goals({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec});
}

class BillsCosmetic{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsCosmetic({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class BillsClothes{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsClothes({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class BillsFood{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsFood({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class BillsPet{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsPet({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class BillsTravel{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsTravel({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class BillsVehicles{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  BillsVehicles({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}