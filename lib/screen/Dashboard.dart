// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/utils/Api.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardinState();
}

class _DashboardinState extends State<Dashboard> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _DashboardinState createState() => _DashboardinState();

  List<dynamic> users = [];

  Color colorText = Colors.white;
  Color colorCard = Color.fromARGB(255, 194, 173, 240);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(Api.urlAssets + 'background.png'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(
                        margin: const EdgeInsets.only(top: 30), child: line1()),
                  ),
                  Expanded(
                    flex: 85,
                    child: line2(),
                  ),
                ],
              ))
        ],
      )),
    );
  }

  // FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI

  Widget line1() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Center(
                    child: Text("Surya Baru Abadi",
                        style: GoogleFonts.allerta(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget line2() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(
            height: 50,
          ),
          sub2(),
        ],
      ),
    );
  }

  Widget sub2() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                print("menu absensi");
                Navigator.of(context).pushNamed('/penawaran');
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.network(Api.urlAssets + 'menu_absen.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Penawaran Harga",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: colorText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                print("menu keuangan");
                Navigator.of(context).pushNamed('/invoice');
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.network(Api.urlAssets + 'menu_keuangan.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Invoice",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: colorText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
