import 'package:flutter/material.dart';
import 'package:spambot_2/Authenticate/auth.dart';
import 'package:spambot_2/Views/ConfidenceView.dart';
import 'package:spambot_2/Views/MessageRequestView.dart';
import 'package:spambot_2/Views/PredictionView.dart';
import 'package:spambot_2/Views/TextFieldView.dart';
import 'package:provider/provider.dart';
import 'package:spambot_2/StateStores/StateStore.dart';
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:user_messaging_platform/user_messaging_platform.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  
  final Auth _auth = Auth();

  final BannerAd _bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener()
  );

  void initState() {
    super.initState();
    _auth.signInAnon();
    _bannerAd.load();
  }

  bool showBannerAd = true;

  @override
  Widget build(BuildContext context) {
    final confidence = Provider.of<Prediction>(context);
    return GestureDetector(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'SpamBot',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 32),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Message',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700, fontSize: 16),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 150),
                                        child: ElevatedButton(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              primary: Colors.blue),
                                          onPressed: () {
                                            toggleBannerAd();
                                            MessageRequestView(context, confidence, displaySnackBar, toggleBannerAd);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFieldView(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        'Prediction',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700, fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 90.0),
                                      child: Text(
                                        'Confidence',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700, fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [PredictionView(), ConfidenceView()],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    child: showBannerAd == true ? AdWidget(ad: _bannerAd) : null,
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                  ),
                ),
            ],
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  void displaySnackBar(SnackBar snackBar) {
    Timer(Duration(milliseconds: 500), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void toggleBannerAd() {
    if (showBannerAd == true) {
      showBannerAd = false;
    } else {
      showBannerAd = true;
    }
    setState(() {});
  }


}
