import 'package:hijjawi_front_end/classes/forms/back_bag_form.dart';
import 'package:hijjawi_front_end/classes/forms/body_number_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_audit_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_front_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_ground_form.dart';
import 'package:hijjawi_front_end/classes/forms/car_painting_form.dart';
import 'package:hijjawi_front_end/classes/customer.dart';
import 'package:hijjawi_front_end/screens/forms/display_5_parts_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';

class ShowAllFormsScreen extends StatefulWidget {

  ShowAllFormsScreen({Key? key, required this.customer}) : super(key: key);

  Customer customer ;
  @override
  _ShowAllFormsScreenState createState() => _ShowAllFormsScreenState();
}

class _ShowAllFormsScreenState extends State<ShowAllFormsScreen> with TickerProviderStateMixin {

  Icon customIcon = const Icon(Icons.search, color: iconColor);
  Widget customSearchBar = const Text('قائمة النماذج', style: TextStyle(color: txtColor),);
  ScrollController controller = ScrollController();
  TextEditingController searchFormIDController = TextEditingController();
  late Widget formsListSliver;
  int pageCount = 1;
  Future<bool> updateListView = Future.value(false);

  bool namesFilter = false;
  bool bodyNumberFilter = false;
  bool formIdFilter = false;
  bool carSignFilter = false;
  bool allFilter = true;

  @override
  void initState() {
    super.initState();
    pageCount = 1;
    updateListView = widget.customer.getAllForms(pageCount);

  }

  @override
  void dispose() {
    super.dispose();
    widget.customer.searchFormsList.clear();
	controller.dispose();			  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled ) => [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            leading: InkWell(
              child: Icon( Icons.arrow_back, color: iconColor),
              onTap: (){ Navigator.of(context).pop(); },
            ),
            title: customSearchBar,
            actions: [],
            backgroundColor: bgColor,
            centerTitle:  true,
            bottom: AppBar(
              backgroundColor: bgColor,
              actions: [
                Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        //رقم النموذج
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!formIdFilter){
                                formIdFilter = true;
                                bodyNumberFilter = false;
                                namesFilter = false;
                                allFilter = false;
                                carSignFilter = false;

                                this.searchFormIDController.text = '';
                                customSearchBar = ListTile(
                                  leading: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        this.pageCount = 1;
                                        widget.customer.searchFormsList.clear();
                                        updateListView =  widget.customer.getOneForm(this.searchFormIDController.text);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: iconColor,
                                      size: 28,
                                    ),
                                  ),
                                  title: TextField(
                                    controller: searchFormIDController,
                                    style: TextStyle(color: txtColor),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل رقم النموذج...',
                                      fillColor: secondaryColor,
                                      hintStyle: TextStyle(color: txtColor),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: formIdFilter ? secondaryColor : bgColor,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            padding: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            child: Text("حسب رقم النموذج", style: TextStyle(color: txtColor, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //لوحة السيارة
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!carSignFilter){
                                carSignFilter = true;
                                namesFilter = false;
                                bodyNumberFilter = false;
                                allFilter = false;
                                formIdFilter = false;


                                this.searchFormIDController.text = '';
                                customSearchBar = ListTile(
                                  leading: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        this.pageCount = 1;
                                        widget.customer.searchFormsList.clear();
                                        updateListView = widget.customer.getAllFormsByCarSign(pageCount, this.searchFormIDController.text);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: iconColor,
                                      size: 28,
                                    ),
                                  ),
                                  title: TextField(
                                    controller: searchFormIDController,
                                    style: TextStyle(color: txtColor),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل رقم لوحة السيارة...',
                                      fillColor: secondaryColor,
                                      hintStyle: TextStyle(color: txtColor),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: carSignFilter ? secondaryColor : bgColor,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            padding: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            child: Text("حسب لوحة السيارة", style: TextStyle(color: txtColor, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //إسم طالب الفحص
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!namesFilter){
                                namesFilter = true;
                                bodyNumberFilter = false;
                                allFilter = false;
                                formIdFilter = false;
                                carSignFilter = false;

                                this.searchFormIDController.text = '';
                                customSearchBar = ListTile(
                                  leading: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        this.pageCount = 1;
                                        widget.customer.searchFormsList.clear();
                                        updateListView = widget.customer.getAllFormsByName(pageCount, this.searchFormIDController.text);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: iconColor,
                                      size: 28,
                                    ),
                                  ),
                                  title: TextField(
                                    controller: searchFormIDController,
                                    style: TextStyle(color: txtColor),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل الإسم أو جزء من الإسم...',
                                      fillColor: secondaryColor,
                                      hintStyle: TextStyle(color: txtColor),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: namesFilter ? secondaryColor : bgColor,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            padding: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            child: Text("حسب إسم طالب الفحص", style: TextStyle(color: txtColor, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //رقم شصي
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!bodyNumberFilter){
                                bodyNumberFilter = true;
                                namesFilter = false;
                                allFilter = false;
                                formIdFilter = false;
                                carSignFilter = false;

                                this.searchFormIDController.text = '';
                                customSearchBar = ListTile(
                                  leading: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        this.pageCount = 1;
                                        widget.customer.searchFormsList.clear();
                                        updateListView = widget.customer.getAllFormsByBodyNumber(pageCount, this.searchFormIDController.text);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: iconColor,
                                      size: 28,
                                    ),
                                  ),
                                  title: TextField(
                                    controller: searchFormIDController,
                                    style: TextStyle(color: txtColor),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل رقم الشصي او جزء منه...',
                                      fillColor: secondaryColor,
                                      hintStyle: TextStyle(color: txtColor),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: bodyNumberFilter ? secondaryColor : bgColor,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            padding: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            child: Text("حسب رقم الشصي", style: TextStyle(color: txtColor, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //الجميع
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(!allFilter){
                                allFilter = true;
                                bodyNumberFilter = false;
                                namesFilter = false;
                                formIdFilter = false;
                                carSignFilter = false;

                                widget.customer.searchFormsList.clear();

                                this.pageCount = 1;
                                customSearchBar = const Text('قائمة النماذج', style: TextStyle(color: txtColor),);
                                updateListView = widget.customer.getAllForms(pageCount);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: allFilter ? secondaryColor : bgColor,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            padding: EdgeInsets.only(top: defaultPadding/2, bottom: defaultPadding/2, right: defaultPadding, left: defaultPadding),
                            child: Text("الجميع", style: TextStyle(color: txtColor, fontWeight: FontWeight.bold)),
                          ),
                        ),

                      ],
                    ),
                  )
                ),
              ],
            )
          ),
        ],
        body: FutureBuilder<bool>(
          future: updateListView,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if ( snapshot.hasData) {
              formsListSliver = SliverToBoxAdapter(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: defaultPadding);
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: controller,
                  padding: EdgeInsets.only(top: defaultPadding, right: defaultPadding, left: defaultPadding),
                  itemCount: widget.customer.searchFormsList.length +1,
                  itemBuilder: (BuildContext context, int index) {
                    if(index == widget.customer.searchFormsList.length){
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if(allFilter) updateListView = widget.customer.getAllForms(++pageCount);
                            else if (namesFilter) updateListView = widget.customer.getAllFormsByName(++pageCount, this.searchFormIDController.text);
                          });
                        },
                        child: Center(
                          child: Text(
                            "إظهار المزيد من النتائج",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      );
                    } else {
                      return ListTile(
                        onTap: (){
                          Navigator.push( context, MaterialPageRoute(builder: (context) => Display5PartsForm(
                            customer: widget.customer,
                            carFrontForm: assignListItemToForm(widget.customer.searchFormsList[index], 1),
                            bodyNumberForm: assignListItemToForm(widget.customer.searchFormsList[index], 2),
                            backBagForm: assignListItemToForm(widget.customer.searchFormsList[index], 3),
                            carGroundForm: assignListItemToForm(widget.customer.searchFormsList[index], 4),
                            carPaintingForm: assignListItemToForm(widget.customer.searchFormsList[index], 5),
                            carAuditForm: assignListItemToForm(widget.customer.searchFormsList[index], 6),
                          )));
                        },
                        title: Text('رقم النموذج: ${widget.customer.searchFormsList[index]['id']}', style: TextStyle(color: txtColor),),
                        // dense: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                        selected: true,
                        selectedTileColor: secondaryColor,
                      );
                    }
                  },
                ),
              );
            } else {
              return const SizedBox();
            }

            return CustomScrollView(
              // controller: controller,
              slivers: <Widget>[
                formsListSliver
              ],
            );

          },
        ),
      ),
    );
  }

  dynamic assignListItemToForm(dynamic listItem, var part){
    dynamic form;
    switch(part) {
      case 1: {
        form = CarFrontForm.display( listItem['id'],
          listItem['c1'],
          listItem['c2'],
          listItem['c3'],
          listItem['c4'],
          listItem['c5'],
          listItem['c6'],
          listItem['c7']
        );
        break;
      }
      case 2: {
        form = BodyNumberForm.display( listItem['id'],
          listItem['c8'],
          listItem['c9'],
        );
        break;
      }
      case 3: {
        form = BackBagForm.display( listItem['id'],
          listItem['c10'],
          listItem['c11'],
          listItem['c12'],
          listItem['c13'],
          listItem['c14'],
          listItem['c15'],
          listItem['c16']
        );
        break;
      }
      case 4: {
        form = CarGroundForm.display( listItem['id'],
          listItem['c17'],
          listItem['c18'],
          listItem['c19'],
          listItem['c20'],
          listItem['c21'],
          listItem['c22'],
          listItem['c23'],
          listItem['c24'],
          listItem['c25'],
          listItem['c26']
        );
        break;
      }
      case 5: {
        form = CarPaintingForm.display( listItem['id'],
          listItem['c27_1'],  listItem['c27_n'],
          listItem['c28_1'],  listItem['c28_2'],  listItem['c28_n'],
          listItem['c29_1'],  listItem['c29_2'],  listItem['c29_n'],
          listItem['c30_1'],  listItem['c30_2'],  listItem['c30_n'],
          listItem['c31_1'],  listItem['c31_2'],  listItem['c31_n'],
          listItem['c32_1'],  listItem['c32_2'],  listItem['c32_n'],
          listItem['c33_1'],  listItem['c33_2'],  listItem['c33_n'],
          listItem['c34_1'],  listItem['c34_2'],  listItem['c34_n'],
          listItem['c35_1'],  listItem['c35_2'],  listItem['c35_n'],
          listItem['c36_1'],  listItem['c36_2'],  listItem['c36_n'],
          listItem['c37_1'],  listItem['c37_n'],
          listItem['c38_1'],  listItem['c38_n'],
        );
        break;
      }
      case 6: {
        form = CarAuditForm.display( listItem['id'],
          listItem['c39'],
          listItem['c40'],
          listItem['c41'],
          listItem['c42'],
          listItem['c43'],
          listItem['c44'],
          listItem['c45'],
          listItem['c46'],
          listItem['c47'],
          listItem['c48'],
          listItem['c49'],
          listItem['c50'],
          listItem['c51'],
          listItem['c52'],
          listItem['c53'],
          listItem['c54'],
          listItem['c55'],
          listItem['c56'],
          listItem['c57'],
          listItem['c58'],
          listItem['c59'],
          listItem['c60'],
          listItem['c61'],
          listItem['c62'],
          listItem['c63'],
        );
        break;
      }
      default: {
        print('error: parts number have to be from 1 to 6 only');
        form = null;
        break;
      }
    }
    return form;
  }

}
