import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'choose_operation.dart';

class SignUpAndLogin extends StatefulWidget {

  SignUpAndLogin({Key? key}) : super(key: key);
  @override
  _SignUpAndLoginState createState() => _SignUpAndLoginState();
}

class _SignUpAndLoginState extends State<SignUpAndLogin> with TickerProviderStateMixin {

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final Customer signInCustomer = Customer();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center (child: Text('تسجيل الدخول', style: TextStyle(color: txtColor),),),
        backgroundColor: bgColor,
      ),
      body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  getUserNameBarUI(),
                  SizedBox( height: defaultPadding),
                  getUserPasswordBarUI(),
                  SizedBox( height: defaultPadding),
                  getLoginButtonBarUI(context),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
    );
  }

  Widget getUserNameBarUI() {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: TextField(
        controller: this.nameController,
        style: TextStyle(color: txtColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          hintText: "اسم المستخدم",
          hintStyle: TextStyle(color: txtColor),
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          icon:Icon(
            Icons.account_circle, color: iconColor
          ),
        ),
      ),
    );
  }

  Widget getUserPasswordBarUI() {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: TextField(
        controller: this.passwordController,
        style: TextStyle(color: txtColor),
        obscureText: !passwordVisible,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          hintText: "كلمة المرور",
          fillColor: secondaryColor,
          hintStyle: TextStyle(color: txtColor),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          icon:Icon(
            Icons.lock, color: iconColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                passwordVisible = ! passwordVisible;
              });
            },
            child: Icon(
              passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginButtonBarUI(BuildContext context) {
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
          if (nameController.text.trim() == '' ) {
            showErrorDialog(context, 'الرجاء ادخال إسم المستخدم');
            return;
          }
          if (passwordController.text.trim() == '' ) {
            showErrorDialog(context, 'الرجاء ادخال كلمة المرور');
            return;
          }
          showWaitDialog(context);

          this.signInCustomer.name = nameController.text;
          this.signInCustomer.password = passwordController.text;
          this.signInCustomer.loginToBackend().then((authorized) => {
            Navigator.pop(context),

            if (authorized) {
              Navigator.push(context,MaterialPageRoute(builder: (context) => ChooseOperation(customer: this.signInCustomer,)),)
            }
            else {
              showErrorDialog( context, "إسم المستخدم أول كلمة المررور غير صحيحين !!"),
            }
          });
        },
        icon: Icon(Icons.login, color: iconColor),
        label: Text("تسجيل الدخول", style: TextStyle(color: txtColor),),
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

  void showErrorDialog(BuildContext context, String alert){
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
