import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/main.dart';

class Settingpage extends StatefulWidget {
  @override
  SettingpageState createState() => SettingpageState();
}

class SettingpageState extends State<Settingpage> {
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          'Setting Habit',
          style: GoogleFonts.paytoneOne(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  'Dark Mode',
                  style: GoogleFonts.sourceCodePro(fontSize: 24),
                ),
              ),
              Switch(
                  value: _switch,
                  onChanged: (v) {
                    setState(() {
                      _switch = MyApp.themeNotifier.value == ThemeMode.dark
                          ? false
                          : true;
                    });
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  }),
            ],
          )
        ]),
      ),
    );
  }
}
