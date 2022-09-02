import 'package:suryabaru/helper/Cari_data.dart';
import 'package:suryabaru/helper/List_data.dart';
import 'package:suryabaru/screen/Invoice.add.dart';
import 'package:suryabaru/screen/Invoice.dart';
import 'package:suryabaru/screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:suryabaru/screen/Penawaran.dart';
import 'package:suryabaru/screen/Penawaran_add.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suryabaru/utils/Local_storage.dart';

// screens

import 'package:suryabaru/screen/Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.prefs = await SharedPreferences.getInstance();
  await Permission.camera.request();
  runApp(MyApp());
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aplikasi Sistem Manajemen',
        theme: ThemeData(fontFamily: 'archivo'),
        initialRoute: "/dashboard",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => Login(),
          "/dashboard": (BuildContext context) => Dashboard(),
          "/penawaran": (BuildContext context) => Penawaran(),
          "/invoice": (BuildContext context) => Invoice(),
          "/penawaranAdd": (BuildContext context) => PenawaranAdd('', ''),
          "/invoiceAdd": (BuildContext context) => InvoiceAdd('', ''),
          "/cariData": (BuildContext context) => CariData(),
          "/listData": (BuildContext context) => ListData(''),
        });
  }
}
