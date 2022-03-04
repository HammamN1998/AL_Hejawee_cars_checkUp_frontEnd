import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class BodyNumberForm  {

  BodyNumberForm();
  BodyNumberForm.display(String formNumber, c1, c2){
    this.formNumber.text = formNumber;
    this.c1.text = c1;
    this.c2.text = c2;
  }

  String formCreatorName = '';
  TextEditingController formNumber = TextEditingController();

  // رقم الهيكل
  // طباعة رقم الهيكل
  TextEditingController c1 = TextEditingController();
  // اتصال رقم الهيكل مع جسم المركبة
  TextEditingController c2 = TextEditingController();



  Future <bool> saveDataToBackend(String userID, [String operation= 'add']) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/saveForm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'user_id' : userID,
          'form_number':  formNumber.text,
          "form_part" : "2",
          "operation" : operation,
          'c1': c1.text,
          'c2': c2.text,
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
