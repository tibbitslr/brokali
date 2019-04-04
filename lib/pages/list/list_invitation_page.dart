import 'package:flutter/material.dart';

import 'package:brokali/platform/_platform.dart' show BroServices;
import 'package:brokali/pages/common/_common.dart' show BroTextInputController;

class BroListInvitationPage extends StatefulWidget {
  final String stackName;

  BroListInvitationPage(this.stackName);

  @override
  _BroListInvitationPageState createState() => _BroListInvitationPageState();
}

class _BroListInvitationPageState extends State<BroListInvitationPage> {
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    emailController = BroTextInputController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF2E2E2E),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Invitation'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: size.height * 0.07),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Who do you want to share'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '"${widget.stackName ?? '_NameNotFound_'}" ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('shopping list with?'),
                ],
              ),
              Container(
                width: size.width * 0.8,
                padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    hintStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(
                      color: Color(0xFFFEF8E5),
                      fontSize: 14,
                    ),
                    fillColor: Colors.black,
                  ),
                  focusNode: FocusNode(),
                  controller: emailController,
                ),
              ),
              RaisedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Text(
                      'SEND INVITATION',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                color: Color(0xFF256600),
                onPressed: () async {
                  if (emailController.text.trim() != '') {
                    BroServices.hideKeyboard();
                    await Future<void>.delayed(Duration(milliseconds: 300));
                    Navigator.of(context).pop(emailController.text);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
