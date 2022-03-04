import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CustmizedComboBox extends StatefulWidget {
  String label = "";
  String dropdownValue = "";
  List<String> items;

  CustmizedComboBox({Key? key, required this.label, required this.items, required this.dropdownValue }) : super(key: key);

  @override
  _CustmizedComboBoxState createState() => _CustmizedComboBoxState();
}

class _CustmizedComboBoxState extends State<CustmizedComboBox> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
      child: Row(
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
            child: DropdownButton<String>(
              value: widget.dropdownValue,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              icon: const Icon(Icons.arrow_downward, color: iconColor),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: txtColor),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.dropdownValue = newValue!;
                });
              },
              items: widget.items
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }


}
