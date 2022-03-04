import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'forms/show_all_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'forms/choose_form.dart';

class ChooseOperation extends StatelessWidget {

  Customer customer = Customer();

  ChooseOperation({
    Key? key, required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon( Icons.arrow_back, color: iconColor),
          onTap: (){ Navigator.of(context).pop(); },
        ),
        title: Text('إضافة أو عرض الفحوصات' , style: TextStyle(color: txtColor)),
        backgroundColor: bgColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: getAddNewFormUI(context)),
              ],
            ),
            SizedBox(height: defaultPadding,),
            Row(
              children: [
                Expanded(child: getShowExistedFormsUI(context),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddNewFormUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: ElevatedButton.icon(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 2.3,
              vertical:
              defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseForm(customer: this.customer,)),
            );
          },
          icon: Icon(Icons.add, color: iconColor),
          label: Text("إضافة فحص جديد", style: TextStyle(color: txtColor),),
        ),
    );
  }

  Widget getShowExistedFormsUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical:
            defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShowAllFormsScreen(customer: this.customer,)),
          );
        },
        icon: Icon(Icons.view_list_rounded, color: iconColor),
        label: Text("عرض الفحوصات القديمة", style: TextStyle(color: txtColor),),
      ),
    );
  }

}
