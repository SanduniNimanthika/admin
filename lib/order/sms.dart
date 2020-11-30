import 'dart:async';


import 'package:admin/order/odertab.dart';
import 'package:admin/order/previeworder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:admin/commanpages/configue.dart';

class EmailSender extends StatefulWidget {
  final String text;

  EmailSender({
    Key key,
    @required this.text,
  }) : super(key: key);
  @override
  _EmailSenderState createState() => _EmailSenderState(text: text);
}

class _EmailSenderState extends State<EmailSender> {
  final String text;

  _EmailSenderState({
    Key key,
    @required this.text,
  });
  String attachment;



  final _subjectController = TextEditingController(text: 'Bill for your order');

  final _bodyController = TextEditingController(
    text: 'products and prices.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [text]
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'send an email';
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OrderTab()));
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10 * SizeConfig.heightMultiplier),
          child: Material(
            elevation: 0.0,
            child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PerscriptionPreview()));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: send,
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        child: new Center(
                            child: new TextFormField(
                                initialValue: text,
                                // controller: _recipientController,
                                decoration: new InputDecoration(
                                  labelText: 'Recipient',
                                  prefixIcon:
                                      Icon(Icons.add, color: Colors.blueGrey),
                                  labelStyle:
                                      Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                ),


                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.display1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        child: new Center(
                            child: new TextFormField(
                                controller: _subjectController,
                                decoration: new InputDecoration(
                                  labelText: 'Subject',
                                  prefixIcon:
                                      Icon(Icons.add, color: Colors.blueGrey),
                                  labelStyle:
                                      Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                ),
                                validator: (input) => input.isEmpty
                                    ? 'Please enter subject for email '
                                    : null,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.display1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        child: new Center(
                            child: new TextFormField(
                                maxLines: 10,
                                controller: _bodyController,
                                decoration: new InputDecoration(
                                  labelText: 'Body',
                                  prefixIcon:
                                      Icon(Icons.add, color: Colors.blueGrey),
                                  labelStyle:
                                      Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                ),
                                validator: (input) => input.isEmpty
                                    ? 'Please enter body for email '
                                    : null,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.display1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
