import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_ideator_app/Setup/signin.dart';
import 'package:firebase_database/firebase_database.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  final DBRef = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.5)),
            Image.asset(
              'images/icon.png',
              width: 90.0,
              height:90.0,),
            TextFormField(
              validator: (String input){
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
              validator: ( input){
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
              onPressed: signUp,
              child: Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void>signUp() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user =  (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        final uid = user.uid;
        DBRef.child('$uid').child('Device1').set({
          'Voltage':'O',
          'Current':'O',
          'Power':'0',
        });
        debugPrint('$uid');
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
