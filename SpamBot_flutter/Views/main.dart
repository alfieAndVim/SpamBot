import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spambot_2/Views/HomePageView.dart';
import 'package:flutter/services.dart';
import 'package:spambot_2/StateStores/StateStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, systemNavigationBarColor: Colors.black));
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.transparent),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Did not start properly');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => Prediction(),
            child: Scaffold(
              body: HomePageView(),
            ),
          );
        }

        return Text('Still loading');
      },
    );
  }
}
