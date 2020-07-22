import 'package:firebase_database/firebase_database.dart';


class Board {
  String key;
  String Image;
  String Address;
  String PhoneNo;
  String Name;


  Board(this.Image, this.Name, this.PhoneNo, this.Address);

  Board.fromSnapshot(DataSnapshot snapshot)
      :
        key = snapshot.key,
        Image = snapshot.value["Image"],
        PhoneNo = snapshot.value["PhoneNo"],
        Address = snapshot.value["Address"],
        Name = snapshot.value["Name"];

  toJson() {
    return {
      "Image": Image,
      "PhoneNo": PhoneNo,
      "Address": Address,
      "Name": Name,
    };
  }
}