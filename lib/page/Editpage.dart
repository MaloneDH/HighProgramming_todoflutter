import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editpage extends StatelessWidget {
  final String? id;
  Editpage({this.id});

  TextEditingController habitController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

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
          Column(children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).colorScheme.background;
                return Theme.of(context).colorScheme.background;
              })),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('MyHabit')
                    .doc('ECF9BVoey0aA9GP29rDk')
                    .collection('test')
                    .doc(id)
                    .update({
                  'Doit': false,
                  'Habit': habitController.text,
                  'description': descriptController.text
                });
                Navigator.pop(context);
              },
              child: Text(
                'Edit Habit',
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).colorScheme.background;
                return Theme.of(context).colorScheme.error;
              })),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('MyHabit')
                    .doc('ECF9BVoey0aA9GP29rDk')
                    .collection('test')
                    .doc(id)
                    .delete();
                Navigator.pop(context);
              },
              child: Text(
                'Delete Habit',
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
              ),
            )
          ])
        ]),
      ),
    );
  }
}
