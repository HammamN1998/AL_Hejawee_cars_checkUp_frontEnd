import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CarAuditForm  {

  CarAuditForm();
  CarAuditForm.display(String formNumber, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25){
    this.formNumber.text = formNumber;
    this.c1.text = c1;
    this.c2.text = c2;
    this.c3.text = c3;
    this.c4.text = c4;
    this.c5.text = c5;
    this.c6.text = c6;
    this.c7.text = c7;
    this.c8.text = c8;
    this.c9.text = c9;
    this.c10.text = c10;
    this.c11.text = c11;
    this.c12.text = c12;
    this.c13.text = c13;
    this.c14.text = c14;
    this.c15.text = c15;
    this.c16.text = c16;
    this.c17.text = c17;
    this.c18.text = c18;
    this.c19.text = c19;
    this.c20.text = c20;
    this.c21.text = c21;
    this.c22.text = c22;
    this.c23.text = c23;
    this.c24.text = c24;
    this.c25.text = c25;
  }

  String formCreatorName = '';
  TextEditingController formNumber = TextEditingController();

  // التدقيق
  // رقم الهيكل الاساسي
  TextEditingController c1 = TextEditingController();
  // رقم الهيكل اسفل الزجاج
  TextEditingController c2 = TextEditingController();
  // رقم الهيكل على لوحة التعريف
  TextEditingController c3 = TextEditingController();
  // فتحة سقف
  TextEditingController c4 = TextEditingController();
  // عدد المقاعد
  TextEditingController c5 = TextEditingController();
  // وصلة جر
  TextEditingController c6 = TextEditingController();
  // لون المركبة
  TextEditingController c7 = TextEditingController();
  // عداد المركبة
  TextEditingController c8 = TextEditingController();
  // نظام التزحلق ESP
  TextEditingController c9 = TextEditingController();
  // قوة التسيير في المركبة
  TextEditingController c10 = TextEditingController();
  // وجود زفتة في ارضية المركبة
  TextEditingController c11 = TextEditingController();
  // رقم الهيكل
  TextEditingController c12 = TextEditingController();
  // رقم اللوحة
  TextEditingController c13 = TextEditingController();
  // نوع المركبة
  TextEditingController c14 = TextEditingController();
  // اسم طالب الفحص
  TextEditingController c15 = TextEditingController();
  // إسم المستورد
  TextEditingController c16 = TextEditingController();
  // رقم معاملة الإستيراد
  TextEditingController c17 = TextEditingController();
  // الطراز
  TextEditingController c18 = TextEditingController();
  // الإنتاج
  TextEditingController c19 = TextEditingController();
  // سنة الإنتاج
  TextEditingController c20 = TextEditingController();
  // مكان الترخيص
  TextEditingController c21 = TextEditingController();
  // المسافة المقطوعة
  TextEditingController c22 = TextEditingController();
  // حجم المحرك
  TextEditingController c23 = TextEditingController();
  // نوع الوقود
  TextEditingController c24 = TextEditingController();
  // نوع الغيار
  TextEditingController c25 = TextEditingController();

  Future <bool> saveDataToBackend(String userID, [String operation= 'add']) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/saveForm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'user_id' : userID,
          'form_number':  formNumber.text,
          "form_part" : "6",
          "operation" : operation,
          'c1': c1.text,
          'c2': c2.text,
          'c3': c3.text,
          'c4': c4.text,
          'c5': c5.text,
          'c6': c6.text,
          'c7': c7.text,
          'c8': c8.text,
          'c9': c9.text,
          'c10': c10.text,
          'c11': c11.text,
          'c12': c12.text,
          'c13': c13.text,
          'c14': c14.text,
          'c15': c15.text,
          'c16': c16.text,
          'c17': c17.text,
          'c18': c18.text,
          'c19': c19.text,
          'c20': c20.text,
          'c21': c21.text,
          'c22': c22.text,
          'c23': c23.text,
          'c24': c24.text,
          'c25': c25.text,
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
