import 'dart:convert';

class Api {
  static var basicAuth = 'Basic ' +
      base64Encode(utf8.encode(
          'bayuhardiansyah:bayuhardiansyahlovetriyulianingpratiwi15052022'));
  static var headers = <String, String>{'authorization': Api.basicAuth};

  // url keiko serve https://aksaramerakinusantara.com/

  static var basicUrl =
      "https://aksaramerakinusantara.com/rest-api/services/surya_baru/";
  static var urlAssets =
      "https://aksaramerakinusantara.com/rest-api/assets/pt_sdp/";
  static var urlAssetsPenawaran =
      "https://aksaramerakinusantara.com/rest-api/assets/penawaran/";
  static var urlAssetsInvoice =
      "https://aksaramerakinusantara.com/rest-api/assets/invoice/";
  static var urlAssetsKwitansi =
      "https://aksaramerakinusantara.com/rest-api/assets/kwitansi/";

  static var loginUser = basicUrl + "Login";
  static var updateUser = basicUrl + "Login/update_user";
  static var penawaran = basicUrl + "Penawaran";
  static var detilIsiPenawaran = basicUrl + "Penawaran/isiPenawaran";
  static var pencarianDataPenawaran = basicUrl + "Penawaran/cari_isi_penawaran";
  static var tambahDataPenawaran = basicUrl + "Penawaran/tambah_penawaran";
  static var updateDataPenawaran = basicUrl + "Penawaran/update_penawaran";
  static var updateDataIsiPenawaran =
      basicUrl + "Penawaran/update_isi_penawaran";
  static var pdfPenawaran = basicUrl + "Penawaran/pdf_penawaran";
  static var hapusPenawaran = basicUrl + "Penawaran/hapus_penawaran";

  static var invoice = basicUrl + "Invoice";
  static var detilIsiInvoice = basicUrl + "Invoice/isiInvoice";
  static var detilKwitansi = basicUrl + "Invoice/kwitansi_invoice";
  static var tambahDatanvoice = basicUrl + "Invoice/tambah_invoice";
  static var updateDataInvoice = basicUrl + "Invoice/update_invoice";
  static var updateDataIsiInvoice = basicUrl + "Invoice/update_isi_invoice";
  static var pdfInvoice = basicUrl + "Invoice/pdf_invoice";
  static var pdfKwitansi = basicUrl + "Invoice/pdf_kwitansi";

  static var hapusDataBarang = basicUrl + "Umum/delete_barang";
  static var getListPT = basicUrl + "Umum/getPT";
  static var tambahDataPT = basicUrl + "Umum/tambah_data_pt";
  static var getListProyek = basicUrl + "Umum/getProyek";
  static var tambahDataProyek = basicUrl + "Umum/tambah_data_proyek";
}
