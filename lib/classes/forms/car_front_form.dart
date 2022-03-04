import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CarFrontForm  {

  CarFrontForm();
  CarFrontForm.display(String formNumber, c1, c2, c3, c4, c5, c6, c7){
    this.formNumber.text = formNumber;
    this.c1.text = c1;
    this.c2.text = c2;
    this.c3.text = c3;
    this.c4.text = c4;
    this.c5.text = c5;
    this.c6.text = c6;
    this.c7.text = c7;
  }

  String formCreatorName = '';
  TextEditingController formNumber = TextEditingController();
  // مقدمة المركبة
  // هيكل امامي ايمن
  TextEditingController c1 = TextEditingController();
  // هيكل امامي ايسر
  TextEditingController c2 = TextEditingController();
  // واجهة امامية
  TextEditingController c3 = TextEditingController();
  // جناح امامي ايمن
  TextEditingController c4 = TextEditingController();
  // جناح امامي ايسر
  TextEditingController c5 = TextEditingController();
  // غطاء المحرك
  TextEditingController c6 = TextEditingController();
  // صدر المركبة
  TextEditingController c7 = TextEditingController();


  Future <bool> saveDataToBackend(String userID, [String operation= 'add']) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/saveForm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'user_id' : userID,
          'form_number':  formNumber.text,
          "form_part" : "1",
          "operation" : operation,
          'c1': c1.text,
          'c2': c2.text,
          'c3': c3.text,
          'c4': c4.text,
          'c5': c5.text,
          'c6': c6.text,
          'c7': c7.text,
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
