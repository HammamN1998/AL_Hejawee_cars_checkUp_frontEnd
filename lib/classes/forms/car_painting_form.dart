import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CarPaintingForm  {

  CarPaintingForm();
  CarPaintingForm.display(String formNumber, c1_1, c1_2, c2_1, c2_2, c2_n, c3_1, c3_2, c3_n, c4_1, c4_2, c4_n,
                          c5_1, c5_2, c5_n, c6_1, c6_2, c6_n, c7_1, c7_2, c7_n, c8_1, c8_2, c8_n, c9_1, c9_2, c9_n,
                          c10_1, c10_2, c10_n, c11_1, c11_n, c12_1, c12_n,)
  {
    this.formNumber.text = formNumber;
    this.c1_1.text = c1_1;    this.c1_n.text = c1_2;
    this.c2_1.text = c2_1;    this.c2_2.text = c2_2;    this.c2_n.text = c2_n;
    this.c3_1.text = c3_1;    this.c3_2.text = c3_2;    this.c3_n.text = c3_n;
    this.c4_1.text = c4_1;    this.c4_2.text = c4_2;    this.c4_n.text = c4_n;
    this.c5_1.text = c5_1;    this.c5_2.text = c5_2;    this.c5_n.text = c5_n;
    this.c6_1.text = c6_1;    this.c6_2.text = c6_2;    this.c6_n.text = c6_n;
    this.c7_1.text = c7_1;    this.c7_2.text = c7_2;    this.c7_n.text = c7_n;
    this.c8_1.text = c8_1;    this.c8_2.text = c8_2;    this.c8_n.text = c8_n;
    this.c9_1.text = c9_1;    this.c9_2.text = c9_2;    this.c9_n.text = c9_n;
    this.c10_1.text = c10_1;  this.c10_2.text = c10_2;  this.c10_n.text = c10_n;
    this.c11_1.text = c11_1;  this.c11_n.text = c11_n;
    this.c12_1.text = c12_1;  this.c12_n.text = c12_n;
  }

  String formCreatorName = '';
  TextEditingController formNumber = TextEditingController();

  // طلاء المركبة
  // غطاء محرك
  TextEditingController c1_1 = TextEditingController(); // يمين
  TextEditingController c1_n = TextEditingController(); // ملاحظات
  // جناح امامي
  TextEditingController c2_1 = TextEditingController(); // يمين
  TextEditingController c2_2 = TextEditingController(); // يسار
  TextEditingController c2_n = TextEditingController(); // ملاحظات

  // باب امامي
  TextEditingController c3_1 = TextEditingController(); // يمين
  TextEditingController c3_2 = TextEditingController(); // يسار
  TextEditingController c3_n = TextEditingController(); // ملاحظات

  // باب خلفي
  TextEditingController c4_1 = TextEditingController(); // يمين
  TextEditingController c4_2 = TextEditingController(); // يسار
  TextEditingController c4_n = TextEditingController(); // ملاحظات

  // عمود امامي
  TextEditingController c5_1 = TextEditingController(); // يمين
  TextEditingController c5_2 = TextEditingController(); // يسار
  TextEditingController c5_n = TextEditingController(); // ملاحظات

  // عمود وسط
  TextEditingController c6_1 = TextEditingController(); // يمين
  TextEditingController c6_2 = TextEditingController(); // يسار
  TextEditingController c6_n = TextEditingController(); // ملاحظات

  // عمود خلفي
  TextEditingController c7_1 = TextEditingController(); // يمين
  TextEditingController c7_2 = TextEditingController(); // يسار
  TextEditingController c7_n = TextEditingController(); // ملاحظات

  // جناح خلفي
  TextEditingController c8_1 = TextEditingController(); // يمين
  TextEditingController c8_2 = TextEditingController(); // يسار
  TextEditingController c8_n = TextEditingController(); // ملاحظات

  // مرش علوي
  TextEditingController c9_1 = TextEditingController(); // يمين
  TextEditingController c9_2 = TextEditingController(); // يسار
  TextEditingController c9_n = TextEditingController(); // ملاحظات

  // مرش سفلي
  TextEditingController c10_1 = TextEditingController(); // يمين
  TextEditingController c10_2 = TextEditingController(); // يسار
  TextEditingController c10_n = TextEditingController(); // ملاحظات

  // سقف المركبة
  TextEditingController c11_1 = TextEditingController(); // يمين
  TextEditingController c11_n = TextEditingController(); // ملاحظات
  // غطاء الحقيبة
  TextEditingController c12_1 = TextEditingController(); // يمين
  TextEditingController c12_n = TextEditingController(); // ملاحظات



  Future <bool> saveDataToBackend(String userID, [String operation= 'add']) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/saveForm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'user_id' : userID,
          'form_number':  formNumber.text,
          "form_part" : "5",
          "operation" : operation,
          'c1_1': c1_1.text, 'c1_n': c1_n.text,
          'c2_1': c2_1.text, 'c2_2': c2_2.text, 'c2_n': c2_n.text,
          'c3_1': c3_1.text, 'c3_2': c3_2.text, 'c3_n': c3_n.text,
          'c4_1': c4_1.text, 'c4_2': c4_2.text, 'c4_n': c4_n.text,
          'c5_1': c5_1.text, 'c5_2': c5_2.text, 'c5_n': c5_n.text,
          'c6_1': c6_1.text, 'c6_2': c6_2.text, 'c6_n': c6_n.text,
          'c7_1': c7_1.text, 'c7_2': c7_2.text, 'c7_n': c7_n.text,
          'c8_1': c8_1.text, 'c8_2': c8_2.text, 'c8_n': c8_n.text,
          'c9_1': c9_1.text, 'c9_2': c9_2.text, 'c9_n': c9_n.text,
          'c10_1': c10_1.text, 'c10_2': c10_2.text, 'c10_n': c10_n.text,
          'c11_1': c11_1.text, 'c11_n': c11_n.text,
          'c12_1': c12_1.text, 'c12_n': c12_n.text,
        }));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if(jsonResponse['error'] != null){
      // print(jsonResponse['error']);
      return false;
    }
    else if (jsonResponse['message'] != null){
      return true;
    }
    return false;
  }
}
