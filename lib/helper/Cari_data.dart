// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/utils/Api.dart';

class CariData extends StatefulWidget {
  @override
  State<CariData> createState() => _CariDatainState();
}

class _CariDatainState extends State<CariData> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _CariDatainState createState() => _CariDatainState();

  TextEditingController search = TextEditingController();

  List<dynamic> dataPencarian = [];

  Color colorText = Colors.white;
  Color colorCard = Color.fromARGB(255, 194, 173, 240);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(Api.urlAssets + 'background.png'),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    flex: 10,
                    child: Center(
                        child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Cari Data Penawaran",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: colorText),
                      ),
                    )),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: formSearch()),
                  ),
                  Expanded(
                    flex: 85,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: listIsiPenawaran()),
                  ),
                ],
              )),
        )
      ],
    ));
  }

  // FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI

  getDataPencarian() async {
    try {
      var formData = dio.FormData.fromMap({
        "nama_barang": search.text,
      });
      var response = await dio.Dio().post(Api.pencarianDataPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];

      print(data);

      setState(() {
        if (status) {
          data.forEach((element) {
            var data = {
              'id_barang': element['id_barang'],
              'nama_barang': element['nama_barang'],
              'satuan': element['satuan'],
              'qty': element['qty'],
              'harga_satuan': element['harga_satuan'],
              'harga_total': element['harga_total'] == '0'
                  ? '0'
                  : NumberFormat.currency(locale: 'ID', decimalDigits: 0)
                      .format(int.parse(element['harga_total'])),
            };
            dataPencarian.add(data);
          });
        }
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "Data tidak di temukan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  hapusData(id) async {
    try {
      var formData = dio.FormData.fromMap({
        "id_barang": id,
      });
      var response = await dio.Dio().post(Api.hapusDataBarang,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];

      setState(() {
        if (status) {
          dataPencarian.clear();
          getDataPencarian();
          Fluttertoast.showToast(
              msg: "Data berhasil di hapus",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: "Data tidak di temukan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET

  Widget formSearch() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 90,
          child: SizedBox(
            height: 60,
            child: TextField(
              controller: search,
              decoration: InputDecoration(
                hintText: "Cari Data",
              ),
              style:
                  TextStyle(fontSize: 16.0, height: 2.0, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                dataPencarian.clear();
                getDataPencarian();
              });
            },
          ),
        )
      ],
    );
  }

  Widget listIsiPenawaran() {
    return dataPencarian.isEmpty
        ? SizedBox()
        : ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: dataPencarian.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context, dataPencarian[i]);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 30,
                                  child: Text(dataPencarian[i]['nama_barang'],
                                      style: TextStyle(color: colorText))),
                              Expanded(
                                  flex: 8,
                                  child: Text(dataPencarian[i]['qty'],
                                      style: TextStyle(color: colorText))),
                              Expanded(
                                  flex: 12,
                                  child: Text(dataPencarian[i]['satuan'],
                                      style: TextStyle(color: colorText))),
                              Expanded(
                                  flex: 25,
                                  child: Text(dataPencarian[i]['harga_satuan'],
                                      style: TextStyle(color: colorText))),
                              Expanded(
                                  flex: 25,
                                  child: Text(dataPencarian[i]['harga_total'],
                                      style: TextStyle(color: colorText))),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  var id = dataPencarian[i]['id_barang'];
                                  print(id);
                                  hapusData(id);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            });
  }
}
