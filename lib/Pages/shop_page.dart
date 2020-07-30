import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Future getProduct() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('shop').getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getProduct(),
        builder: (_,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('Loading....'),
          );
        }else{
          return ListView.builder(
            itemCount: snapshot.data.length,
              itemBuilder: (_,index){
                return Card(
                  child:InkWell(
                      onTap:() {
                        launch(snapshot.data[index].data['Website']);
                      },
                  child:Column(
                    children:<Widget>[
                  Text(snapshot.data[index].data['Name']),
                  Row(
                    children:<Widget>[
                  Image.network(snapshot.data[index].data['Image'],
                  width: 100,
                  height: 100,),
                      Text(snapshot.data[index].data['Rating']),
                      Image.network(snapshot.data[index].data['Ecom'],
                      width:50,
                      height: 50,)
                      ]
                  ),
                      Text("Rs:${snapshot.data[index].data["Cost"]}"),
                    ]
                )
                  )
                );
              });
        }
      },)
    );
  }


}

