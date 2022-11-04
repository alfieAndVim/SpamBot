import 'package:flutter/material.dart';
import 'package:spambot_2/Authenticate/Auth.dart';
//import 'package:spambot_2/Models/Message.dart';
import 'package:spambot_2/Models/message.dart';
import 'package:spambot_2/ViewModels/MessageViewModel.dart';
import 'dart:async';

TextEditingController modalTextContoller = TextEditingController();
String classSelection = 'Legit';
MessageViewModel messageViewModel = MessageViewModel();
Auth auth = Auth();

MessageRequestView(context, userText, showSnackBar, showBannerAd) {
  modalTextContoller.text = userText.userText;
  FocusScope.of(context).requestFocus(FocusNode());

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return GestureDetector(
            child: Wrap(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          'Request a Message',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 15)
                                  ],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              width: 325,
                              height: 215,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: modalTextContoller,
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
                                  onChanged: (text) {
                                    userText.userText = text;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  'Spam',
                                  style: TextStyle(
                                      color: classSelection == 'Spam'
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: classSelection == 'Spam'
                                        ? Colors.blue
                                        : Colors.white,
                                    side: BorderSide(
                                        color: classSelection == 'Spam'
                                            ? Colors.white
                                            : Colors.blue),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20)))),
                                onPressed: () {
                                  mystate(() {
                                    classSelection = 'Spam';
                                  });
                                  //classSelection = 'Spam';
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Legit',
                                  style: TextStyle(
                                      color: classSelection == 'Legit'
                                          ? Colors.white
                                          : Colors.blue),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: classSelection == 'Legit'
                                        ? Colors.blue
                                        : Colors.white,
                                    side: BorderSide(
                                        color: classSelection == 'Spam'
                                            ? Colors.blue
                                            : Colors.white),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            topRight: Radius.circular(20)))),
                                onPressed: () {
                                  mystate(() {
                                    classSelection = 'Legit';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            var message = Message(
                                className: classSelection,
                                message: modalTextContoller.text);
                            var result =
                                await messageViewModel.addMessage(message);
                            final snackBar = SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: result == 'success' ? Text('Thank you for your submission') : Text('An error has occured'));
                            showSnackBar(snackBar);
                            Navigator.pop(context);

                            print(result);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          );
        });
      }).whenComplete(() => showBannerAd());
}
