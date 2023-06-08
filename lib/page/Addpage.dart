import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Addpage extends StatefulWidget {
  @override
  AddpageState createState() => AddpageState();
}

class AddpageState extends State<Addpage> {
  TextEditingController habitController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  addtasktofirebase() {
    var time = DateTime.now();
    FirebaseFirestore.instance
        .collection('MyHabit')
        .doc('ECF9BVoey0aA9GP29rDk')
        .collection('test')
        .doc(time.toString())
        .set({
      'Doit': false,
      'Habit': habitController.text,
      'description': descriptController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          'Add Habit',
          style: GoogleFonts.paytoneOne(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
            child: TextField(
              controller: habitController,
              decoration: InputDecoration(
                  labelText: 'Habit', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: TextField(
              controller: descriptController,
              decoration: InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(height: 10),
          Container(
              alignment: FractionalOffset.bottomCenter,
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Theme.of(context).colorScheme.background;
                  return Theme.of(context).colorScheme.background;
                })),
                onPressed: () {
                  addtasktofirebase();
                  Navigator.pop(context);
                },
                child: Text(
                  'Add Habit',
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                ),
              ))
        ]),
      ),
    );
  }
}
