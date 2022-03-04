import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/forms/checkup_form1.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class OneCheckBox extends StatefulWidget {
  bool checked ;
  bool withNote;
  TextEditingController notesController;
  String label ;
  String checkedText ;
  String unCheckedText ;

  OneCheckBox({Key? key, required this.label, required this.checkedText,required this.unCheckedText, required this.withNote, required this.notesController, required this.checked}) : super(key: key);

  @override
  _OneCheckBoxState createState() => _OneCheckBoxState();
}

class _OneCheckBoxState extends State<OneCheckBox> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: txtColor
                ),
              ),
              SizedBox(width: defaultPadding*0.5),
              Expanded(
                child: Container(
                  decoration: new BoxDecoration (
                    color: widget.checked ? Colors.green : secondaryColor,
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onTap: (){
                      setState(() {
                        widget.checked = !widget.checked;
                      });
                    },
                    // leading: Icon(Icons.format_paint, color: iconColor),
                    title: Text(
                      widget.checked ? widget.checkedText : widget.unCheckedText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: txtColor
                      ),
                    ),
                    dense: true,
                  ),
                ),
              ),
              ((Responsive.isDesktop(context) || Responsive.isTablet(context))&& widget.withNote  ) ? SizedBox(width: defaultPadding) : SizedBox(),
              ((Responsive.isDesktop(context) || Responsive.isTablet(context))&& widget.withNote  )  ?
              Expanded(
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
                      child: TextField(
                        controller: widget.notesController,
                        style: TextStyle(color: txtColor),
                        decoration: InputDecoration(
                          hintText: '',
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                          fillColor: secondaryColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                      ,
                    )
                  ],
                ),
              ) : SizedBox(),
            ],
          ),
          (Responsive.isMobile(context) && widget.withNote)  ? Padding(
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
                      child: TextField(
                        controller: widget.notesController,
                        style: TextStyle(color: txtColor),
                        decoration: InputDecoration(
                          hintText: '',
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                          fillColor: secondaryColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )
                      ,
                    )
                  ],
                ),
                Divider(height: defaultPadding, thickness: 2, color: iconColor)
              ],
            ),
          ) :SizedBox(),
        ],
      ),
    );
  }

}
