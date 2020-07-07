import 'package:counterbet/model/betData.dart';
import 'package:counterbet/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:path_provider/path_provider.dart" as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDirectory.path);
  Hive.registerAdapter(BettingAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Hive.openBox('bets'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return ListScreen(title: 'counterBet');
            }
          } else {
            return Text('test');
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
}
