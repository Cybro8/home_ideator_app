import 'package:flutter/material.dart';
import 'package:home_ideator_app/Setup/welcome_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home:MyApp(),
  ));
}
class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        backgroundColor: Colors.white,
        image: Image.asset('images/splash.png',
        ),
        loadingText: Text('Loading...'),
        loaderColor: Colors.blue,
        photoSize: 150.0,
        navigateAfterSeconds: WelcomePage(),
    );
  }
}
