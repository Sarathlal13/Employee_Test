import 'dart:convert';

import 'package:employee_details/networking.dart';
import 'package:employee_details/screens/employeeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const url = "http://www.mocky.io/v2/5d565297300000680030a986";

class EmployeeHome extends StatefulWidget {
  _EmployeeHomeState createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  var employeelist;
  var searchedList = [];
  TextEditingController searchctrl = TextEditingController();
  @override
  void initState() {
    loadEmployeeData();
    super.initState();
  }

  Future<void> loadEmployeeData() async {
    EmployeeService employeeService = EmployeeService(url: url);
    var storedData = await employeeService.getEmpData();
    if (storedData == null) {
      employeelist = await employeeService.getEmpDetails();
      print(employeelist[0]["name"]);
    } else {
      employeelist = jsonDecode(storedData);
      print(employeelist[0]["name"]);
    }
    setState(() {});
  }

  onSearchTextChanged(String text) async {
    print(text);
    setState(() {
      searchedList.clear();
      employeelist.forEach((element) {
        if (element["name"].toLowerCase().contains(text.toLowerCase()) ||
            element["email"].toLowerCase().contains(text.toLowerCase())) {
          searchedList.add(element);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 20, bottom: 10),
            height: 20,
            width: 200,
            child: TextField(
              controller: searchctrl,
              style: TextStyle(height: 2, fontSize: 15),
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, top: 0, bottom: 15),
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: searchedList.length != 0
            ? ListView.builder(
                itemCount: searchedList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EmployeeInfo(empInfo: searchedList[index]),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            searchedList[index]["profile_image"] == null
                                ? null
                                : NetworkImage(
                                    searchedList[index]["profile_image"]),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${searchedList[index]["name"]}"),
                          searchedList[index]["company"] != null
                              ? Text(
                                  "${searchedList[index]["company"]["name"]}",
                                  style: TextStyle(fontSize: 14),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  );
                })
            : employeelist != null
                ? ListView.builder(
                    itemCount: employeelist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeInfo(empInfo: employeelist[index]),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                employeelist[index]["profile_image"] == null
                                    ? null
                                    : NetworkImage(
                                        employeelist[index]["profile_image"]),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${employeelist[index]["name"]}"),
                              employeelist[index]["company"] != null
                                  ? Text(
                                      "${employeelist[index]["company"]["name"]}",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("Loading.."),
                  ),
      ),
    );
  }
}
