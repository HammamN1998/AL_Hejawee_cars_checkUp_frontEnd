import 'dart:convert';
import 'dart:typed_data';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/classes/forms/back_bag_form.dart';
import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/screens/forms/back_bag_form_display.dart';
import 'package:hijjawi_front_end/screens/forms/body_number_form_display.dart';
import 'package:hijjawi_front_end/screens/forms/car_audit_form_display.dart';
import 'package:hijjawi_front_end/screens/forms/car_front_form_display.dart';
import 'package:hijjawi_front_end/screens/forms/car_ground_form_display.dart';
import 'package:hijjawi_front_end/screens/forms/car_painting_form_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../constants.dart';

import 'dart:ui';
import 'package:hijjawi_front_end/classes/PDF_docs/mobile.dart' if(dart.library.html) 'package:hijjawi_front_end/classes/PDF_docs/web.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';

import '../components/customized_combo_box.dart';


class CreateAndUpdatePDF extends StatefulWidget {
  Customer customer = Customer();
  CarFrontForm carFrontForm;
  BodyNumberForm bodyNumberForm;
  BackBagForm backBagForm;
  CarGroundForm carGroundForm;
  CarPaintingForm carPaintingForm;
  CarAuditForm carAuditForm;
  bool showPart1, showPart2, showPart3, showPart4, showPart5, showPart6;


  CreateAndUpdatePDF({Key? key,
    required this.customer,
    required this.carFrontForm,
    required this.bodyNumberForm,
    required this.backBagForm,
    required this.carGroundForm,
    required this.carPaintingForm,
    required this.carAuditForm,
    required this.showPart1,
    required this.showPart2,
    required this.showPart3,
    required this.showPart4,
    required this.showPart5,
    required this.showPart6
  }) : super(key: key);
  @override
  CreateAndUpdatePDFState createState() => CreateAndUpdatePDFState();
}

class CreateAndUpdatePDFState extends State<CreateAndUpdatePDF> {
  TextEditingController editPdfController = TextEditingController();
  List<int> pdfAsBytes = [];
  List<ParentAndChildrenAsStrings> parentsList = [];
  Future<bool> updatePdfFile =Future.value(false);
  bool downloadable = true;

  final String template1 = 'فحص تركيب دواسات تدريب إضافية ولوحة التحكم الكهربائية الإضافية';
  final String template2 = 'فحص مركبة مستوردة';
  final String template3 = 'فحص مركبة مرخصة';

  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    dropdownValue = template3;
    this.editPdfController.text = changePdfControllerText(template3);
    updatePdfFile = createPDF(template3);
  }

  @override
  void dispose() {
    super.dispose();
    editPdfController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon( Icons.arrow_back, color: iconColor),
          onTap: (){Navigator.of(context).pop();},
        ),
        backgroundColor: bgColor,
      ),
      body: Row(
        children: [
          // 5 forms display
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: ListView(
                children: [
                  // SizedBox(height: defaultPadding),
                  if (widget.showPart1) CarFrontFormDisplay(customer: widget.customer, form: widget.carFrontForm),
                  if (widget.showPart1) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                  if (widget.showPart2) BodyNumberFormDisplay(customer: widget.customer, form: widget.bodyNumberForm),
                  if (widget.showPart2) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                  if (widget.showPart3) BackBagFormDisplay(customer: widget.customer, form: widget.backBagForm),
                  if (widget.showPart3) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                  if (widget.showPart4) CarGroundFormDisplay(customer: widget.customer, form: widget.carGroundForm),
                  if (widget.showPart4) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                  if (widget.showPart5) CarPaintingFormDisplay(customer: widget.customer, form: widget.carPaintingForm),
                  if (widget.showPart5) Divider(height: defaultPadding, thickness: 4, color: iconColor),
                  if (widget.showPart6) CarAuditFormDisplay(customer: widget.customer, form: widget.carAuditForm),
                  SizedBox(height: defaultPadding),
                ],
              ),
            ),
        ),
          // PDF Viewer
          Expanded(
            child: Container(
             child: Stack(
               alignment: AlignmentDirectional.topEnd,
               children: [
                 FutureBuilder<bool> (
                   future: updatePdfFile,
                   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                     if (!snapshot.hasData) {
                       return const SizedBox();
                     } else {
                       return Padding(
                         padding: EdgeInsets.all(defaultPadding),
                         child: SfPdfViewer.memory(Uint8List.fromList(pdfAsBytes)),
                       );
                     }
                   },
                 ),
                 Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Visibility(
                     child: InkWell(
                       onTap: () {
                         PdfApi.saveAndLunchFile(pdfAsBytes, '${widget.carFrontForm.formNumber.text}.PDF');
                       },
                       child: Icon(
                         Icons.download_outlined,
                         size: 30,
                         color: Colors.black,
                       ),
                     ),
                     maintainSize: true,
                     maintainAnimation: true,
                     maintainState: true,
                     visible: downloadable,
                   )
                 ),
               ],
             ),
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  // combo box
                  Padding(
                    padding: EdgeInsets.only(top:defaultPadding * 0.5, right: defaultPadding, left: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نوع الفحص',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: txtColor
                          ),
                        ),
                        SizedBox(width: defaultPadding*0.5),
                        Expanded(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            icon: const Icon(Icons.arrow_downward, color: iconColor),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: txtColor),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? template) {
                              setState(() {
                                dropdownValue = template!;
                                this.editPdfController.text = changePdfControllerText(dropdownValue);
                                downloadable = false;
                              });
                            },
                            items: <String>[template3, template2, template1]
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
                  ),
                  // TextField
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      cursorColor: Colors.black,
                      controller: editPdfController,
                      style: TextStyle(color: txtColor),
                      onChanged: (string) {
                        setState(() {
                          this.downloadable = false;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        fillColor: bgColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      setState(() {
                        updatePdfFile=  createPDF(this.dropdownValue);
                      });
                    },
                    child: Text('تطبيق التحدثات على الملف'),
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }


  Future<bool> createPDF(String template) async {
    final PdfDocument document = PdfDocument();

    var page = document.pages.add();
    PdfFont font = PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]);
    document.pageSettings.size = PdfPageSize.a4;

    if (template == template1) {

      //Create the ID of the document
      page.graphics.drawString( " شهادة فحص رقم (${widget.carFrontForm.formNumber.text})",
        PdfTrueTypeFont(await _readFontData(), 25, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -150, 50, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: PdfTextAlignment.right,
          paragraphIndent: 0,
          wordWrap: PdfWordWrapType.word,
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 100, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "إسم طالب الفحص: ${widget.carAuditForm.c15.text} ",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 100, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 125, page.size.width - 82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "رقم الشاصي: ${widget.carAuditForm.c12.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 125, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 150, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "نوع المركبة: ${widget.carAuditForm.c14.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 150, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 175, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "الطراز: ${widget.carAuditForm.c18.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 175, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "الإنتاج: ${widget.carAuditForm.c19.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 175, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 200, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "رقم المركبة: ${widget.carAuditForm.c13.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 200, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "سنة الإنتاج: ${widget.carAuditForm.c20.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 200, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 225, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "مكان الترخيص: ${widget.carAuditForm.c21.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 225, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "عدد الركاب عدا السائق: ${widget.carAuditForm.c5.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 225, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 275, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "موضوع الفحص: $template",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 275, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );


      PdfLayoutResult layoutResult = PdfTextElement(
        text: "هذا الفحص بناء على رغبته الشخصية",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold, PdfFontStyle.underline]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 35
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( -150, 300, page.getClientSize().width, page.getClientSize().height),
      )!;

      updateParentsAndChildren();

      for(var i=0; i< this.parentsList.length; i++) {
        if(layoutResult.bounds.bottom > 650){
          page = document.pages.add();
          layoutResult = PdfTextElement(
            text: "",
          ).draw(
            page: page,
            bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
          )!;
        }

        layoutResult = PdfTextElement(
          text: this.parentsList[i].parent,
          font: PdfTrueTypeFont(await _readFontData(), 18, multiStyle: [PdfFontStyle.bold, PdfFontStyle.underline]),
          brush: PdfBrushes.black,
          format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0,
            wordWrap: PdfWordWrapType.word,
          ),
        ).draw(
          page: page,
          bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
        )!;

        for(var j=0; j < this.parentsList[i].children.length ; j++) {
          if(layoutResult.bounds.bottom > 650){
            page = document.pages.add();
            layoutResult = PdfTextElement(
              text: "",
            ).draw(
              page: page,
              bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
            )!;
          }

          layoutResult = PdfTextElement(
            text: this.parentsList[i].children[j],
            font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
            brush: PdfBrushes.black,
            format: PdfStringFormat(
              textDirection: PdfTextDirection.rightToLeft,
              alignment: PdfTextAlignment.right,
              paragraphIndent: 0,
              wordWrap: PdfWordWrapType.word,
            ),
          ).draw(
            page: page,
            bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 5, page.getClientSize().width, page.getClientSize().height),
          )!;
        }
      }

      if(layoutResult.bounds.bottom > 650){
        page = document.pages.add();
        layoutResult = PdfTextElement(
          text: "",
        ).draw(
          page: page,
          bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
        )!;
      }
      DateTime now = new DateTime.now();

      layoutResult = PdfTextElement(
        text: "تاريخ الإصدار: ${now.year}-${now.month}-${now.day}",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( -170, layoutResult.bounds.bottom + 20, page.getClientSize().width, page.getClientSize().height),
      )!;

      layoutResult = PdfTextElement(
        text: "توقيع وختم المدير المهني ______________               ختم مركز الفحص ______________ ",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
      )!;

      //Create a PDF page template and add footer content.
      final PdfPageTemplateElement footerTemplate =
      PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
      //Draw text in the footer.
      footerTemplate.graphics.drawString(
        '${widget.carAuditForm.c12.text}',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(180, 15, 200, 20),
        brush: PdfSolidBrush(PdfColor(112, 113, 120)),
      );
      document.template.bottom = footerTemplate;

    }
    if (template == template2 || template == template3) {

      //Create the ID of the document
      page.graphics.drawString( " شهادة فحص رقم (${widget.carFrontForm.formNumber.text})",
        PdfTrueTypeFont(await _readFontData(), 25, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -150, 50, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: PdfTextAlignment.right,
          paragraphIndent: 0,
          wordWrap: PdfWordWrapType.word,
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 100, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "إسم طالب الفحص: ${widget.carAuditForm.c15.text} ",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 100, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 125, page.size.width - 82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "رقم الشاصي: ${widget.carAuditForm.c12.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 125, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 150, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "نوع المركبة: ${widget.carAuditForm.c14.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 150, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 175, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "الطراز: ${widget.carAuditForm.c18.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 175, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "الإنتاج: ${widget.carAuditForm.c19.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 175, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 200, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "رقم المركبة: ${widget.carAuditForm.c13.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 200, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "سنة الإنتاج: ${widget.carAuditForm.c20.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 200, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 225, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "مكان الترخيص: ${widget.carAuditForm.c21.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 225, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "عدد الركاب عدا السائق: ${widget.carAuditForm.c5.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 225, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 250, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "حجم المحرك: ${widget.carAuditForm.c23.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 250, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "إسم المستورد: ${widget.carAuditForm.c16.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 250, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 275, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "نوع الوقود: ${widget.carAuditForm.c24.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 275, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "لون المركبة: ${widget.carAuditForm.c7.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 275, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 300, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "المسافة المقطوعة: ${widget.carAuditForm.c22.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 300, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );
      //Fill the rectangle 2
      page.graphics.drawString( "رقم معاملة الإستيراد: ${widget.carAuditForm.c17.text}",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( -200, 300, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create  a rectangle
      page.graphics.drawRectangle(
          bounds: Rect.fromLTWH(0, 325, page.size.width -82, 20),
          pen: PdfPen(PdfColor(0, 0, 0, 255))
      );
      //Fill the rectangle
      page.graphics.drawString( "موضوع الفحص: $template",
        font,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH( 0, 325, page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 10
        ),
      );

      //Create a PdfGrid class
      PdfGrid grid = PdfGrid();

      //Add the columns to the grid
      grid.columns.add(count: 5);

      //Add header to the grid
      grid.headers.add(1);

      //Add the rows to the grid
      PdfGridRow header = grid.headers[0];
      header.cells[0].value = 'قوة التسيير';
      header.cells[1].value = 'فتحة السقف';
      header.cells[2].value = 'وصلة جر';
      header.cells[3].value = 'نوع الغيار';
      header.cells[4].value = 'ESP';

      header.cells[0].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      header.cells[1].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      header.cells[2].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      header.cells[3].stringFormat = PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: PdfTextAlignment.center,
      );
      header.cells[4].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );

      //Add rows to grid
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = widget.carAuditForm.c10.text == 'true' ? '4/4' : '2/4';
      row.cells[1].value = widget.carAuditForm.c4.text;
      row.cells[2].value = widget.carAuditForm.c6.text == 'true' ? 'موجود' : 'غير موجود';
      row.cells[3].value = widget.carAuditForm.c25.text;
      row.cells[4].value = widget.carAuditForm.c9.text == 'true' ? 'موجود' : 'غير موجود';

      row.cells[0].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      row.cells[1].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      row.cells[2].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      row.cells[3].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      row.cells[4].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );

      //Set the grid style
      grid.style = PdfGridStyle(
        font: font,
      );

      //Draw the grid
      grid.draw(
          page: page,
          bounds: Rect.fromLTWH( 0, 350, page.getClientSize().width, page.getClientSize().height ),
      );

      PdfLayoutResult layoutResult = PdfTextElement(
        text: template == template2 ? "حسب متطلبات سلطة الترخيص" : "هذا الفحص بناء على رغبته الشخصية",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold, PdfFontStyle.underline]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 35
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( -150, 400, page.getClientSize().width, page.getClientSize().height),
      )!;

      updateParentsAndChildren();

      for(var i=0; i< this.parentsList.length; i++) {
        if(layoutResult.bounds.bottom > 650){
          page = document.pages.add();
          layoutResult = PdfTextElement(
            text: "",
          ).draw(
            page: page,
            bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
          )!;
        }

        layoutResult = PdfTextElement(
          text: this.parentsList[i].parent,
          font: PdfTrueTypeFont(await _readFontData(), 18, multiStyle: [PdfFontStyle.bold, PdfFontStyle.underline]),
          brush: PdfBrushes.black,
          format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0,
            wordWrap: PdfWordWrapType.word,
          ),
        ).draw(
          page: page,
          bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
        )!;

        for(var j=0; j < this.parentsList[i].children.length ; j++) {
          if(layoutResult.bounds.bottom > 650){
            page = document.pages.add();
            layoutResult = PdfTextElement(
              text: "",
            ).draw(
              page: page,
              bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
            )!;
          }

          layoutResult = PdfTextElement(
            text: this.parentsList[i].children[j],
            font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
            brush: PdfBrushes.black,
            format: PdfStringFormat(
              textDirection: PdfTextDirection.rightToLeft,
              alignment: PdfTextAlignment.right,
              paragraphIndent: 0,
              wordWrap: PdfWordWrapType.word,
            ),
          ).draw(
            page: page,
            bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 5, page.getClientSize().width, page.getClientSize().height),
          )!;
        }
      }

      if(layoutResult.bounds.bottom > 650){
        page = document.pages.add();
        layoutResult = PdfTextElement(
          text: "",
        ).draw(
          page: page,
          bounds: Rect.fromLTWH( 0, 50, page.getClientSize().width, page.getClientSize().height),
        )!;
      }
      DateTime now = new DateTime.now();

      layoutResult = PdfTextElement(
        text: "تاريخ الإصدار: ${now.year}-${now.month}-${now.day}",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( -170, layoutResult.bounds.bottom + 20, page.getClientSize().width, page.getClientSize().height),
      )!;

      layoutResult = PdfTextElement(
        text: "توقيع وختم المدير المهني ______________               ختم مركز الفحص ______________ ",
        font: PdfTrueTypeFont(await _readFontData(), 15, multiStyle: [PdfFontStyle.bold]),
        brush: PdfBrushes.black,
        format: PdfStringFormat(
            textDirection: PdfTextDirection.rightToLeft,
            alignment: PdfTextAlignment.right,
            paragraphIndent: 0
        ),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH( 0, layoutResult.bounds.bottom + 10, page.getClientSize().width, page.getClientSize().height),
      )!;

      //Create a PDF page template and add footer content.
      final PdfPageTemplateElement footerTemplate =
      PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
      //Draw text in the footer.
      footerTemplate.graphics.drawString(
        '${widget.carAuditForm.c12.text}',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(180, 15, 200, 20),
        brush: PdfSolidBrush(PdfColor(112, 113, 120)),
      );
      document.template.bottom = footerTemplate;

    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////

    pdfAsBytes = document.save();
    document.dispose();
    setState(() {this.downloadable = true;});
    return true;
  }

  Future<List<int>> _readFontData() async {
    final ByteData bytes = await rootBundle.load('assets/fonts/arial.ttf');
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  String changePdfControllerText(String template) {
    String controllerText = "";
    if (template == template1) {
      controllerText =
      "** 1) ماهية الفحص:\n"
          "* - فحص جودة وتركيب دواسات إضافية للمركبة.\n"
          "* - فحص صلاحية لوحة التحكم الكهربائية الإضافية.\n"
          "* \n"
          "** 2) تفاصيل الفحص:\n"
          "* - تم التأكد من المركبة المذكورة للفحص بأنها مطابقة للأوراق الثبوتية.\n"
          "* \n"
          "** 3) وصف تركيب الدواسات الإضافية:\n"
          "* - تم تركيب دواسات إضافية عدد (2) أمام المقعد الأمامي الأيمن وتتصل الدواسات المضافه مع الدواسات الأصلية بواسطة عامود قطره الخارجي (14) ملم لكل من دواسة الفرامل والوقود .\n"
          "* - ثبتت الدواسات المضافه بقاعدة سمكهما (6) مثبتتين بصدر كابينة المركبة بواسطة براغي عدد (2) من نوع M10.\n"
          "* - تم ربط الدواسات المضافه بواسطة وصلة ربط ولا يوجد أي خلوص ويوجد اتصال بمنطقة دوران اذرع التوصيل مع الدواسات الأصلية بواسطة اذرع قابلة للضبط بحيث ان يتم إعاقة حركة الدواسات المفصلية.\n"
          "* - جميع الأعمدة مزودة بكراسي (قواعد) خاصة مقاومة للإحتكاك، مزودة بنقاط تشحيم.\n"
          "* - ارتفاع الدواسات عن أرضية المركبة يتالئم مع الفاحص والسائق.\n"
          "* - ارتفاع الدواسات عن أرضية المركبة يتلأم مع الفاحص والسائق.\n"
          "* - صندوق غيارات اتوماتيكي.\n"
          "* \n"
          "* مجمل:\n"
          "* عملية تركيب الدواسات وتوصيلها مع الدواسات الأصلية تم بصورة جيده حسب الأصول وتتوافق مع متطلبات مفصل معهد المواصفات رقم 112 لسنة 1992\n"
          "* \n"
          "** 4) وصف تركيب اللوحة الكهربائية الإضافية:\n"
          "* - تم تركيب لوحة تحكم كهرباء للمدرب بين المقعدين على الصدر الأمامي للمركبة داخل كبينة السائق.\n"
          "* - تحتوي اللوحة الكهربائية على المفاتيح الكهربائية(كبسات كهربائية) التالية:\n"
          "*     أ- مفتاح لتشغيل الغمازات بحيث ان غماز المدرب يلغي الغماز الأصلي عند الضرورة.\n"
          "*     ب- مفتاح لتشغيل المنبه عند الضرورة.\n"
          "* مجمل:\n"
          "* عملية تركيب اللوحة الكهربائية حسب الأصول وتتوافق مع متطلبات وزارة النقل والمواصالت. \n"
          "* \n"
          "** 5) الفحص العملي:\n"
          "* تم أجراء فحص عملي على المركبة المذكورة على وضعية الدواسات فوجدت ملائمة وتعمل حسب الأصول وكما يجب من جهة الفاحص والسائق.\n"
          "* \n"
          "** نتيجة الفحص:\n"
          "* بناءا على ما ذكر أعلاه من تفاصيل فإننا نقر بأن المركبة المذكورة موضوع الفحص هي صالحة للعمل كمركبة "
          "لتدريب السواقة ضمن المتطلبات الإجبارية الخاصة بذلك والتي تضمن سالمة استخدام المركبة وعليه نوصي بصالحية "
          "المركبة كمركبة تدريب سواقة (اتوماتيك) وعلى ضوء ذلك نترك القرار بترخيص المركبة لسلطة الترخيص.\n"
          "* \n"
          "** ملاحظات:\n"
          "* - نتائج الفحص أنفة الذكر مدونه ومسجله في قيودات الملف اليدوي في المركز التقني لفحص هندسة ومواصفات المركبات /كلية هشام حجاوي.\n"
          "* - هذه الشهادة صالحة لمدة ثالثة أيام فقط من تاريخ الإصدار لمراجعة مديرية هندسة المركبات والمركز غير مسؤول عن أي تغيير يجري على مواصفات المركبة بعد إصدار التقرير.\n"
      ;
    }
    else if (template == template2){
      controllerText =
      "** 1) ماهية الفحص:\n"
          "* - فحص سلامة المركبة من الناحية الفنية.\n"
          "* - فحص المركبة من الناحية القانونية.\n"
          "* - فحص طلاء المركبة.\n"
          "* - فحص الإضافات الموجودة في المركبة.\n"
          "* \n"
          "** 2) كيفية إجراء الفحص ونتيجته:\n"
          "* - تم تفقد ارتباط الجزء المطبوع عليه رقم الهيكل فوجد ارتباطه اصلي.\n"
          "* - تم فحص المركبة من قبلنا وتبين ما يلي:\n"
          "*    - تم فحص سماكة طبقة الطلاء (الدهان) بواسطة جهاز (ELCOMETER) لفحص سماكة الطلاء ووجد طلاؤها أصلي.\n"
          "*    - تم فحص الهياكل الأساسية والفخذان الامامية ووجدت سليمة من القص.\n"
          "*    - تم فحص أرضية المركبة وأعمدة المركبة ووجدت سليمة من القص.\n"
          "*    - تم قياس أبعاد المركبة من الجانبين ولم يكن هناك تفاوت ملموس في قياسات أو أبعاد المركبة.\n"
          "*    - المركبة سليمة من القص العرضي والطولي.\n"
          "* \n"
          "** 3) نتيجة الفحص:\n"
          "* - على ضوء ما ذكر آنفا فان المركبة المذكور أعلاه سليمة من الناحية الفنية.\n"
          "* - تم تفقد ارتباط الجزء المطبوع عليه رقم الهيكل فوجد ارتباطه اصلي اي ان المركبة سليمة من الناحية القانونية.\n"
          "* - وعلى ضوء ذلك نترك القرار بترخيص المركبة لسلطة الترخيص.\n"
          "* \n"
          "** 4) ملاحظات:\n"
          "* - نتائج الفحص أنفة الذكر مدونه ومسجله في قيودات الملف اليدوي في المركز التقني لفحص هندسة ومواصفات المركبات /كلية هشام حجاوي.\n"
          "* - هذه الشهادة صالحة لمدة ثلاثة أيام فقط من تاريخ الإصدار لمراجعة مديرية هندسة المركبات والمركز غير مسؤول عن أي تغيير يجري على مواصفات المركبة بعد إصدار التقرير.\n"
          "* - معاينة رقم الهيكل مع خارطة المركبة من قبل سلطة الترخيص.\n"
          "* - المركز غير مسؤول عن فك او تعيير او تغيير الاجزاء المتحركة في المركبة (مثل ، الاجنحة و الابواب و المصدات، .....) او اي عيوب ظاهرة في جسم المركبة الخارجي.\n"
      ;
    }
    else if (template == template3) {
      controllerText =
      "** 1) ماهية الفحص:\n"
          "* - فحص سلامة جسم المركبة.\n"
          "* - فحص طلاء جسم المركبة.\n"
          "* - فحص الإضافات الموجودة في المركبة.\n"
          "* \n"
          "** 2) كيفية إجراء الفحص ونتيجته:\n"
          "* - تم فحص المركبة من قبلنا وتبين ما يلي:\n"
          "*    - تم فحص سماكة طبقة الطلاء (الدهان) بواسطة جهاز (ELCOMETER) لفحص سماكة الطلاء ووجد طلاؤها غير اصلي باستثناء طلاء سقف المركبة.\n"
          "*    - تم فحص الهياكل الأساسية ووجدت بحالة جيدة.\n"
          "*    - تم فحص أرضية المركبة ووجدت بحالة جيدة.\n"
          "*    - تم قياس أبعاد المركبة من الجانبين ولم يكن هناك تفاوت ملموس في قياسات أو أبعاد المركبة.\n"
          "*    - ضربة واعمال صيانة واصلاح في مقدمة المركبة تتركز في الفخذ ومقدمة الهيكل الامامي الايسر.\n"
          "*    - تشوه في ارضية المركبة والواجهة الخلفية وبطانة الجناح الخلفي الايسر.\n"
          "*    - اعمال اصلاح في الاجنحة الخلفية.\n"
          "*    - المركبة سليمة من القص العرضي والطولي.\n"
          "* \n"
          "** 3) ملاحظات:\n"
          "* - نتائج الفحص أنفة الذكر مدونه ومسجله في قيودات الملف اليدوي في المركز التقني لفحص هندسة ومواصفات المركبات /كلية هشام حجاوي.\n"
          "* - المركز غير مسؤول عن أي تغيير يجري على مواصفات المركبة بعد إصدار التقرير.\n"
          "* - هذه الشهادة لا تتطرق الى متطلبات سلطة الترخيص.\n"
          "* - هذه الشهادة لا تتطرق الى فك أو تعيير أو تغيير الأجزاء المتحركة في المركبة (مثل الاجنحة والابواب والمصدات،....) او اي عيوب ظاهرة في جسم المركبة الخارجي.\n"
      ;
    }
    else {
      controllerText = "template number not correct!!";
    }

    return controllerText;
  }

  void updateParentsAndChildren() {
    this.parentsList.clear();
    String paragraph = this.editPdfController.text;
    paragraph = paragraph.replaceAll('\n', '');
    List<String> lines = paragraph.split('**');

    lines.forEach((line) {
      List<String> subLines = line.split('*');
      this.parentsList.add(ParentAndChildrenAsStrings(subLines[0]));
      subLines.removeAt(0);
      subLines.forEach((subLine) {
        this.parentsList.last.children.add(subLine);
      });
    });

    // print the paragraph
    // this.parentsList.forEach((parent) {
    //   print("parent:" + parent.parent);
    //   print("children:");
    //   parent.children.forEach((child) {
    //     print("child"+ child);
    //   });
    // });

  }

} //CreateAndUpdatePDFState

class ParentAndChildrenAsStrings {
  String parent = "";
  List<String> children = <String>[];

  ParentAndChildrenAsStrings(String parent){
    this.parent = parent;
  }
}