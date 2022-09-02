// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/utils/Api.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ListData extends StatefulWidget {
  var value;
  ListData(this.value);

  @override
  State<ListData> createState() => _ListDatainState();
}

class _ListDatainState extends State<ListData> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _ListDatainState createState() => _ListDatainState();

  TextEditingController search = TextEditingController();
  TextEditingController addNamePT = TextEditingController();
  TextEditingController addNameProyek = TextEditingController();
  TextEditingController addAlamatProyek = TextEditingController();
  TextEditingController addNameLogistic = TextEditingController();

  List<dynamic> dataPencarian = [];
  List<dynamic> dataPencarianDisplay = [];

  Color colorText = Colors.white;
  Color colorCard = Color.fromARGB(255, 194, 173, 240);

  @override
  void initState() {
    getData();
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
                        "Cari Data",
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
                        margin: const EdgeInsets.only(left: 25, right: 10),
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

  getData() async {
    try {
      if (widget.value == 'listPT') {
        var response = await dio.Dio()
            .get(Api.getListPT, options: Options(headers: Api.headers));
        var data = response.data['data'];
        var status = response.data['status'];
        var message = response.data['message'];

        setState(() {
          dataPencarian = data;
          dataPencarianDisplay = data;
        });
      } else if (widget.value == 'listProyek') {
        var response = await dio.Dio()
            .get(Api.getListProyek, options: Options(headers: Api.headers));
        var data = response.data['data'];
        var status = response.data['status'];
        var message = response.data['message'];

        setState(() {
          dataPencarian = data;
          dataPencarianDisplay = data;
        });
      }
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

  aksiTambahDataPT() async {
    try {
      var formData = dio.FormData.fromMap({"nama_pt": addNamePT.text});
      var response = await dio.Dio().post(Api.tambahDataPT,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          dataPencarian.clear();
          dataPencarianDisplay.clear();
          Fluttertoast.showToast(
              msg: "Berhasil tambah data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          getData();
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

  aksiTambahDataProyek() async {
    try {
      var formData = dio.FormData.fromMap({
        "nama_proyek": addNameProyek.text,
        "alamat_proyek": addAlamatProyek.text,
        "nama_logistic": addNameLogistic.text,
      });
      var response = await dio.Dio().post(Api.tambahDataProyek,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          dataPencarian.clear();
          dataPencarianDisplay.clear();
          Fluttertoast.showToast(
              msg: "Berhasil tambah data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          getData();
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

  Widget formSearch() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: "Cari Data",
                    ),
                    style: TextStyle(
                        fontSize: 16.0, height: 2.0, color: Colors.white),
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        if (widget.value == 'listPT') {
                          dataPencarian = dataPencarianDisplay.where((data) {
                            var namaPT = data['nama_pt'].toLowerCase();
                            return namaPT.contains(text);
                          }).toList();
                        } else if (widget.value == 'listProyek') {
                          dataPencarian = dataPencarianDisplay.where((data) {
                            var namaPT = data['nama_proyek'].toLowerCase();
                            var namaLogistik =
                                data['nama_logistic'].toLowerCase();
                            return namaPT.contains(text) ||
                                namaLogistik.contains(text);
                          }).toList();
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 20,
          child: Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  if (widget.value == 'listPT') {
                    formAddListPT();
                  } else if (widget.value == 'listProyek') {
                    formAddListProyek();
                  } else {
                    print('tidak ada');
                  }
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget listIsiPenawaran() {
    return dataPencarian.isEmpty
        ? SizedBox(
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: const [Colors.white],
              strokeWidth: 2,
            ),
          )
        : Container(
            margin: EdgeInsets.zero,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: dataPencarian.length,
                padding: const EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 40),
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context, dataPencarian[i]);
                            });
                          },
                          child: widget.value == 'listPT'
                              ? Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                  dataPencarian[i]['nama_pt'],
                                                  style: TextStyle(
                                                      color: colorText,
                                                      fontWeight:
                                                          FontWeight.bold)))),
                                    ],
                                  ),
                                )
                              : widget.value == 'listProyek'
                                  ? Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 35,
                                              child: Center(
                                                  child: Text(
                                                      dataPencarian[i]
                                                          ['nama_proyek'],
                                                      style: TextStyle(
                                                          color: colorText,
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                          Expanded(
                                              flex: 35,
                                              child: Center(
                                                  child: Text(
                                                      dataPencarian[i]
                                                          ['alamat_proyek'],
                                                      style: TextStyle(
                                                          color: colorText,
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                          Expanded(
                                              flex: 30,
                                              child: Center(
                                                  child: Text(
                                                      dataPencarian[i]
                                                          ['nama_logistic'],
                                                      style: TextStyle(
                                                          color: colorText,
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                        ],
                                      ),
                                    )
                                  : SizedBox()),
                      Divider(
                        height: 5,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }),
          );
  }

  formAddListPT() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 8, right: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Center(
                      child: Text(
                        "Tambah PT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("Nama PT")),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                        color: colorCard,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: TextField(
                          controller: addNamePT,
                          cursorColor: Colors.black,
                          cursorHeight: 1.0,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14.0, height: 2.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    print("Batal");
                    Navigator.pop(context, true);
                  });
                },
                child: Text("Tutup")),
            TextButton(
                onPressed: () {
                  setState(() {
                    aksiTambahDataPT();
                  });
                },
                child: Text("Tambah")),
          ],
        );
      },
    );
  }

  formAddListProyek() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 8, right: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Center(
                      child: Text(
                        "Tambah Proyek",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("Nama Proyek")),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                        color: colorCard,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: TextField(
                          controller: addNameProyek,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                          cursorHeight: 1.0,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14.0, height: 2.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("Alamat Proyek")),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                        color: colorCard,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: TextField(
                          controller: addAlamatProyek,
                          cursorColor: Colors.black,
                          cursorHeight: 1.0,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14.0, height: 2.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("Nama Logistik")),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                        color: colorCard,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: TextField(
                          controller: addNameLogistic,
                          cursorColor: Colors.black,
                          cursorHeight: 1.0,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 14.0, height: 2.0, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    print("Batal");
                    Navigator.pop(context, true);
                  });
                },
                child: Text("Tutup")),
            TextButton(
                onPressed: () {
                  setState(() {
                    aksiTambahDataProyek();
                  });
                },
                child: Text("Tambah")),
          ],
        );
      },
    );
  }
}
