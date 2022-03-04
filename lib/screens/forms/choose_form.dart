import 'package:hijjawi_front_end/classes/forms/back_bag_form.dart';
import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:hijjawi_front_end/screens/forms/back_bag_form_insert.dart';
import 'package:hijjawi_front_end/screens/forms/body_number_form_insert.dart';
import 'package:hijjawi_front_end/screens/forms/car_audit_form_insert.dart';
import 'package:hijjawi_front_end/screens/forms/car_front_form_insert.dart';
import 'package:hijjawi_front_end/screens/forms/car_ground_form_insert.dart';
import 'package:hijjawi_front_end/screens/forms/car_painting_form_insert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ChooseForm extends StatefulWidget {

  ChooseForm({Key? key, required this.customer}) : super(key: key);
  Customer customer ;
  @override
  _ChooseFormState createState() => _ChooseFormState();
}

class _ChooseFormState extends State<ChooseForm> with TickerProviderStateMixin {

  late CarFrontForm carFrontForm ;
  late BodyNumberForm bodyNumberForm ;
  late BackBagForm backBagForm ;
  late CarGroundForm carGroundForm ;
  late CarPaintingForm carPaintingForm ;
  late CarAuditForm carAuditForm ;

  @override
  void initState() {
    super.initState();
    carFrontForm = CarFrontForm();
    bodyNumberForm = BodyNumberForm();
    backBagForm = BackBagForm();
    carGroundForm = CarGroundForm();
    carPaintingForm = CarPaintingForm();
    carAuditForm = CarAuditForm();

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
          onTap: (){ Navigator.of(context).pop(); },
        ),
        title: Text('إضافة فحص جديد', style: TextStyle(color: txtColor)),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: defaultPadding, left: defaultPadding),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'التدقيق', CarAuditFormScreen(customer: widget.customer, form: carAuditForm, operation: 'add',)),),
              ],
            ),
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'مقدمة المركبة', CarFrontFormScreen(customer: widget.customer, form: carFrontForm, operation: 'add',)),),
              ],
            ),
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'رقم الهيكل', BodyNumberFormScreen(customer: widget.customer, form: bodyNumberForm, operation: 'add',)),),
              ],
            ),
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'الحقيبة الخلفية', BackBagFormScreen(customer: widget.customer, form: backBagForm, operation: 'add', )),),
              ],
            ),
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'ارضية المركبة', CarGroundFormScreen(customer: widget.customer, form: carGroundForm, operation: 'add',)),),
              ],
            ),
            Row(
              children: [
                Expanded(child: getChooseFormUI(context, 'طلاء المركبة', CarPaintingFormScreen(customer: widget.customer, form: carPaintingForm, operation: 'add',)),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getChooseFormUI(BuildContext context, String formName ,form) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 2.3,
            vertical:
            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => form),
          );
        },
        icon: Icon(Icons.assignment, color: iconColor),
        label: Text(formName, style: TextStyle(color: txtColor),),
      ),
    );
  }

}
