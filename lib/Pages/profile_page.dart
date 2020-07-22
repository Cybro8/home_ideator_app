import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Details();
  }
}

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("user").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text("Loading...."),
          );
        }else{
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_,index){
          return Container(
            child:Column(
              children:<Widget>[
            Text(snapshot.data[index].data["Name"]),
                Text(snapshot.data[index].data["Address"])
            ],)
          );
        });
        }
      }),
    );
  }
}

