import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'car_audit_form_insert.dart';

class CarAuditFormDisplay extends StatefulWidget {

  CarAuditFormDisplay({Key? key, required this.customer, required this.form}) : super(key: key);
  CarAuditForm form;
  Customer customer ;
  @override
  CarAuditFormDisplayState createState() => CarAuditFormDisplayState();
}

class CarAuditFormDisplayState extends State<CarAuditFormDisplay> with TickerProviderStateMixin {



  @override
  void initState() {
    super.initState();
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
                'التدقيق',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            widget.customer.type == 'admin' ?
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => CarAuditFormScreen(customer: widget.customer, form: widget.form, operation: 'update',)),);
              },
              child: Icon(Icons.edit, size: 40, color: iconColor),
            ) :
            SizedBox(),
          ],
        ),
        getTwoLabelsUI(context, "رقم الهيكل الأساسي", widget.form.c1.text == 'true' ? 'صحيح' : 'غير صحيح'),
        getTwoLabelsUI(context, "إسم طالب الفحص", widget.form.c15.text),
        getTwoLabelsUI(context, "رقم اللوحة", widget.form.c13.text),
        getTwoLabelsUI(context, "رقم الهيكل", widget.form.c12.text),
        getTwoLabelsUI(context, "رقم الهيكل أسفل الزجاج", widget.form.c2.text),
        getTwoLabelsUI(context, "رقم الهيكل على لوحة التعريف", widget.form.c3.text),
        getTwoLabelsUI(context, "نوع المركبة", widget.form.c14.text),
        getTwoLabelsUI(context, "لون المركبة", widget.form.c7.text),
        getTwoLabelsUI(context, "عداد المركبة", widget.form.c8.text),
        getTwoLabelsUI(context, "عدد المقاعد", widget.form.c5.text),
        getTwoLabelsUI(context, "فتحة سقف", widget.form.c4.text),
        getTwoLabelsUI(context, "وصلة جر", widget.form.c6.text == 'true' ? 'موجود' : 'غير موجود'),
        getTwoLabelsUI(context, "نظام التزحلق ESP", widget.form.c9.text == 'true' ? 'موجود' : 'غير موجود'),
        getTwoLabelsUI(context, "قوة التسيير في المركبة", widget.form.c10.text == 'true' ? '4/4' : '2/4'),
        getTwoLabelsUI(context, "وجود زفتة في أرضية المركبة", widget.form.c11.text == 'true' ? 'موجود' : 'غير موجود'),
        getTwoLabelsUI(context, "اسم المستورد", widget.form.c16.text),
        getTwoLabelsUI(context, "رقم معاملة الاستيراد", widget.form.c17.text),
        getTwoLabelsUI(context, "الطراز", widget.form.c18.text),
        getTwoLabelsUI(context, "الانتاج", widget.form.c19.text),
        getTwoLabelsUI(context, "سنة الانتاج", widget.form.c20.text),
        getTwoLabelsUI(context, "مكان الترخيص", widget.form.c21.text),
        getTwoLabelsUI(context, "المسافة المقطوعة", widget.form.c22.text),
        getTwoLabelsUI(context, "حجم المحرك", widget.form.c23.text),
        getTwoLabelsUI(context, "نوع الوقود", widget.form.c24.text),
        getTwoLabelsUI(context, "نوع الغيار", widget.form.c25.text),
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
