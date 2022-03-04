import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:hijjawi_front_end/screens/components/one_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class BodyNumberFormScreen extends StatefulWidget {

  BodyNumberFormScreen({Key? key, required this.customer, required this.form, this.operation = 'add'}) : super(key: key);
  BodyNumberForm form;
  Customer customer ;
  String operation ;
  @override
  _BodyNumberFormScreenState createState() => _BodyNumberFormScreenState();
}

class _BodyNumberFormScreenState extends State<BodyNumberFormScreen> with TickerProviderStateMixin {

  late OneCheckBox c1 ;
  late OneCheckBox c2;

  String relatedBodyNumber = '';
  bool bodyNumberFound = false;
  bool visibleBodyNumber = false;

  @override
  void initState() {
    super.initState();
    c1 = OneCheckBox(label: "طباعة رقم الهيكل", checkedText: "طباعة الشركة المنتجة", unCheckedText: "طباعة غير أصلية", withNote: false, notesController: TextEditingController(), checked: widget.form.c1.text == 'true' ? true : false,);
    c2 = OneCheckBox(label: "إتصال رقم الهيكل مع جسم المركبة", checkedText: "أصلي", unCheckedText: "غير أصلي", withNote: false, notesController: TextEditingController(), checked: widget.form.c2.text == 'true' ? true : false,);
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
        title: Text('رقم الهيكل', style: TextStyle(color: txtColor),),
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
            c1,
            c2,
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
    widget.form.c2.text = this.c2.checked.toString();

  }
}
