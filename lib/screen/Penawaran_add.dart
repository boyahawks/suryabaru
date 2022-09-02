// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/helper/Cari_data.dart';
import 'package:suryabaru/helper/List_data.dart';
import 'package:suryabaru/utils/Api.dart';

class PenawaranAdd extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var value1, value2;
  // ignore: use_key_in_widget_constructors
  PenawaranAdd(this.value1, this.value2);

  @override
  State<PenawaranAdd> createState() => _PenawaranAddinState();
}

class _PenawaranAddinState extends State<PenawaranAdd> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _PenawaranAddinState createState() => _PenawaranAddinState();

  TextEditingController idPenawaran = TextEditingController();
  TextEditingController kepada = TextEditingController();
  TextEditingController namaPT = TextEditingController();
  TextEditingController proyek = TextEditingController();
  TextEditingController tanggalPenawaran = TextEditingController();
  TextEditingController idIsiPenawaran = TextEditingController();
  TextEditingController namaBarang = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController satuan = TextEditingController();
  TextEditingController hargaSatuan = TextEditingController();
  TextEditingController hargaTotal = TextEditingController();
  TextEditingController search = TextEditingController();

  List<dynamic> isiPenawaran = [];
  List<dynamic> dataPencarian = [];

  Color colorText = Colors.white;
  Color colorCard = Color.fromARGB(255, 194, 173, 240);

  bool statusButton = false;

  @override
  void initState() {
    getValue();
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    statusButton == false
                        ? Center(
                            child: Text(
                            "Tambah Data Penawaran Harga",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colorText),
                          ))
                        : Center(
                            child: Text(
                            "Update Data Penawaran Harga",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colorText),
                          )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: formPenawaran()),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        height: 300,
                        child: listIsiPenawaran()),
                    SizedBox(
                      height: 5,
                    ),
                    statusButton == false
                        ? Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    dialogValidasiTambah();
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: colorCard,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                      bottomRight: Radius.circular(32),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tambah Data",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )))
                        : Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    dialogValidasiTambah();
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: colorCard,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                      bottomRight: Radius.circular(32),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Update Data",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),
                  ],
                ),
              )),
        )
      ],
    ));
  }

  // FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI

  getValue() {
    print(widget.value1);
    print(widget.value2);
    if (widget.value1 != '' || widget.value2 != '') {
      statusButton = true;
      idPenawaran.text = widget.value1['id_penawaran'];
      kepada.text = widget.value1['kepada_nama'];
      namaPT.text = widget.value1['kepada_pt'];
      proyek.text = widget.value1['proyek'];
      tanggalPenawaran.text = widget.value1['tanggal_penawaran'];
      isiPenawaran = widget.value2;
    } else {
      statusButton = false;
    }
  }

  kirimTambahDataPenawaran() async {
    var arrayisi = '';
    // ignore: prefer_is_empty
    if (isiPenawaran.length != 0) {
      for (var i = 0; i < isiPenawaran.length; i++) {
        if (arrayisi == '') {
          arrayisi =
              '${isiPenawaran[i]['nama_barang']},${isiPenawaran[i]['satuan']},${isiPenawaran[i]['qty']},${isiPenawaran[i]['harga_satuan']},${isiPenawaran[i]['harga_total'].replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll('IDR', '')}';
        } else {
          arrayisi =
              '$arrayisi|${isiPenawaran[i]['nama_barang']},${isiPenawaran[i]['satuan']},${isiPenawaran[i]['qty']},${isiPenawaran[i]['harga_satuan']},${isiPenawaran[i]['harga_total'].replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll('IDR', '')}';
        }
      }
    }
    try {
      var formData = dio.FormData.fromMap({
        "id_isi_penawaran": '',
        "nama_pt": namaPT.text,
        "kepada": kepada.text,
        "nama_proyek": proyek.text,
        "tanggal_penawaran": tanggalPenawaran.text,
        "isi_penawaran": arrayisi,
      });
      var response = await dio.Dio().post(Api.tambahDataPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          Fluttertoast.showToast(
              msg: "Berhasil tambah data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Terjadi Kesalahan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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

  updatePenawaranHarga() async {
    try {
      var formData = dio.FormData.fromMap({
        "id_penawaran": idPenawaran.text,
        "nama_pt": namaPT.text,
        "kepada": kepada.text,
        "nama_proyek": proyek.text,
        "tanggal_penawaran": tanggalPenawaran.text,
      });
      var response = await dio.Dio().post(Api.updateDataPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          Fluttertoast.showToast(
              msg: "Berhasil update data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
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

  updateIsiPenawaranServer() async {
    try {
      var formData = dio.FormData.fromMap({
        "id_isi_penawaran": idIsiPenawaran.text,
        "nama_barang": namaBarang.text,
        "satuan": satuan.text,
        "qty": qty.text,
        "harga_satuan": hargaSatuan.text,
        "harga_total": hargaTotal.text
            .replaceAll(RegExp('[^A-Za-z0-9]'), '')
            .replaceAll('IDR', '')
      });
      var response = await dio.Dio().post(Api.updateDataIsiPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          Fluttertoast.showToast(
              msg: "Isi penawaran berhasil di update",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
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

  Widget formPenawaran() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nama PT",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListData('listPT'))).then((value) {
                if (value != null) {
                  setState(() {
                    print(value);
                    namaPT.text = value['nama_pt'];
                  });
                }
              });
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(namaPT.text))),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Proyek",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            setState(() {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListData('listProyek')))
                  .then((value) {
                if (value != null) {
                  setState(() {
                    print(value);
                    proyek.text = value['nama_proyek'];
                    kepada.text = value['nama_logistic'];
                  });
                }
              });
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(proyek.text))),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Kepada",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(kepada.text))),
        SizedBox(
          height: 10,
        ),
        Text(
          "Tanggal",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: SizedBox(
              height: 40,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller:
                      tanggalPenawaran, //editing controller of this TextField
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),

                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        tanggalPenawaran.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            )),
        SizedBox(height: 20),
        statusButton == false
            ? TextButton(
                onPressed: () {
                  setState(() {
                    formIsiPenawaran('');
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorCard,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Isi penawaran",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ))
            : SizedBox()
      ],
    );
  }

  Widget listIsiPenawaran() {
    return Container(
      margin: EdgeInsets.zero,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: isiPenawaran.length,
          scrollDirection: Axis.vertical,
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 40),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (statusButton == false) {
                        hapusDataPenawaran(isiPenawaran[index]);
                      } else {
                        idIsiPenawaran.text =
                            isiPenawaran[index]['id_isi_penawaran'];
                        namaBarang.text = isiPenawaran[index]['nama_barang'];
                        qty.text = isiPenawaran[index]['qty'];
                        satuan.text = isiPenawaran[index]['satuan'];
                        hargaSatuan.text = isiPenawaran[index]['harga_satuan']
                            .replaceAll(RegExp('[^A-Za-z0-9]'), '')
                            .replaceAll('IDR', '');
                        hargaTotal.text = isiPenawaran[index]['harga_total'];
                        formIsiPenawaran(index);
                      }
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 30,
                          child: Text(
                            isiPenawaran[index]['nama_barang'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 8,
                          child: Text(
                            isiPenawaran[index]['qty'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 12,
                          child: Text(
                            isiPenawaran[index]['satuan'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 25,
                          child: Text(
                            isiPenawaran[index]['harga_satuan'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 25,
                          child: Text(
                            isiPenawaran[index]['harga_total'],
                            style: TextStyle(color: colorText),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  height: 5,
                  color: colorText,
                ),
                SizedBox(height: 10),
              ],
            );
          }),
    );
  }

  formIsiPenawaran(index) {
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
                        "ISI PENAWARAN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CariData()))
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  namaBarang.text = value['nama_barang'];
                                  qty.text = value['qty'];
                                  satuan.text = value['satuan'];
                                  hargaSatuan.text = value['harga_satuan'];
                                  hargaTotal.text = value['harga_total'];
                                });
                              }
                            });
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: colorCard,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Cari Data",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 80,
                      child: TextField(
                        controller: namaBarang,
                        decoration: InputDecoration(
                          labelText: "Nama Barang",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: qty,
                        decoration: InputDecoration(
                          labelText: "Jumlah",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: satuan,
                        decoration: InputDecoration(
                          labelText: "Satuan",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: hargaSatuan,
                        decoration: InputDecoration(
                          labelText: "Harga Satuan",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            var jumlah = int.parse(qty.text);
                            var getHargaSatuan = int.parse(value);
                            var hitung = jumlah * getHargaSatuan;
                            hargaTotal.text = NumberFormat.currency(
                                    locale: 'ID', decimalDigits: 0)
                                .format(hitung);
                          });
                        },
                        style: TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: hargaTotal,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Harga Total",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16.0, height: 2.0, color: Colors.black),
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
                    if (statusButton == false) {
                      if (namaBarang.text == '' ||
                          qty.text == '' ||
                          satuan.text == '' ||
                          hargaSatuan.text == '') {
                        Fluttertoast.showToast(
                            msg: "Harap lengkapi form terlebih dahulu",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        var data = {
                          'nama_barang': namaBarang.text,
                          'qty': qty.text,
                          'satuan': satuan.text,
                          'harga_satuan': hargaSatuan.text,
                          'harga_total': hargaTotal.text,
                        };
                        isiPenawaran.add(data);
                        namaBarang.text = '';
                        qty.text = '';
                        satuan.text = '';
                        hargaSatuan.text = '';
                        hargaTotal.text = '';
                        Navigator.of(context).pop(true);
                      }
                    } else {
                      var update = {
                        'id_isi_penawaran': idIsiPenawaran.text,
                        'nama_barang': namaBarang.text,
                        'satuan': satuan.text,
                        'qty': qty.text,
                        'harga_satuan': hargaSatuan.text,
                        'harga_total': hargaTotal.text,
                      };
                      isiPenawaran[index] = update;
                      print("id isi penawaran ${idIsiPenawaran.text}");
                      updateIsiPenawaranServer();
                    }
                  });
                },
                child: statusButton ? Text("Update") : Text("Tambah")),
          ],
        );
      },
    );
  }

  hapusDataPenawaran(value) {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    "Yakin hapus data ini ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            print("Batal");
                            Navigator.pop(context, true);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 210, 38, 38),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                "BATAL",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorText),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isiPenawaran.remove(value);
                            Navigator.pop(context, true);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                "Hapus data",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorText),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  dialogValidasiTambah() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            margin:
                const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    "Apakah data sudah benar ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            print("Batal");
                            Navigator.pop(context, true);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 210, 38, 38),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                "BATAL",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorText),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isiPenawaran.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Lengkapi data terlebih dahulu",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              !statusButton
                                  ? kirimTambahDataPenawaran()
                                  : updatePenawaranHarga();
                            }
                            Navigator.pop(context, true);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              child: !statusButton
                                  ? Text(
                                      "Tambah",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorText),
                                    )
                                  : Text(
                                      "Update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorText),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
