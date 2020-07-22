import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:home_ideator_app/model/shopboard.dart';
import 'package:url_launcher/url_launcher.dart';
class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Items(),
    );
  }
}

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  @override
  void initState() {
    super.initState();

    board = Board("","","","","","");
    databaseReference = database.reference().child("products");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Flexible(child: FirebaseAnimatedList(
            query: databaseReference,
            itemBuilder: (_, DataSnapshot snapshot,
            Animation<double> animation, int index){
              return new Card(
                  child:Container(
                    alignment: Alignment.center,
                    height: 100,
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
                          onTap: () => launch("${boardMessages[index].Website}"),
                          child:Container(
                            height: 100,
                          child: Row(
                            children: <Widget>[
                            Container(
                              width: 50,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage('${boardMessages[index].Image}'),
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                              Container(
                                child:Column(
                                  children:<Widget>[
                              Text('${boardMessages[index].Name}'),
                                    Text('Rs:${boardMessages[index].Cost}'),
                                    
                                ])
                        ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage('${boardMessages[index].EcomImage}'),
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )// handle your onTap here
                        )
                    ),

                  )
              );
            },
          ))
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
