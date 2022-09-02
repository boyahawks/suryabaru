// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:suryabaru/screen/Dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:suryabaru/utils/Api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suryabaru/utils/Data_aplikasi.dart';
import 'package:suryabaru/utils/Widget.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LogininState();
}

class _LogininState extends State<Login> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _LogininState createState() => _LogininState();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool member = false;
  bool showpassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DoubleBackToCloseApp(
      snackBar: SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 250, 249, 249),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Center(
            child: Text(
              "Tap back again to leave",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(Api.urlAssets + 'background.png'),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    line1(),
                    SizedBox(
                      height: 15,
                    ),
                    line2(),
                  ],
                ),
              ))
        ],
      ),
    ));
  }

  // FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI

  validasiLogin() async {
    try {
      var formData = dio.FormData.fromMap({
        "username": username.text,
        "password": password.text,
      });
      var response = await dio.Dio().post(Api.loginUser,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];

      setState(() {
        if (status) {
          data.forEach((element) {
            print(element['username']);
            AppData.setNameUserLogin = element['username'];
            AppData.setRole = element['role'];
            Navigator.of(context).pushNamed('/dashboard');
          });
        }
      });
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Terjadi Kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET

  Widget line1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("PT. SATRIA DHITA PRATAMA",
              style: GoogleFonts.allerta(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white))),
        ),
      ],
    );
  }

  Widget line2() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 249, 249),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "LOGIN",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.only(left: 20), child: Text("Username")),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                border: Border.all(width: 1.0, color: Colors.black)),
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.supervised_user_circle_outlined),
                ),
                style:
                    TextStyle(fontSize: 14.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: const EdgeInsets.only(left: 20), child: Text("Password")),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 50,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                border: Border.all(width: 1.0, color: Colors.black)),
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: TextField(
                // ignore: unnecessary_this
                obscureText: !this.showpassword,
                controller: password,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.security),
                    // ignore: unnecessary_this
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this.showpassword ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => this.showpassword = !this.showpassword);
                      },
                    )),
                style:
                    TextStyle(fontSize: 14.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    validasiLogin();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Dashboard()),
                    // );
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 60, 172, 174)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
