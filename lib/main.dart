import 'dart:convert';

import 'package:dropdownsample/company_names.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<CompanyNames> _companies;
  List<DropdownMenuItem<CompanyNames>> _dropdownMenuItems;
  CompanyNames _selectedCompany;

  final String url = "http://webmyls.com/php/getdata.php";

  @override
  void initState() {
    super.initState();
    getSWData();

  }

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      Iterable sessionsResult = json.decode(res.body);

      _companies = sessionsResult.map((model) => CompanyNames.fromJson(model)).toList();

      _dropdownMenuItems = buildDropdownMenuItems(_companies);
      _selectedCompany = _dropdownMenuItems[0].value;

    });

//    print(resBody);

    return "Sucess";
  }

  List<DropdownMenuItem<CompanyNames>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<CompanyNames>> items = List();
    for (CompanyNames company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.itemName),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(CompanyNames selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("DropDown Button Example"),
      ),
      body: new Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Select a company"),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Selected: ${_selectedCompany == null ? "Noting" : _selectedCompany.itemName}'),
            ],
          ),
        ),
      ),
    );
  }
}
