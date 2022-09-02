// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/helper/Cari_data.dart';
import 'package:suryabaru/helper/List_data.dart';
import 'package:suryabaru/utils/Api.dart';

class InvoiceAdd extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var value1, value2;
  // ignore: use_key_in_widget_constructors
  InvoiceAdd(this.value1, this.value2);

  @override
  State<InvoiceAdd> createState() => _InvoiceAddinState();
}

class _InvoiceAddinState extends State<InvoiceAdd> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _InvoiceAddinState createState() => _InvoiceAddinState();

  TextEditingController idInvoice = TextEditingController();
  TextEditingController nomorInvoice = TextEditingController();
  TextEditingController kepadaPT = TextEditingController();
  TextEditingController proyek = TextEditingController();
  TextEditingController alamatProyek = TextEditingController();
  TextEditingController nomorSJ = TextEditingController();
  TextEditingController persenDiskon = TextEditingController();
  TextEditingController totalDiskon = TextEditingController();
  TextEditingController totalRounded = TextEditingController();
  TextEditingController tanggalInvoice = TextEditingController();

  TextEditingController idIsiInvoice = TextEditingController();
  TextEditingController namaBarang = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController satuan = TextEditingController();
  TextEditingController hargaSatuan = TextEditingController();
  TextEditingController hargaTotal = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController terbilang = TextEditingController();
  TextEditingController totalInvoice = TextEditingController();

  List<dynamic> isiInvoice = [];
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
                            "Tambah Data Invoice",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colorText),
                          ))
                        : Center(
                            child: Text(
                            "Update Data Invoice",
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
                        child: formInvoice()),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        height: 300,
                        child: listIsiInvoice()),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                var hitungNominal = 0;
                                isiInvoice.forEach((element) {
                                  var filter = element['harga_total']
                                      .replaceAll(RegExp('[^A-Za-z0-9]'), '')
                                      .replaceAll('IDR', '');
                                  hitungNominal += int.parse(filter);
                                });
                                var getTotalDiskon = totalDiskon.text == ''
                                    ? 0
                                    : int.parse(totalDiskon.text);
                                var getTotalRounded = totalRounded.text == ''
                                    ? 0
                                    : int.parse(totalRounded.text);
                                int validasiDiskonRounded = 0;
                                print(getTotalDiskon);
                                print(getTotalRounded);
                                if (getTotalDiskon != 0) {
                                  validasiDiskonRounded =
                                      hitungNominal - getTotalDiskon;
                                } else {
                                  validasiDiskonRounded = hitungNominal;
                                }
                                if (getTotalRounded != 0) {
                                  validasiDiskonRounded =
                                      validasiDiskonRounded - getTotalRounded;
                                }
                                print(validasiDiskonRounded);
                                totalInvoice.text = "$validasiDiskonRounded";
                                var filterHasil = NumberFormat.currency(
                                        locale: 'ID', decimalDigits: 0)
                                    .format(validasiDiskonRounded);
                                dialogValidasiTambah(filterHasil);
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
                                child: statusButton == false
                                    ? Text(
                                        "Tambah Data",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "Update Data",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
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
      idInvoice.text = widget.value1['id_invoice'];
      nomorInvoice.text = widget.value1['nomor_invoice'];
      kepadaPT.text = widget.value1['kepada_pt'];
      proyek.text = widget.value1['proyek'];
      alamatProyek.text = widget.value1['alamat_proyek'];
      nomorSJ.text = widget.value1['nomor_surat_jalan'];
      persenDiskon.text = widget.value1['persen_diskon'];
      totalDiskon.text = widget.value1['total_diskon'];
      totalRounded.text = widget.value1['total_rounded'];
      tanggalInvoice.text = widget.value1['tanggal_invoice'];
      isiInvoice = widget.value2;
    } else {
      statusButton = false;
    }
  }

  kirimTambahDataPenawaran() async {
    var arrayisi = '';
    // ignore: prefer_is_empty
    if (isiInvoice.length != 0) {
      for (var i = 0; i < isiInvoice.length; i++) {
        if (arrayisi == '') {
          arrayisi =
              '${isiInvoice[i]['qty']},${isiInvoice[i]['satuan']},${isiInvoice[i]['nama_barang']},${isiInvoice[i]['harga_satuan']},${isiInvoice[i]['harga_total'].replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll('IDR', '')}';
        } else {
          arrayisi =
              '$arrayisi|${isiInvoice[i]['qty']},${isiInvoice[i]['satuan']},${isiInvoice[i]['nama_barang']},${isiInvoice[i]['harga_satuan']},${isiInvoice[i]['harga_total'].replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll('IDR', '')}';
        }
      }
    }
    try {
      var formData = dio.FormData.fromMap({
        "nomor_invoice": nomorInvoice.text,
        "kepada_pt": kepadaPT.text,
        "nama_proyek": proyek.text,
        "alamat_proyek": alamatProyek.text,
        "nomor_surat_jalan": nomorSJ.text,
        "persen_diskon": persenDiskon.text,
        "total_diskon": totalDiskon.text,
        "total_rounded": totalRounded.text,
        "terbilang": terbilang.text,
        "total_invoice": totalInvoice.text,
        "tanggal_invoice": tanggalInvoice.text,
        "isi_invoice": arrayisi,
      });
      var response = await dio.Dio().post(Api.tambahDatanvoice,
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

  updateInvoice() async {
    try {
      var formData = dio.FormData.fromMap({
        "id_invoice": idInvoice.text,
        "nomor_invoice": nomorInvoice.text,
        "kepada_pt": kepadaPT.text,
        "nama_proyek": proyek.text,
        "alamat_proyek": alamatProyek.text,
        "nomor_surat_jalan": nomorSJ.text,
        "persen_diskon": persenDiskon.text == 'kosong' ? '' : persenDiskon.text,
        "total_diskon": totalDiskon.text == 'kosong' ? '' : totalDiskon.text,
        "total_rounded": totalRounded.text == 'kosong' ? '' : totalRounded.text,
        "terbilang": terbilang.text,
        "total_invoice": totalInvoice.text,
        "tanggal_invoice": tanggalInvoice.text,
      });
      var response = await dio.Dio().post(Api.updateDataInvoice,
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

  updateIsiInvoiceServer() async {
    try {
      var formData = dio.FormData.fromMap({
        "id_isi_invoice": idIsiInvoice.text,
        "qty": qty.text,
        "satuan": satuan.text,
        "nama_barang": namaBarang.text,
        "harga_satuan": hargaSatuan.text,
        "harga_total": hargaTotal.text
            .replaceAll(RegExp('[^A-Za-z0-9]'), '')
            .replaceAll('IDR', '')
      });
      var response = await dio.Dio().post(Api.updateDataIsiInvoice,
          data: formData, options: Options(headers: Api.headers));
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          Navigator.pop(context, true);
          Fluttertoast.showToast(
              msg: "Isi invoice berhasil di update",
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

  Widget formInvoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NO.INV",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: nomorInvoice,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
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
                    kepadaPT.text = value['nama_pt'];
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
                  child: Text(kepadaPT.text))),
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
                    alamatProyek.text = value['alamat_proyek'];
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
          "Alamat",
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
                child: Text(alamatProyek.text))),
        SizedBox(
          height: 10,
        ),
        Text(
          "NO.SJ",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: nomorSJ,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Diskon %",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: persenDiskon,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Total Diskon",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: totalDiskon,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Total Rounded",
          style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: totalRounded,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style:
                    TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
              ),
            ),
          ),
        ),
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
                      tanggalInvoice, //editing controller of this TextField
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
                        tanggalInvoice.text =
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
                    formIsiInvoice('');
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
                      "Isi Invoice",
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

  Widget listIsiInvoice() {
    return Container(
      margin: EdgeInsets.zero,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: isiInvoice.length,
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
                        hapusDataPenawaran(isiInvoice[index]);
                      } else {
                        idIsiInvoice.text = isiInvoice[index]['id_isi_invoice'];
                        namaBarang.text = isiInvoice[index]['nama_barang'];
                        qty.text = isiInvoice[index]['qty'];
                        satuan.text = isiInvoice[index]['satuan'];
                        hargaSatuan.text = isiInvoice[index]['harga_satuan']
                            .replaceAll(RegExp('[^A-Za-z0-9]'), '')
                            .replaceAll('IDR', '');
                        hargaTotal.text = isiInvoice[index]['harga_total'];
                        formIsiInvoice(index);
                      }
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 30,
                          child: Text(
                            isiInvoice[index]['nama_barang'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 8,
                          child: Text(
                            isiInvoice[index]['qty'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 12,
                          child: Text(
                            isiInvoice[index]['satuan'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 25,
                          child: Text(
                            isiInvoice[index]['harga_satuan'],
                            style: TextStyle(color: colorText),
                          )),
                      Expanded(
                          flex: 25,
                          child: Text(
                            isiInvoice[index]['harga_total'],
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

  formIsiInvoice(index) {
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
                        "ISI INVOICE",
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
                        isiInvoice.add(data);
                        namaBarang.text = '';
                        qty.text = '';
                        satuan.text = '';
                        hargaSatuan.text = '';
                        hargaTotal.text = '';
                        Navigator.of(context).pop(true);
                      }
                    } else {
                      var update = {
                        'id_isi_invoice': idIsiInvoice.text,
                        'qty': qty.text,
                        'satuan': satuan.text,
                        'nama_barang': namaBarang.text,
                        'harga_satuan': hargaSatuan.text,
                        'harga_total': hargaTotal.text,
                      };
                      isiInvoice[index] = update;
                      print("id isi invoice ${idIsiInvoice.text}");
                      updateIsiInvoiceServer();
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
                            isiInvoice.remove(value);
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

  dialogValidasiTambah(filterHasil) {
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
                Center(
                  child: Text(
                    "Total Invoice $filterHasil",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Terbilang",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    border: Border.all(width: 2.0, color: Colors.black),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: TextField(
                        controller: terbilang,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 12.0, height: 2.0, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                            if (isiInvoice.isEmpty) {
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
                                  : updateInvoice();
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
                                      "Tambah Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorText),
                                    )
                                  : Text(
                                      "Update Data",
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
