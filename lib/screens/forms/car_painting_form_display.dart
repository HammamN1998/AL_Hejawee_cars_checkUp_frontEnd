import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'car_painting_form_insert.dart';

class CarPaintingFormDisplay extends StatefulWidget {

  CarPaintingFormDisplay({Key? key, required this.customer, required this.form}) : super(key: key);
  CarPaintingForm form = CarPaintingForm();
  Customer customer ;
  @override
  _CarPaintingFormDisplayState createState() => _CarPaintingFormDisplayState();
}

class _CarPaintingFormDisplayState extends State<CarPaintingFormDisplay> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                'طلاء المركبة',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            widget.customer.type == 'admin' ?
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => CarPaintingFormScreen(customer: widget.customer, form: widget.form, operation: 'update',)),);
              },
              child: Icon(Icons.edit, size: 40, color: iconColor),
            ) :
            SizedBox(),
          ],
        ),
        getThreeLabelsUI(context, 'غطاء محرك', widget.form.c1_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c1_n.text ),
        getFourLabelsUI(context, 'جناح امامي', widget.form.c2_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c2_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c2_n.text ),
        getFourLabelsUI(context, 'باب امامي', widget.form.c3_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c3_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c3_n.text ),
        getFourLabelsUI(context, 'باب خلفي', widget.form.c4_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c4_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c4_n.text ),
        getFourLabelsUI(context, 'عمود امامي', widget.form.c5_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c5_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c5_n.text ),
        getFourLabelsUI(context, 'عمود وسط', widget.form.c6_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c6_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c6_n.text ),
        getFourLabelsUI(context, 'عمود خلفي', widget.form.c7_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c7_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c7_n.text ),
        getFourLabelsUI(context, 'جناح خلفي', widget.form.c8_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c8_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c8_n.text ),
        getFourLabelsUI(context, 'مرش علوي', widget.form.c9_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c9_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c9_n.text ),
        getFourLabelsUI(context, 'مرش سفلي', widget.form.c10_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c10_2.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c10_n.text ),
        getThreeLabelsUI(context, 'سقف المركبة', widget.form.c11_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c11_n.text),
        getThreeLabelsUI(context, 'غطاء الحقيبة', widget.form.c12_1.text == 'true' ? 'مدهون' : 'غير مدهون', widget.form.c12_n.text),
        getTwoLabelsUI(context, "صانع النموذج", widget.form.formCreatorName),
        SizedBox(height: defaultPadding),

      ],
    );
  }


  Widget getFourLabelsUI(BuildContext context, String label1, String label2, String label3, String label4) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: txtColor
              ),
            ),
            SizedBox(width: defaultPadding*0.5),
            Expanded(
              child: Container(
                decoration: new BoxDecoration (
                  color: label2 == 'مدهون' ? Colors.green : secondaryColor,
                  borderRadius: BorderRadius.circular(defaultPadding),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  leading: Icon(Icons.format_paint, color: iconColor),
                  title: Text('يمين', style: TextStyle(color: txtColor),),
                  subtitle: SelectableText(
                    label2,
                    style: TextStyle(
                        color: txtColor
                    ),
                  ),
                  dense: true,
                  selected: true,
                  selectedTileColor: secondaryColor,
                ),
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Container(
                decoration: new BoxDecoration (
                  color: label3 == 'مدهون' ? Colors.green : secondaryColor,
                  borderRadius: BorderRadius.circular(defaultPadding),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  leading: Icon(Icons.format_paint, color: iconColor),
                  title: Text('يسار', style: TextStyle(color: txtColor),),
                  subtitle: SelectableText(
                    label3,
                    style: TextStyle(
                        color: txtColor
                    ),
                  ),
                  dense: true,
                  selected: true,
                  selectedTileColor: secondaryColor,
                ),
              ),
            ),
            SizedBox(width: defaultPadding),
            (Responsive.isDesktop(context) || Responsive.isTablet(context))  ? Expanded(
              child: Row(
                children: [
                  Text(
                    'ملاحظات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor
                    )

                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration (
                        color: bgColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: SelectableText(
                        label4,
                        style: TextStyle(
                            color: txtColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :SizedBox(),
          ],
        ),
        Responsive.isMobile(context)  ? Padding(
          padding: EdgeInsets.only(top:defaultPadding * 0.5),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'ملاحظات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration (
                        color: bgColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: SelectableText(
                        label4,
                        style: TextStyle(
                            color: txtColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: defaultPadding, thickness: 2, color: iconColor)
            ],
          ),
        ) :SizedBox(),
        SizedBox(height: defaultPadding),
      ],
    );
  }

  Widget getThreeLabelsUI(BuildContext context, String label1, String label2, String label3) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: txtColor
              ),
            ),
            SizedBox(width: defaultPadding*0.5),
            Expanded(
              child: Container(
                decoration: new BoxDecoration (
                  color: label2 == 'مدهون' ? Colors.green : secondaryColor,
                  borderRadius: BorderRadius.circular(defaultPadding),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  leading: Icon(Icons.format_paint, color: iconColor),
                  subtitle: SelectableText(
                    label2,
                    style: TextStyle(
                        color: txtColor
                    ),
                  ),
                  dense: true,
                  selected: true,
                  selectedTileColor: secondaryColor,
                ),
              )
            ),
            SizedBox(width: defaultPadding),
            (Responsive.isDesktop(context) || Responsive.isTablet(context))  ? Expanded(
              child: Row(
                children: [
                  Text(
                    'ملاحظات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration (
                        color: bgColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: SelectableText(
                        label3,
                        style: TextStyle(
                            color: txtColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :SizedBox(),
          ],
        ),
        Responsive.isMobile(context)  ? Padding(
          padding: EdgeInsets.only(top:defaultPadding * 0.5),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'ملاحظات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration (
                        color: bgColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: SelectableText(
                        label3,
                        style: TextStyle(
                            color: txtColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: defaultPadding, thickness: 2, color: iconColor)
            ],
          ),
        ) :SizedBox(),
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
