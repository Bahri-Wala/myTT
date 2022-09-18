// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mytt_front/models/facture.model.dart';
import 'package:mytt_front/services/facture.service.dart';
import 'package:mytt_front/widgets/fixedColumnWidget.dart';
import 'package:mytt_front/widgets/scrollableColumnWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Factures extends StatefulWidget{
  Future<dynamic> factures = FactureService.getFactures("");

  @override
  _FacturesState createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  String _searchResult = "";
  TextEditingController _searchController = TextEditingController();
  List<String> titles = ["createdAt", "montant", "payement"];
  List table_titles = [{"numero":"Numéro","createdAt":"Date", "montant":"Montant", "payement":"Payement"}];
  List<String> types = ["Tous","ADSL","FIXE","MOBILE"];
  String typesDropdownValue = "Tous";
  List<String> paymentFilter = ["Tous","payées seulement","Non payées seulement"];
  String paymentDropdownValue = "Tous";
  final _filterFormKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool filterVisibility = false;

  void filter(){
    var type = (typesDropdownValue == "Tous")?null:typesDropdownValue;
    var payement;
    switch (paymentDropdownValue){
      case "Tous": payement = null; break;
      case "payées seulement": payement = true; break;
      case "Non payées seulement":payement = false;
    }
    return setState(() {
      widget.factures = FactureService.filter({"search":_searchResult,"type":type,"payement":payement,"startDate":_startDateController.text,"endDate":_endDateController.text});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blue,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ),
            Container(
              width: 100,
              height: 100,
              child: const Image(image: AssetImage('lib/asset/images/logo1.png'))
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Factures",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
            ), 
            Visibility(
              visible: filterVisibility,
              child: Container(
                height: 340,
                width: MediaQuery.of(context).size.width*0.97,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ) ,
                child: Form(
                  key: _filterFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:50, top: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Filtres",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:10),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        filterVisibility = !filterVisibility;
                                      });
                                      _startDateController.clear();
                                      _endDateController.clear();
                                      typesDropdownValue = "Tous";
                                      paymentDropdownValue = "Tous";
                                      filter();
                                    }, 
                                    icon: Icon(Icons.close,size: 30,color: Colors.redAccent,)
                                  ),
                                )
                              ],
                            ),
                            dropDownRow("Type",types,typesDropdownValue,),
                            dropDownRow("Payement",paymentFilter,paymentDropdownValue,),
                            dateSelect(context,"De",_startDateController),
                            dateSelect(context,"A",_endDateController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: const [BoxShadow(
                                  color: Color.fromARGB(255, 252, 114, 160),
                                  offset: Offset(5.0,5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                )],
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: const [
                                    Color.fromARGB(255, 212, 187, 206),
                                    Color.fromARGB(255, 216, 43, 106),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () {
                                  _startDateController.clear();
                                  _endDateController.clear();
                                  typesDropdownValue = "Tous";
                                  paymentDropdownValue = "Tous";
                                  filter();
                                },
                                child: Text(
                                  'Réinitialiser',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: const [BoxShadow(
                                  color: Color.fromARGB(255, 252, 114, 160),
                                  offset: Offset(5.0,5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                )],
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: const [
                                    Color.fromARGB(255, 212, 187, 206),
                                    Color.fromARGB(255, 216, 43, 106),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () {
                                  filter();
                                },
                                child: Text(
                                  'Filtrer',
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.97 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Rechercher...', border: InputBorder.none
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchResult = value;
                          print(_searchResult);
                          filter();
                        });
                      }),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchResult = '';
                        filter();
                      });
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Visibility(
                visible: !filterVisibility,
                child: TextButton(
                  child: Text("filtrer",style: TextStyle(decoration: TextDecoration.underline,fontSize: 18),),
                  onPressed: () {
                    setState(() {
                      filterVisibility = !filterVisibility;
                    });
                  },
                ),
              ),
            ),
            FutureBuilder(
              future: widget.factures,//FactureService.getFactures(_searchResult),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Row(
                    children: [
                      FixedColumnWidget(data:snapshot.data),
                      ScrollableColumnWidget(data:snapshot.data),
                    ],
                  );
                }else{
                  return Text("Loading...");
                }
              }
            ),
          ]
        )
      ),
    );
  }

  Row dateSelect(BuildContext context,String label,controller) {
    return Row(
      children: [
        Text(label),
        Padding(
          padding: const EdgeInsets.only(left:10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: DateTimeField(
              controller: controller,
              format: DateFormat("yyyy-MM-dd"),
              resetIcon: Icon(Icons.close),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2200));
              },
            ),
          ),
        )
      ],
    );
  }

  Row dropDownRow(label,list,startValue) {
    return Row(
      children: [
        SizedBox(
          width : 100,
          child: Text(label)
        ),
        dropDownList(list,startValue),
      ],
    );
  }

  DropdownButton<String> dropDownList(list,startValue) {
    return DropdownButton<String>(
      value: startValue,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? value) {
        setState(() {
          if(list.length == 3){
            paymentDropdownValue = value!;
          }else{
            typesDropdownValue = value!;
          }
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}

