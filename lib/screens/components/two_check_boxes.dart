import 'package:hijjawi_front_end/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../../constants.dart';

class TwoCheckBoxes extends StatefulWidget {
  bool rightPainted;
  bool leftPainted;
  bool withNote;
  TextEditingController notesController;

  String label = "";
  String rightRadioText = "";
  String leftRadioText = "";

  TwoCheckBoxes({Key? key, required this.label, required this.rightRadioText, required this.leftRadioText, required this.withNote, required this.notesController, required this.rightPainted, required this.leftPainted}) : super(key: key);

  @override
  _TwoCheckBoxesState createState() => _TwoCheckBoxesState();
}

class _TwoCheckBoxesState extends State<TwoCheckBoxes> with TickerProviderStateMixin {

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
                    color: widget.rightPainted ? Colors.green : Colors.black45,
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onTap: (){
                      setState(() {
                        widget.rightPainted = !widget.rightPainted;
                      });
                    },
                    leading: Icon(Icons.format_paint, color: iconColor),
                    title: Text(widget.rightRadioText, style: TextStyle(color: txtColor),),
                    subtitle: Text(
                      widget.rightPainted ? "مدهون" : "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: txtColor
                      ),
                    ),
                    dense: true,
                  ),
                ),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: Container(
                  decoration: new BoxDecoration (
                    color: widget.leftPainted ? Colors.green : Colors.black45,
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                  child: ListTile(
                    onTap: (){
                      setState(() {
                        widget.leftPainted = !widget.leftPainted;
                      });
                    },
                    leading: Icon(Icons.format_paint, color: iconColor,),
                    title: Text(widget.leftRadioText, style: TextStyle(color: txtColor),),
                    subtitle: Text(
                      widget.leftPainted ? "مدهون" : "",
                      style: TextStyle(
                          color: txtColor
                      ),
                    ),
                    dense: true,
                  ),
                ),
              ),
              ((Responsive.isDesktop(context) || Responsive.isTablet(context))&&widget.withNote )  ? SizedBox(width: defaultPadding) : SizedBox(),
              ((Responsive.isDesktop(context) || Responsive.isTablet(context))&&widget.withNote )  ?
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
              ) :SizedBox(),
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
