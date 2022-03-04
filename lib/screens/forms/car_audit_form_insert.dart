import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:hijjawi_front_end/screens/components/customized_combo_box.dart';
import 'package:hijjawi_front_end/screens/components/one_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CarAuditFormScreen extends StatefulWidget {

  CarAuditFormScreen({Key? key, required this.customer, required this.form, this.operation = 'add'}) : super(key: key);
  CarAuditForm form;
  Customer customer ;
  String operation;
  @override
  _CarAuditFormScreenState createState() => _CarAuditFormScreenState();
}

class _CarAuditFormScreenState extends State<CarAuditFormScreen> with TickerProviderStateMixin {


  late OneCheckBox c1;
  late CustmizedComboBox c2 ;
  late CustmizedComboBox c3;
  late CustmizedComboBox c4;
  late OneCheckBox c6;
  late OneCheckBox c9;
  late OneCheckBox c10;
  late OneCheckBox c11;


  @override
  void initState() {
    super.initState();
    c1 = OneCheckBox(label: "رقم الهيكل الأساسي", checkedText: "صحيح", unCheckedText: "غير صحيح", withNote: false, notesController: TextEditingController(), checked: widget.form.c1.text == 'true' ? true : false,);
    // c2 = OneCheckBox(label: "رقم الهيكل اسفل الزجاج", checkedText: "موجود", unCheckedText: "غير موجود", withNote: false, notesController: TextEditingController(), checked: widget.form.c2.text == 'true' ? true : false);
    c6 = OneCheckBox(label: "وصلة جر", checkedText: "موجود", unCheckedText: "غير موجود", withNote: false, notesController: TextEditingController(), checked: widget.form.c6.text == 'true' ? true : false);
    c9 = OneCheckBox(label: "نظام التزحلق ESP", checkedText: "موجود", unCheckedText: "غير موجود", withNote: false, notesController: TextEditingController(), checked: widget.form.c9.text == 'true' ? true : false);
    c10= OneCheckBox(label: "قوة التسيير في المركبة", checkedText: "4/4", unCheckedText: "2/4", withNote: false, notesController: TextEditingController(), checked: widget.form.c10.text == 'true' ? true : false);
    c11= OneCheckBox(label: "وجود زفتة في ارضية المركبة", checkedText: "موجود", unCheckedText: "غير موجود", withNote: false, notesController: TextEditingController(), checked: widget.form.c11.text == 'true' ? true : false);

    c2 = CustmizedComboBox(label: 'رقم الهيكل اسفل الزجاج',dropdownValue: widget.form.c2.text == "" ? "صحيح" : widget.form.c2.text,
        items:<String>['صحيح', 'غير صحيح', 'غير موجود']);
    c3 = CustmizedComboBox(label: 'رقم الهيكل على لوحة التعريف',dropdownValue: widget.form.c3.text == "" ? "موجود, رقم شصي صحيح" : widget.form.c3.text,
        items:<String>['موجود, رقم شصي صحيح', 'موجود, رقم شصي غير صحيح', 'غير موجود', 'تالف']);
    c4 = CustmizedComboBox(label: 'فتحة سقف',dropdownValue: widget.form.c4.text == "" ? "عادي" : widget.form.c4.text,
        items:<String>['عادي', 'بانوراما', 'زجاج ثابت', 'قابل للإزالة', 'متحرك', 'جلد', 'غير موجود']);
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
        title: Text('التدقيق', style: TextStyle(color: txtColor),),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: defaultPadding, left: defaultPadding),
        child: ListView(
          children: [
            SizedBox(height: defaultPadding),
            (widget.operation == 'add') ?
              getLabelAndTextUI(context, "رقم النموذج", "", widget.form.formNumber) :
              getTwoLabelsUI(context, "رقم النموذج",  widget.form.formNumber),
            getLabelAndTextUI(context, "إسم طالب الفحص", "", widget.form.c15),
            getLabelAndTextUI(context, "رقم اللوحة", "", widget.form.c13),
            getLabelAndTextUI(context, "كتابة رقم الهيكل", "", widget.form.c12),
            c1,
            c2,
            c3,
            getLabelAndTextUI(context, "نوع المركبة", "", widget.form.c14),
            getLabelAndTextUI(context, "لون المركبة", "", widget.form.c7),
            getLabelAndTextUI(context, "عداد المركبة", "", widget.form.c8),
            getLabelAndTextUI(context, "عدد المقاعد", "", widget.form.c5),
            c4,
            c6,
            c9,
            c10,
            c11,
            getLabelAndTextUI(context, "إسم المستورد", "", widget.form.c16),
            getLabelAndTextUI(context, "رقم معاملة الإستيراد", "", widget.form.c17),
            getLabelAndTextUI(context, "الطراز", "", widget.form.c18),
            getLabelAndTextUI(context, "الإنتاج", "", widget.form.c19),
            getLabelAndTextUI(context, "سنة الإنتاج", "", widget.form.c20),
            getLabelAndTextUI(context, "مكان الترخيص", "", widget.form.c21),
            getLabelAndTextUI(context, "المسافة المقطوعة", "", widget.form.c22),
            getLabelAndTextUI(context, "حجم المحرك", "", widget.form.c23),
            getLabelAndTextUI(context, "نوع الوقود", "", widget.form.c24),
            getLabelAndTextUI(context, "نوع الغيار", "", widget.form.c25),

            getSubmitFormUI(context),
            SizedBox(height: defaultPadding),
          ],
        )
      ),
    );
  }

  Widget getLabelAndTextUI(BuildContext context, String label, String hintLabel, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: txtColor
              ),
            ),
            SizedBox(width: defaultPadding * 0.5),
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(color: txtColor),
                decoration: InputDecoration(
                  hintText: hintLabel,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  fillColor: secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
  Widget getTwoLabelsUI(BuildContext context, String label1, TextEditingController label2) {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: txtColor
            ),
          ),
          SizedBox(width: defaultPadding * 0.5),
          Expanded(
            child: TextField(
              controller: label2,
              enabled: false,
              style: TextStyle(color: txtColor),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                fillColor: secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getLabelWithTwoTextUI(BuildContext context, String label, String hintText1, String hintText2, TextEditingController controller1, TextEditingController controller2 ) {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: txtColor
            ),
          ),
          SizedBox(width: defaultPadding * 0.5),
          Expanded(
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                hintText: hintText1,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                fillColor: secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          SizedBox(width: defaultPadding * 0.5),
          Expanded(
            child: TextField(
              controller: controller2,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                hintText: hintText2,
                fillColor: secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLabelUI(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  Widget getSubmitFormUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: defaultPadding,right: defaultPadding, left: defaultPadding),
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding ,
            vertical:
            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          if (widget.form.formNumber.text.trim() == '' ) {
            showErrorDialog('الرجاء ادخال رقم النموذج');
            return;
          }
          showWaitDialog(context);

          assignUIToForm();
          widget.form.saveDataToBackend(widget.customer.id, widget.operation).then((saved) => {
            Navigator.pop(context),

            if (saved) {
              showSuccessDialog('تم حفظ النموذج بنجاح !!'),
            }
            else {
              showErrorDialog('خطأ, اعد المحاولة لاحقا !!'),
            }

          });
        },
        icon: Icon(Icons.save, color: iconColor),
        label: Text("حفظ النموذج", style: TextStyle(color: txtColor),),
      ),
    );
  }

  void showWaitDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return AbsorbPointer(
          absorbing: true,
          child: AlertDialog(
            actions: <Widget>[
              new Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void showSuccessDialog(String alert){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(alert),
          actions: <Widget>[
            new TextButton(
              child: new Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String alert){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(alert),
          actions: <Widget>[
            new TextButton(
              child: new Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void assignUIToForm()  {
    // assign user values that come from the GUI to the form class
    widget.form.c1.text = this.c1.checked.toString();
    widget.form.c2.text = this.c2.dropdownValue;
    widget.form.c3.text = this.c3.dropdownValue;
    widget.form.c4.text = this.c4.dropdownValue;
    widget.form.c6.text = this.c6.checked.toString();
    widget.form.c9.text = this.c9.checked.toString();
    widget.form.c10.text = this.c10.checked.toString();
    widget.form.c11.text = this.c11.checked.toString();

  }

}
