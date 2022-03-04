import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:hijjawi_front_end/screens/components/two_check_boxes.dart';
import 'package:hijjawi_front_end/screens/components/one_check_box.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CarPaintingFormScreen extends StatefulWidget {

  CarPaintingFormScreen({Key? key, required this.customer, required this.form, this.operation = 'add'}) : super(key: key);
  CarPaintingForm form;
  Customer customer ;
  String operation;
  @override
  _CarPaintingFormScreenState createState() => _CarPaintingFormScreenState();
}

class _CarPaintingFormScreenState extends State<CarPaintingFormScreen> with TickerProviderStateMixin {

  late OneCheckBox c1;
  late TwoCheckBoxes c2;
  late TwoCheckBoxes c3;
  late TwoCheckBoxes c4;
  late TwoCheckBoxes c5;
  late TwoCheckBoxes c6;
  late TwoCheckBoxes c7;
  late TwoCheckBoxes c8;
  late TwoCheckBoxes c9;
  late TwoCheckBoxes c10;
  late OneCheckBox c11;
  late OneCheckBox c12;

  String relatedBodyNumber = '';
  bool bodyNumberFound = false;
  bool visibleBodyNumber = false;

  @override
  void initState() {
    super.initState();
    c2 = TwoCheckBoxes(label: "جناح امامي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c2_n, rightPainted: widget.form.c2_1.text == 'true' ? true : false, leftPainted: widget.form.c2_2.text == 'true' ? true : false,);
    c3 = TwoCheckBoxes(label: "باب امامي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c3_n, rightPainted: widget.form.c3_1.text == 'true' ? true : false, leftPainted: widget.form.c3_2.text == 'true' ? true : false);
    c4 = TwoCheckBoxes(label: "باب خلفي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c4_n, rightPainted: widget.form.c4_1.text == 'true' ? true : false, leftPainted: widget.form.c4_2.text == 'true' ? true : false);
    c5 = TwoCheckBoxes(label: "عمود امامي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c5_n, rightPainted: widget.form.c5_1.text == 'true' ? true : false, leftPainted: widget.form.c5_2.text == 'true' ? true : false);
    c6 = TwoCheckBoxes(label: "عمود وسط", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c6_n, rightPainted: widget.form.c6_1.text == 'true' ? true : false, leftPainted: widget.form.c6_2.text == 'true' ? true : false);
    c7 = TwoCheckBoxes(label: "عمود خلفي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c7_n, rightPainted: widget.form.c7_1.text == 'true' ? true : false, leftPainted: widget.form.c7_2.text == 'true' ? true : false);
    c8 = TwoCheckBoxes(label: "جناح خلفي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c8_n, rightPainted: widget.form.c8_1.text == 'true' ? true : false, leftPainted: widget.form.c8_2.text == 'true' ? true : false);
    c9 = TwoCheckBoxes(label: "مرش علوي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c9_n, rightPainted: widget.form.c9_1.text == 'true' ? true : false, leftPainted: widget.form.c9_2.text == 'true' ? true : false);
    c10= TwoCheckBoxes(label: "مرش سفلي", rightRadioText: "يمين", leftRadioText: "يسار", withNote: true, notesController: widget.form.c10_n, rightPainted: widget.form.c10_1.text == 'true' ? true : false, leftPainted: widget.form.c10_2.text == 'true' ? true : false);
    c1 = OneCheckBox(label: "غطاء محرك", checkedText: "مدهون", unCheckedText: "غير مدهون", withNote: true, notesController: widget.form.c1_n, checked: widget.form.c1_1.text == 'true' ? true : false);
    c11 = OneCheckBox(label: "سقف المركبة", checkedText: "مدهون", unCheckedText: "غير مدهون", withNote: true, notesController: widget.form.c11_n, checked: widget.form.c11_1.text == 'true' ? true : false);
    c12 = OneCheckBox(label: "غطاء الحقيبة", checkedText: "مدهون", unCheckedText: "غير مدهون", withNote: true, notesController: widget.form.c12_n, checked: widget.form.c12_1.text == 'true' ? true : false);
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
        title: Text('فحص طلاء المركبة', style: TextStyle(color: txtColor)),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: Padding(
          padding: EdgeInsets.only(right: defaultPadding, left: defaultPadding),
          child: ListView(
            children: [
              Visibility(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Center(
                    child: Text(
                      relatedBodyNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bodyNumberFound ? txtColor : Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                visible: visibleBodyNumber,
              ),
              (widget.operation == 'add') ?
                Focus(
                child: getLabelAndTextUI(context, "رقم النموذج", "", widget.form.formNumber) ,
                onFocusChange: (focused) async {
                  if (!focused) {
                    var response =  await widget.customer.getBodyNumberByFormNumber(widget.form.formNumber.text.trim());
                    setState(() {
                      visibleBodyNumber = true;
                      if (response['error'] != null) {
                        this.relatedBodyNumber = response['error'];
                        this.bodyNumberFound = false;
                      } else if (response['message'] != null){
                        this.relatedBodyNumber = response['message'][0]['c50'];
                        this.bodyNumberFound = true;
                      }
                    });
                  }
                },
              ):
                getTwoLabelsUI(context, "رقم النموذج",  widget.form.formNumber),
              Divider(height: defaultPadding, thickness: 2, color: iconColor),
              c1,
              c2,
              c3,
              c4,
              c5,
              c6,
              c7,
              c8,
              c9,
              c10,
              c11,
              c12,
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
            style: TextStyle(color: txtColor),
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
            style: TextStyle(color: txtColor),
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
    widget.form.c1_1.text = this.c1.checked.toString(); widget.form.c1_n.text = this.c1.notesController.text;
    widget.form.c2_1.text = this.c2.rightPainted.toString(); widget.form.c2_2.text = this.c2.leftPainted.toString(); widget.form.c2_n.text = this.c2.notesController.text;
    widget.form.c3_1.text = this.c3.rightPainted.toString(); widget.form.c3_2.text = this.c3.leftPainted.toString(); widget.form.c3_n.text = this.c3.notesController.text;
    widget.form.c4_1.text = this.c4.rightPainted.toString(); widget.form.c4_2.text = this.c4.leftPainted.toString(); widget.form.c4_n.text = this.c4.notesController.text;
    widget.form.c5_1.text = this.c5.rightPainted.toString(); widget.form.c5_2.text = this.c5.leftPainted.toString(); widget.form.c5_n.text = this.c5.notesController.text;
    widget.form.c6_1.text = this.c6.rightPainted.toString(); widget.form.c6_2.text = this.c6.leftPainted.toString(); widget.form.c6_n.text = this.c6.notesController.text;
    widget.form.c7_1.text = this.c7.rightPainted.toString(); widget.form.c7_2.text = this.c7.leftPainted.toString(); widget.form.c7_n.text = this.c7.notesController.text;
    widget.form.c8_1.text = this.c8.rightPainted.toString(); widget.form.c8_2.text = this.c8.leftPainted.toString(); widget.form.c8_n.text = this.c8.notesController.text;
    widget.form.c9_1.text = this.c9.rightPainted.toString(); widget.form.c9_2.text = this.c9.leftPainted.toString(); widget.form.c9_n.text = this.c9.notesController.text;
    widget.form.c10_1.text = this.c10.rightPainted.toString(); widget.form.c10_2.text = this.c10.leftPainted.toString(); widget.form.c10_n.text = this.c10.notesController.text;
    widget.form.c11_1.text = this.c11.checked.toString(); widget.form.c11_n.text = this.c11.notesController.text;
    widget.form.c12_1.text = this.c12.checked.toString(); widget.form.c12_n.text = this.c12.notesController.text;

  }
}
