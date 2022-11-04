import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:spambot_2/ML/Classifier.dart';
import 'package:spambot_2/StateStores/StateStore.dart';

class TextFieldView extends StatefulWidget {
  TextFieldView({Key? key}) : super(key: key);

  @override
  _TextFieldViewState createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  late Classifier _classifier;
  var entryText = '';
  var prediction = [];
  TextEditingController textController = TextEditingController();

  InterstitialAd? _interstitialAd;
  var clearTextCount = 0;

  @override
  void initState() {
    super.initState();
    textController.addListener(fetchText);
    _classifier = Classifier();
    loadInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    final predictionState = Provider.of<Prediction>(context);

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
            border:
                Border.all(color: entryText == '' ? Colors.white : Colors.blue),
            borderRadius: BorderRadius.circular(7),
            color: Colors.white),
        width: 325,
        height: 215,
        child: Column(
          children: [
            SizedBox(
              height: 25,
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: entryText == '' ? 0.0 : 1.0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        clearText(predictionState);
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  entryText = text;
                  classify(predictionState);
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
                maxLines: 5,
                style: TextStyle(height: 1.5, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 25,
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.paste,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pasteText(predictionState);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchText() {
    entryText = textController.text;
    setState(() {});
  }

  void clearText(predictionState) {

    clearTextCount = clearTextCount + 1;
    if (clearTextCount == 2) {
      showInterstitial();
      clearTextCount = 0;
    }

    textController.text = '';
    entryText = '';
    setState(() {});
    classify(predictionState);
    
    
  }

  void pasteText(predictionState) {
    FlutterClipboard.paste().then((value) {
      textController.text = value;
      setState(() {});
      classify(predictionState);
    });
  }

  classify(predictionState) async {
    var truePrediction = '';
    var trueConfidence = 0.0;

    var userText = textController.text;
    userText = userText.toLowerCase();
    //print(_classifier.classify(textController.text));
    prediction = _classifier.classify(userText);
    //prediction = _classifier.classify(textController.text);
    if (prediction[0] > prediction[1]) {
      truePrediction = 'legit';
      trueConfidence = prediction[0];
    } else {
      truePrediction = 'Spam';
      trueConfidence = prediction[1];
    }

    if (entryText == '') {
      truePrediction = 'Start typing..';
      trueConfidence = 0.0;
    }

    predictionState.userText = textController.text;
    predictionState.prediction = truePrediction;
    predictionState.confidence = trueConfidence;
    //print(prediction);
  }

  void loadInterstitial() {

    print('loading interstitial');

    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            this._interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load interstitial ad');
          _interstitialAd?.dispose();
          loadInterstitial();
        }
      )
    );
  }

  void showInterstitial() {

    print('showing interstitial');

    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('Ad dismissed');
        _interstitialAd?.dispose();
        loadInterstitial();
      },

      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('Ad failed to load');
        _interstitialAd?.dispose();
        loadInterstitial();
      }
    );
    _interstitialAd?.show();
  }
}
