import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_ideator_app/dashboard.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Sign in'),
     ),
     body: Form(
       key: _formKey,
       child: Column(
         children: <Widget>[
           Padding(padding:EdgeInsets.all(10.5)),
           Image.asset(
             'images/icon.png',
             width: 90.0,
             height:90.0,),
           TextFormField(
             validator: (input){
               if(input.isEmpty){
                 return 'Email id is invalid';
               }
             },
             onSaved: (input) => _email = input,
             decoration: InputDecoration(
               labelText: 'Email-ID'
             ),
           ),
           TextFormField(
             validator: (input){
               if(input.length<6){
                 return 'Your password must be 6 character';
               }
             },
             onSaved: (input) => _password = input,
             decoration: InputDecoration(
                 labelText: 'Password'
             ),
             obscureText: true,
           ),
         RaisedButton(
           onPressed: signin,
           child: Text('Sign in'),
         ),
         ],
       ),
     ),
   );
  }

  Future<void>signin() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
      FirebaseUser user =  (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
        print(user);
      }catch(e){
        print(e.message);
      }
    }
  }
}

