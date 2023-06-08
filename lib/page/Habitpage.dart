import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/page/Addpage.dart';
import 'package:namer_app/page/Editpage.dart';
import 'package:namer_app/page/Settingpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/page/description.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Habitpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Text(
            'My Todo',
            style: GoogleFonts.paytoneOne(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Settingpage()));
              },
            ),
          ]),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('MyHabit')
              .doc('ECF9BVoey0aA9GP29rDk')
              .collection('test')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final list = snapshot.data?.docs;
              return ListView.builder(
                itemCount: list?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                    title: list![index]['Habit'],
                                    description: list[index]['description'])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.all(8),
                        height: 90,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Checkbox(
                                      value: list?[index]['Doit'],
                                      onChanged: (v) {
                                        showToast();
                                        FirebaseFirestore.instance
                                            .collection('MyHabit')
                                            .doc('ECF9BVoey0aA9GP29rDk')
                                            .collection('test')
                                            .doc(list?[index]
                                                .reference
                                                .id
                                                .toString())
                                            .update({
                                          'Doit': !list?[index]['Doit'],
                                          'Habit': list?[index]['Habit'],
                                          'description': list?[index]
                                              ['description']
                                        });
                                      }),
                                )),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 44),
                                        child: Text(
                                          list?[index]['Habit'],
                                          style: GoogleFonts.sourceCodePro(
                                              fontSize: 24),
                                        ),
                                      ),
                                    ])),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Editpage(
                                                    id: list?[index]
                                                        .reference
                                                        .id
                                                        .toString())));
                                      },
                                    )))
                          ],
                        ),
                      ));
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addpage()));
        },
      ),
    );
  }
}

void showToast() async {
  var url = Uri.parse('https://api.adviceslip.com/advice');
  var response = await http.get(url);
  Map<String, dynamic> advice = json.decode(response.body);
  String wise = advice["slip"]["advice"];
  Fluttertoast.showToast(
      msg: wise,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}

  // body: new SingleChildScrollView(
  //   child: Container(
  //       padding: EdgeInsets.all(16.0),
  //       child: new Form(

  //         child: FormUI(),
  //       )),
  // ));

  // Widget FormUI() {
  //   return Column(
  //     children: <Widget>[
  //       TextFormField(
  //         decoration: InputDecoration(hintText: 'Habit'),
  //         onSaved: (newValue) => habit = newValue,
  //       ),
  //       ElevatedButton(onPressed: SendtoServer, child: Text('send')),
  //     ],
  //   );
  // }

  // SendtoServer() {
  //   Navigator.pop(context);
  // }



/*
  String wise="";
  void callAPI() async {
    var url = Uri.parse('https://api.adviceslip.com/advice');
    var response = await http.get(url);
    Map<String, dynamic> advice = json.decode(response.body);
    wise = advice["slip"]["advice"];
    print(wise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text('Add Habit'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('추가 페이지'),
            ElevatedButton(onPressed: callAPI, child: Text('api')),
            Text('${wise}'),
          ],
        ),
      ),
    );
  }*/