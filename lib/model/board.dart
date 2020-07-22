import 'package:firebase_database/firebase_database.dart';


class Board {
   String key;
   String Current;
   String Power;
   String Voltage;
   String Website;
   String Name;


   Board(this.Current, this.Power, this.Voltage, this.Website, this.Name);

  Board.fromSnapshot(DataSnapshot snapshot) :
          key = snapshot.key,
          Current = snapshot.value["Current"],
          Power = snapshot.value["Power"],
          Voltage = snapshot.value["Voltage"],
          Name = snapshot.value["Name"],
          Website = snapshot.value["Website"];

   toJson() {
      return {
         "Current": Current,
         "Power" : Power,
         "Voltage":Voltage,
        "Website":Website,
        "Name":Name,
      };
   }



}