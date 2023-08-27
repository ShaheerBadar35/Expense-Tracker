import 'package:flutter/material.dart';
import 'package:fourth_project/widgets/expenses.dart';
//import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (fn) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //color: Colors.black,
      darkTheme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 36, 36, 36))),
      theme: ThemeData().copyWith(useMaterial3: true),
      home: const Expenses(),
    ),
  );
//    },
//  );
}
