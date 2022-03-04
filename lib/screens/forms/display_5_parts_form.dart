import 'dart:convert';
import 'package:hijjawi_front_end/classes/forms/back_bag_form.dart';
import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../constants.dart';
import '../../responsive.dart';
import 'back_bag_form_display.dart';
import 'body_number_form_display.dart';
import 'car_audit_form_display.dart';
import 'car_front_form_display.dart';
import 'car_ground_form_display.dart';
import 'car_painting_form_display.dart';
import '../PDF_docs/create_and_update_pdf.dart';


class Display5PartsForm extends StatefulWidget {

  Customer customer = Customer();
  CarFrontForm carFrontForm;
  BodyNumberForm bodyNumberForm;
  BackBagForm backBagForm;
  CarGroundForm carGroundForm;
  CarPaintingForm carPaintingForm;
  CarAuditForm carAuditForm;

  Display5PartsForm({Key? key,
    required this.customer,
    required this.carFrontForm,
    required this.bodyNumberForm,
    required this.backBagForm,
    required this.carGroundForm,
    required this.carPaintingForm,
    required this.carAuditForm,
  }) : super(key: key);

  @override
  Display5PartsFormState createState() => Display5PartsFormState();
}

class Display5PartsFormState extends State<Display5PartsForm> with TickerProviderStateMixin {

  Future<bool> updateListView =Future.value(false);
  late bool showPart1, showPart2, showPart3, showPart4, showPart5, showPart6;

  @override
  void initState() {
    super.initState();
    showPart1 = showPart2 = showPart3 = showPart4 = showPart5 = showPart6= false;
    updateListView = getFormParts();
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon( Icons.arrow_back, color: iconColor),
          onTap: (){Navigator.of(context).pop();},
        ),
        centerTitle: true,
        title: SelectableText('نموذج رقم: ${widget.carFrontForm.formNumber.text}', style: TextStyle(color: txtColor),),
        backgroundColor: bgColor,
      ),
      body: FutureBuilder<bool>(
        future: updateListView,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Padding(
                padding: EdgeInsets.only(right: defaultPadding, left: defaultPadding),
                child: ListView(
                  children: [
                    // SizedBox(height: defaultPadding),
                    if (showPart1) CarFrontFormDisplay(customer: widget.customer, form: widget.carFrontForm),
                    if (showPart1) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                    if (showPart2) BodyNumberFormDisplay(customer: widget.customer, form: widget.bodyNumberForm),
                    if (showPart2) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                    if (showPart3) BackBagFormDisplay(customer: widget.customer, form: widget.backBagForm),
                    if (showPart3) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                    if (showPart4) CarGroundFormDisplay(customer: widget.customer, form: widget.carGroundForm),
                    if (showPart4) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                    if (showPart5) CarPaintingFormDisplay(customer: widget.customer, form: widget.carPaintingForm),
                    if (showPart5) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                    if (showPart6) CarAuditFormDisplay(customer: widget.customer, form: widget.carAuditForm),

                    Responsive.isDesktop(context) ?
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async{
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>
                            CreateAndUpdatePDF(
                              showPart1: showPart1,
                              showPart2: showPart2,
                              showPart3: showPart3,
                              showPart4: showPart4,
                              showPart5: showPart5,
                              showPart6: showPart6,
                              customer: widget.customer,
                              carPaintingForm: widget.carPaintingForm,
                              carAuditForm: widget.carAuditForm,
                              carGroundForm: widget.carGroundForm,
                              backBagForm: widget.backBagForm,
                              bodyNumberForm: widget.bodyNumberForm,
                              carFrontForm: widget.carFrontForm,
                            )));
                      },
                      child: Text('تحرير وطباعة تقرير'),
                    ) :
                    SizedBox(height: defaultPadding),
                    SizedBox(height: defaultPadding),
                  ],
                )
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future <bool> getFormParts() async {
    Response response = await post( Uri.parse("https://alhejawee-cars-checkup-backend.herokuapp.com/getFormParts"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({'user_id': widget.customer.id, 'form_id': widget.carFrontForm.formNumber.text, 'user_type' : widget.customer.type}));
    var jsonResponse = await jsonDecode(response.body);
    print(jsonResponse);
    if(jsonResponse['error'] != null) return false;
    else if (jsonResponse['message'] != null){
      var length = jsonResponse['length'];
      var parts = jsonResponse['message'];

      for (int i=0 ; i< length ; i++){
        if(parts[i]['form_part'] == '1' ) {
          showPart1 = true;
          widget.carFrontForm.formCreatorName = parts[i]['name'];
        }
        else if (parts[i]['form_part'] == '2') {
          showPart2 = true;
          widget.bodyNumberForm.formCreatorName = parts[i]['name'];
        }
        else if (parts[i]['form_part'] == '3') {
          showPart3 = true;
          widget.backBagForm.formCreatorName = parts[i]['name'];
        }
        else if (parts[i]['form_part'] == '4') {
          showPart4 = true;
          widget.carGroundForm.formCreatorName = parts[i]['name'];
        }
        else if (parts[i]['form_part'] == '5') {
          showPart5 = true;
          widget.carPaintingForm.formCreatorName = parts[i]['name'];
        }
        else if (parts[i]['form_part'] == '6') {
          showPart6 = true;
          widget.carAuditForm.formCreatorName = parts[i]['name'];
        }
      }
      return true;
    }
    return false;
  }

}
