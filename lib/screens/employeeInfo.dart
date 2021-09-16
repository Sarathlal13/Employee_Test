import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeInfo extends StatefulWidget {
  EmployeeInfo({this.empInfo});
  final empInfo;
  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Data"),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: widget.empInfo["profile_image"] == null
                    ? null
                    : NetworkImage(widget.empInfo["profile_image"]),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.empInfo["name"],
                style: TextStyle(fontSize: 18),
              ),
              Text("User Name ${widget.empInfo["username"]}"),
              Text("Email ${widget.empInfo["email"]}"),
              Text(
                "Address :",
                style: TextStyle(fontSize: 18),
              ),
              Text("${widget.empInfo["address"]["street"]}"),
              Text("${widget.empInfo["address"]["suite"]}"),
              Text("${widget.empInfo["address"]["city"]}"),
              Text("${widget.empInfo["address"]["zipcode"]}"),
              widget.empInfo["phone"] != null
                  ? Text("Phone:   ${widget.empInfo["phone"]}")
                  : Container(),
              widget.empInfo["website"] != null
                  ? Text("Wbsite ${widget.empInfo["website"]}")
                  : Container(),
              Text(
                "Company :",
                style: TextStyle(fontSize: 18),
              ),
              widget.empInfo["company"] != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.empInfo["company"]["name"]}"),
                        Text("${widget.empInfo["company"]["catchPhrase"]}"),
                        Text("${widget.empInfo["company"]["bs"]}"),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      )),
    );
  }
}
