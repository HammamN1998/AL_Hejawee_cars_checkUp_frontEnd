import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CarGroundFormScreen extends StatefulWidget {

  CarGroundFormScreen({Key? key, required this.customer, required this.form, this.operation = 'add'}) : super(key: key);
  CarGroundForm form;
  Customer customer ;
  String operation;
  @override
  _CarGroundFormScreenState createState() => _CarGroundFormScreenState();
}

class _CarGroundFormScreenState extends State<CarGroundFormScreen> with TickerProviderStateMixin {

  String relatedBodyNumber = '';
  bool bodyNumberFound = false;
  bool visibleBodyNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon( Icons.arrow_back, color: iconColor),
          onTap: (){ Navigator.of(context).pop(); },
        ),
        title: Text('فحص ارضية المركبة', style: TextStyle(color: txtColor)),
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
            getLabelAndTextUI(context, "هيكل امامي ايمن", "", widget.form.c1),
            getLabelAndTextUI(context, "هيكل امامي ايسر", "", widget.form.c2),
            getLabelAndTextUI(context, "فخذ امامي ايمن", "", widget.form.c3),
            getLabelAndTextUI(context, "فخذ امامي ايسر", "", widget.form.c4),
            getLabelAndTextUI(context, "هيكل خلفي ايمن", "", widget.form.c5),
            getLabelAndTextUI(context, "هيكل خلفي ايسر", "", widget.form.c6),
            getLabelAndTextUI(context, "فخذ خلفي ايمن", "", widget.form.c7),
            getLabelAndTextUI(context, "فخذ خلفي ايسر", "", widget.form.c8),
            getLabelAndTextUI(context, "ارضية المركبة بشكل عام", "", widget.form.c9),
            getLabelAndTextUI(context, "المرشات السفلية", "", widget.form.c10),
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
            style: Theme.of(context).textTheme.bodyText1,
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

}
