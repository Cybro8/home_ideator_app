import 'package:firebase_database/firebase_database.dart';


class Board {
  String key;
  String Image;
  String EcomImage;
  String Rating;
  String Website;
  String Name;
  String Cost;


  Board(this.Image, this.EcomImage, this.Rating, this.Website, this.Name,this.Cost);

  Board.fromSnapshot(DataSnapshot snapshot)
      :
        key = snapshot.key,
        Image = snapshot.value["Image"],
        EcomImage = snapshot.value["EcomImage"],
        Rating = snapshot.value["Rating"],
        Name = snapshot.value["Name"],
        Website = snapshot.value["Website"],
        Cost = snapshot.value["Cost"];

  toJson() {
    return {
      "Image": Image,
      "EcomImage": EcomImage,
      "Rating": Rating,
      "Website": Website,
      "Name": Name,
      "Cost":Cost,
    };
  }
}