import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'body_number_form_insert.dart';

class BodyNumberFormDisplay extends StatefulWidget {

  BodyNumberFormDisplay({Key? key, required this.customer, required this.form}) : super(key: key);
  BodyNumberForm form;
  Customer customer ;
  @override
  BodyNumberFormDisplayState createState() => BodyNumberFormDisplayState();
}

class BodyNumberFormDisplayState extends State<BodyNumberFormDisplay> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                'رقم الهيكل',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            widget.customer.type == 'admin' ?
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => BodyNumberFormScreen(customer: widget.customer, form: widget.form, operation: 'update',)),);
              },
              child: Icon(Icons.edit, size: 40, color: iconColor),
            ) :
            SizedBox(),
          ],
        ),
        getTwoLabelsUI(context, "طباعة رقم الهيكل", widget.form.c1.text == 'true' ? 'طباعة الشركة المنتجة' : 'طباعة غير أصلية'),
        getTwoLabelsUI(context, "إتصال رقم الهيكل مع جسم المركبة", widget.form.c2.text == 'true' ? 'أصلي' : 'غير أصلي'),
        getTwoLabelsUI(context, "صانع النموذج", widget.form.formCreatorName),
        SizedBox(height: defaultPadding),

      ],
    );
  }

  Widget getTwoLabelsUI(BuildContext context, String label1, String label2) {
    return Row(
      children: [
        Center(
          child: Text(
            label1,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: txtColor
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Center(
          child: SelectableText(
            label2,
            style: TextStyle(color: txtColor),
          ),
        ),
      ],
    );
  }

}
