import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'car_front_form_insert.dart';

class CarFrontFormDisplay extends StatefulWidget {

  CarFrontFormDisplay({Key? key, required this.customer, required this.form}) : super(key: key);
  CarFrontForm form;
  Customer customer ;
  @override
  CarFrontFormDisplayState createState() => CarFrontFormDisplayState();
}

class CarFrontFormDisplayState extends State<CarFrontFormDisplay> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                'مقدمة المركبة',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            widget.customer.type == 'admin' ?
              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => CarFrontFormScreen(customer: widget.customer, form: widget.form, operation: 'update',)),);
                },
                child: Icon(Icons.edit, size: 40, color: iconColor),
              ) :
              SizedBox(),
          ],
        ),
        getTwoLabelsUI(context, "هيكل امامي ايمن", widget.form.c1.text),
        getTwoLabelsUI(context, "هيكل امامي ايسر", widget.form.c2.text),
        getTwoLabelsUI(context, "واجهة امامية", widget.form.c3.text),
        getTwoLabelsUI(context, "جناح امامي ايمن", widget.form.c4.text),
        getTwoLabelsUI(context, "جناج امامي ايسر", widget.form.c5.text),
        getTwoLabelsUI(context, "غطاء المحرك", widget.form.c6.text),
        getTwoLabelsUI(context, "صدر المركبة", widget.form.c7.text),
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
