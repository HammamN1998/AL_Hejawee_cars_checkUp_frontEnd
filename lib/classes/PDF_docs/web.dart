import 'package:universal_html/html.dart';
import  'dart:convert';


class PdfApi {

  static Future<void> saveAndLunchFile( List<int> bytes, String fileName) async {

    AnchorElement(
        href: "data:application/octet-stream;charset=utf-161e;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
  }

}

