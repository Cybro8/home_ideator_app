import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_ideator_app/auth_service.dart';
import 'package:home_ideator_app/model/board.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(new Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Home Ideator',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override

  void initState(){
    super.initState();
    board = Board("","","","","");

      void inputData() async {
        try {
          final FirebaseUser user = await auth.currentUser();
          String uid = user.uid;
          databaseReference = database.reference().child('user').child('${uid}');
          databaseReference.onChildAdded.listen(_onEntryAdded);
          databaseReference.onChildChanged.listen(_onEntryChanged);
        }catch(e){
         print("Fine");
        }
        }
    inputData();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Flexible(
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new Card(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 200.0,
                    //color: Colors.black12,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6.0,
                        ),]
                    ),

                    child:new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:<Widget>[
                      Text("${boardMessages[index].Name}"),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 9.0,
                          percent: 0.25,
                          animation: true,
                          animationDuration: 1000,
                          center: new Text("${boardMessages[index].Voltage}V"),
                          progressColor: Colors.green,
                        ),
                        new CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 9.0,
                          percent: 0.5,
                          animation: true,
                          animationDuration: 1000,
                          center: new Text("${boardMessages[index].Current}A"),
                          progressColor: Colors.redAccent,
                        ),
                        new CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 9.0,
                          percent: 0.01,
                          animation: true,
                          animationDuration: 1000,
                          center: new Text("${boardMessages[index].Power}W"),
                          progressColor: Colors.blueAccent,
                        ),
                      ],
                    ),
                        Center(
                        child:Container(
                          alignment: Alignment.center,
                          height: 40,
                          width:370,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 13.0,
                                color: Colors.black.withOpacity(.3),
                                offset: Offset(6.0, 7.0),
                              ),
                            ],
                            color: Colors.white,
                          ),
                            child:Material(
                          child:InkWell(
                            onTap: () => launch("${boardMessages[index].Website}"), // handle your onTap here
                            child: Container(
                                height: 40,
                            child:new Center(
                            child:Text("Replace"))
                            ),
                          )
                        ),
                        )
                        )
                    ],
                ),

                  ),
                );
              },
            ),

          ),
        ],
      ),
    );
  }


  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] =
          Board.fromSnapshot(event.snapshot);
    });
  }

}
