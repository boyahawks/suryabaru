// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suryabaru/screen/Penawaran_add.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:dio/dio.dart';
import 'package:suryabaru/utils/Api.dart';
import 'package:url_launcher/url_launcher.dart';

class Penawaran extends StatefulWidget {
  @override
  State<Penawaran> createState() => _PenawaraninState();
}

class _PenawaraninState extends State<Penawaran> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  _PenawaraninState createState() => _PenawaraninState();

  RefreshController _controller = RefreshController();

  TextEditingController deskripsi = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController tanggalTransaksi = TextEditingController();
  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalAkhir = TextEditingController();
  TextEditingController idPenawaran = TextEditingController();
  TextEditingController kepadaNama = TextEditingController();
  TextEditingController kepadaPT = TextEditingController();
  TextEditingController proyek = TextEditingController();
  TextEditingController tanggalPenawaran = TextEditingController();

  TextEditingController idUangHapus = TextEditingController();

  List<dynamic> penawaran = [];
  List<dynamic> listDetil = [];

  Color colorText = Colors.white;
  Color colorCard = Color.fromARGB(255, 194, 173, 240);

  int totalRow = 5;
  int offset = 0;
  String query = '';

  bool statusFilter = false;
  bool getData = false;

  @override
  void initState() {
    getDataPenawaran();
    totalRow = 5;
    offset = 0;
    query = '';
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
                    flex: 15,
                    child: Container(
                        margin: const EdgeInsets.only(top: 30), child: line1()),
                  ),
                  Expanded(
                    flex: 85,
                    child: line2(),
                  ),
                ],
              )),
        )
      ],
    ));
  }

  // FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI FUNGSI

  getDataPenawaran() async {
    try {
      setState(() {
        getData = false;
      });
      var formData = dio.FormData.fromMap({
        "total_row": totalRow,
        "offset": offset,
        "query": query,
        "tanggal_mulai": tanggalMulai.text,
        "tanggal_akhir": tanggalAkhir.text,
      });
      var response = await dio.Dio().post(Api.penawaran,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];

      print(data);

      setState(() {
        if (tanggalMulai.text != '') {
          statusFilter = true;
        } else {
          statusFilter = false;
        }
        if (status) {
          data.forEach((element) {
            var filter = {
              'id_penawaran': element['id_penawaran'],
              'kepada_nama': element['kepada_nama'],
              'kepada_pt': element['kepada_pt'],
              'proyek': element['proyek'],
              'tanggal_penawaran': element['tanggal_penawaran'],
            };
            penawaran.add(filter);
          });
        }
        getData = true;
      });
    } on DioError catch (e) {
      print(e.response);
      // ignore: unrelated_type_equality_checks
      Fluttertoast.showToast(
          msg: "Data selesai di tampilkan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getDataListDetil() async {
    try {
      var formData = dio.FormData.fromMap({
        "id": idPenawaran.text,
      });
      var response = await dio.Dio().post(Api.detilIsiPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];

      print(data);

      setState(() {
        if (status) {
          data.forEach((element) {
            var data = {
              'id_isi_penawaran': element['id_isi_penawaran'],
              'nama_barang': element['nama_barang'],
              'satuan': element['satuan'],
              'qty': element['qty'],
              'harga_satuan': element['harga_satuan'] == '0'
                  ? '0'
                  : NumberFormat.currency(locale: 'ID', decimalDigits: 0)
                      .format(int.parse(element['harga_satuan'])),
              'harga_total': element['harga_total'] == '0'
                  ? '0'
                  : NumberFormat.currency(locale: 'ID', decimalDigits: 0)
                      .format(int.parse(element['harga_total'])),
            };

            listDetil.add(data);
          });
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

  getLaporanPdf(getID) async {
    try {
      var formData = dio.FormData.fromMap({
        "id_penawaran": "$getID",
      });
      var response = await dio.Dio().post(Api.pdfPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];
      setState(() {
        if (status) {
          urlLauncher(data);
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

  hapusPenawaran(getID) async {
    try {
      var formData = dio.FormData.fromMap({
        "id_penawaran": "$getID",
      });
      var response = await dio.Dio().post(Api.hapusPenawaran,
          data: formData, options: Options(headers: Api.headers));
      var data = response.data['data'];
      var status = response.data['status'];
      var message = response.data['message'];

      setState(() {
        if (status) {
          penawaran.clear();
          getDataPenawaran();
          totalRow = 5;
          offset = 0;
          query = '';
          Fluttertoast.showToast(
              msg: "Data berhasil di hapus",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
      Navigator.pop(context);
      Navigator.pop(context);
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

  urlLauncher(data) async {
    _launchURL() async => await canLaunch("${Api.urlAssetsPenawaran}/$data")
        ? await launch("${Api.urlAssetsPenawaran}/$data")
        : throw 'Tidak dapat membuka';
    _launchURL();
  }

  // WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET WIDGET

  Widget line1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        print("tambah catatan");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PenawaranAdd('', '')));
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Tambah Data",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colorCard,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        print("filter Data");
                        dialogFilterData();
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Filter Data",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colorCard,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget line2() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 249, 249),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            flex: 10,
            child: search(),
          ),
          statusFilter
              ? Expanded(
                  flex: 5,
                  child: textFilter(),
                )
              : SizedBox(),
          Expanded(
            flex: 85,
            child: penawaran.isEmpty
                ? Center(
                    child: Text(
                    "Sedang memuat data...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))
                : sub1(),
          )
        ],
      ),
    );
  }

  Widget textFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 80,
            child: Container(
              margin: const EdgeInsets.only(left: 30, top: 10),
              child: Text(
                "Data tanggal ${tanggalMulai.text} sd tanggal ${tanggalAkhir.text}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorCard,
                    fontSize: 12),
              ),
            )),
        Expanded(
            flex: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          penawaran.clear();
                          totalRow = 5;
                          offset = 0;
                          tanggalMulai.text = '';
                          tanggalAkhir.text = '';
                          query = '';
                          statusFilter = false;
                          getDataPenawaran();
                        });
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          Expanded(
            flex: 90,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Cari Data...',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onSubmitted: (text) {
                  setState(() {
                    penawaran.clear();
                    query = text;
                    getDataPenawaran();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sub1() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: DraggableScrollableSheet(
                initialChildSize: 1.0,
                maxChildSize: 1.0,
                minChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: StatefulBuilder(
                          builder: (BuildContext context2, setter) {
                        return SmartRefresher(
                          controller: _controller,
                          onLoading: () async {
                            if (!statusFilter) {
                              await Future.delayed(
                                  Duration(milliseconds: 1000));
                              setState(() {
                                offset = offset + totalRow;
                                _controller.loadComplete();
                                getDataPenawaran();
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Data selesai di tampilkan",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          onRefresh: () async {
                            if (!statusFilter) {
                              await Future.delayed(
                                  Duration(milliseconds: 1000));
                              setState(() {
                                penawaran.clear();
                                totalRow = 5;
                                offset = 0;
                                tanggalMulai.text = '';
                                tanggalAkhir.text = '';
                                query = '';
                                statusFilter = false;
                                _controller.refreshCompleted();
                                getDataPenawaran();
                              });
                            } else {
                              await Future.delayed(
                                  Duration(milliseconds: 1000));
                              setState(() {
                                penawaran.clear();
                                _controller.refreshCompleted();
                                getDataPenawaran();
                              });
                            }
                          },
                          enablePullUp: true,
                          enablePullDown: true,
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              itemCount: penawaran.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            idPenawaran.text = penawaran[index]
                                                ['id_penawaran'];
                                            kepadaNama.text =
                                                penawaran[index]['kepada_nama'];
                                            kepadaPT.text =
                                                penawaran[index]['kepada_pt'];
                                            proyek.text =
                                                penawaran[index]['proyek'];
                                            tanggalPenawaran.text =
                                                penawaran[index]
                                                    ['tanggal_penawaran'];
                                            listDetil.clear();
                                            getDataListDetil();
                                            showAsBottomSheet();
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: ListTile(
                                            leading: Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              child: Icon(
                                                  Icons.attach_money_sharp,
                                                  size: 50.0),
                                            ),
                                            title: Text(penawaran[index]
                                                ['kepada_nama']),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 30,
                                                        child: Text("PT")),
                                                    Expanded(
                                                        flex: 70,
                                                        child: Text(
                                                            "= ${penawaran[index]['kepada_pt']}")),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 30,
                                                        child: Text("Proyek")),
                                                    Expanded(
                                                        flex: 70,
                                                        child: Text(
                                                            "= ${penawaran[index]['proyek']}")),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 30,
                                                        child: Text("Tanggal")),
                                                    Expanded(
                                                        flex: 70,
                                                        child: Text(
                                                            "= ${penawaran[index]['tanggal_penawaran']}")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            isThreeLine: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        );
                      }));
                }),
          ),
        ],
      ),
    );
  }

  dialogFilterData() {
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
                        "FILTER DATA PENAWARAN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: TextField(
                          controller:
                              tanggalMulai, //editing controller of this TextField
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Dari Tanggal" //label text of field
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
                                tanggalMulai.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: TextField(
                          controller:
                              tanggalAkhir, //editing controller of this TextField
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Sampai Tanggal" //label text of field
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
                                tanggalAkhir.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        )),
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
                    if (tanggalMulai.text == '' || tanggalAkhir.text == '') {
                      Fluttertoast.showToast(
                          msg: "Harap lengkapi form terlebih dahulu",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      penawaran.clear();
                      getDataPenawaran();
                      Navigator.of(context).pop(true);
                    }
                  });
                },
                child: Text("Filter")),
          ],
        );
      },
    );
  }

  void showAsBottomSheet() async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Material(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "DETAIL DATA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(width: 50, child: Text("Kepada")),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(": ${kepadaNama.text}"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(width: 50, child: Text("Proyek")),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(": ${kepadaPT.text}"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          SizedBox(width: 50, child: Text("Tanggal")),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(": ${tanggalPenawaran.text}"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child:
                      Text("Detil Penawaran", style: TextStyle(fontSize: 15)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 300,
                  margin: EdgeInsets.zero,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: listDetil.length,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 30),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 30,
                                    child:
                                        Text(listDetil[index]['nama_barang'])),
                                Expanded(
                                    flex: 8,
                                    child: Text(listDetil[index]['qty'])),
                                Expanded(
                                    flex: 12,
                                    child: Text(listDetil[index]['satuan'])),
                                Expanded(
                                    flex: 25,
                                    child:
                                        Text(listDetil[index]['harga_satuan'])),
                                Expanded(
                                    flex: 25,
                                    child:
                                        Text(listDetil[index]['harga_total'])),
                              ],
                            ),
                            Divider(
                              height: 5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        var data1 = {
                          'id_penawaran': idPenawaran.text,
                          'kepada_nama': kepadaNama.text,
                          'kepada_pt': kepadaPT.text,
                          'proyek': proyek.text,
                          'tanggal_penawaran': tanggalPenawaran.text,
                        };
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PenawaranAdd(data1, listDetil)));
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
                          "UPDATE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        var getID = idPenawaran.text;
                        getLaporanPdf(getID);
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 173, 6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "PDF",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                /* TextButton(
                    onPressed: () {
                      setState(() {
                        var getID = idPenawaran.text;
                        dialogValidasiHapus(getID);
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "DELETE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )), */
              ],
            )),
          );
        },
      );
    }); // This is the result.
  }

  dialogValidasiHapus(getID) {
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
                    "Hapus data ini ?",
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
                            hapusPenawaran(getID);
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
                                "Hapus",
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
