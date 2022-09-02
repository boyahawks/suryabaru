// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsAlert {
  static showAlert(BuildContext context, value) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Center(
              child: Text(value),
            )
          ],
        ),
      ),
      actions: [okButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
                width: 150,
                height: 150,
                color: Colors.black.withOpacity(0.8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          child: Container(
                              child: CircularProgressIndicator(strokeWidth: 3),
                              width: 32,
                              height: 32),
                          padding: EdgeInsets.only(bottom: 16)),
                      Padding(
                          child: Text(
                            'Please wait …',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.only(bottom: 4))
                    ])));
      },
    );
  }

  static showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 12);
  }
}
