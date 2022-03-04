import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/screens/forms/car_ground_form_insert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CarGroundFormDisplay extends StatefulWidget {

  CarGroundFormDisplay({Key? key, required this.customer, required this.form}) : super(key: key);
  CarGroundForm form;
  Customer customer ;
  @override
  CarGroundFormDisplayState createState() => CarGroundFormDisplayState();
}

class CarGroundFormDisplayState extends State<CarGroundFormDisplay> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                'ارضية المركبة',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            widget.customer.type == 'admin' ?
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => CarGroundFormScreen(customer: widget.customer, form: widget.form, operation: 'update',)),);
              },
              child: Icon(Icons.edit, size: 40, color: iconColor),
            ) :
            SizedBox(),
          ],
        ),
        getTwoLabelsUI(context, "هيكل امامي ايمن", widget.form.c1.text),
        getTwoLabelsUI(context, "هيكل امامي ايسر", widget.form.c2.text),
        getTwoLabelsUI(context, "فخذ امامي ايمن", widget.form.c3.text),
        getTwoLabelsUI(context, "فخذ امامي ايسر", widget.form.c4.text),
        getTwoLabelsUI(context, "هيكل خلفي ايمن", widget.form.c5.text),
        getTwoLabelsUI(context, "هيكل خلفي ايسر", widget.form.c6.text),
        getTwoLabelsUI(context, "فخذ خلفي ايمن", widget.form.c7.text),
        getTwoLabelsUI(context, "فخذ خلفي ايسر", widget.form.c8.text),
        getTwoLabelsUI(context, "ارضية المركبة بشكل عام", widget.form.c9.text),
        getTwoLabelsUI(context, "المرشات السفلية", widget.form.c10.text),
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
