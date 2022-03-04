import 'dart:convert';
import 'package:http/http.dart';

class Customer  {
  String id;
  String name;
  String password;
  String type;

  List<dynamic> searchFormsList = <dynamic>[];

  Customer({
    this.id: "",
    this.name: "",
    this.password: "",
    this.type: "",
  });


  Future <bool> loginToBackend() async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'name': name, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if(jsonResponse['error'] != null){
      // print(jsonResponse['error']);
      return false;
    }
    else if (jsonResponse['message'] != null){
      this.id = jsonResponse['message']['id'].toString();
      this.name = jsonResponse['message']['name'];
      this.password = jsonResponse['message']['password'];
      this.type = jsonResponse['message']['user_type'];
      return true;
    }
    return false;
  }

  Future<bool> getAllForms(int pageCount) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getAllForms"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'page_number': pageCount.toString(), 'user_type': type, 'user_id': id}));

    var jsonResponse = await jsonDecode(response.body);

    if(jsonResponse['error'] != null){
      print(jsonResponse['error']);
      return Future.value(false);
    }
    else if (jsonResponse['message'] != null){
      var length = jsonResponse['length'];
      var list = jsonResponse['message'];
      for (int i=0 ; i< length ; i++){
        this.searchFormsList.add( list[i]);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> getAllFormsByName(int pageCount, String name) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getAllForms/name"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'page_number': pageCount.toString(), 'user_type': type, 'user_id': id, 'name': name}));

    var jsonResponse = await jsonDecode(response.body);

    if(jsonResponse['error'] != null){
      print(jsonResponse['error']);
      return Future.value(false);
    }
    else if (jsonResponse['message'] != null){
      var length = jsonResponse['length'];
      var list = jsonResponse['message'];
      for (int i=0 ; i< length ; i++){
        this.searchFormsList.add( list[i]);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> getAllFormsByCarSign(int pageCount, String carSign) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getAllForms/carSign"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'page_number': pageCount.toString(), 'user_type': type, 'user_id': id, 'car_sign': carSign}));

    var jsonResponse = await jsonDecode(response.body);

    if(jsonResponse['error'] != null){
      print(jsonResponse['error']);
      return Future.value(false);
    }
    else if (jsonResponse['message'] != null){
      var length = jsonResponse['length'];
      var list = jsonResponse['message'];
      for (int i=0 ; i< length ; i++){
        this.searchFormsList.add( list[i]);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> getAllFormsByBodyNumber(int pageCount, String bodyNumber) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getAllForms/bodyNumber"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'page_number': pageCount.toString(), 'user_type': type, 'user_id': id, 'body_number': bodyNumber}));

    var jsonResponse = await jsonDecode(response.body);

    if(jsonResponse['error'] != null){
      print(jsonResponse['error']);
      return Future.value(false);
    }
    else if (jsonResponse['message'] != null){
      var length = jsonResponse['length'];
      var list = jsonResponse['message'];
      for (int i=0 ; i< length ; i++){
        this.searchFormsList.add( list[i]);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }


  Future<bool> getOneForm(String formID) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getOneForm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'form_id': formID.toString(), 'user_type': this.type, 'user_id': this.id}));

    var jsonResponse = await jsonDecode(response.body);

    if(jsonResponse['error'] != null){
      print(jsonResponse['error']);
      return Future.value(false);
    }
    else if (jsonResponse['message'] != null){
      var form = jsonResponse['message'];
      this.searchFormsList.clear();
      this.searchFormsList.add( form[0]);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<dynamic> getBodyNumberByFormNumber(String formID) async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getBodyNumber"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'form_id': formID.toString()}));

    var jsonResponse = await jsonDecode(response.body);

    return jsonResponse;
  }

}
