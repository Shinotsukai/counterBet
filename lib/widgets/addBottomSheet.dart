import 'package:counterbet/model/betData.dart';
import 'package:counterbet/screens/tapCounter_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      margin: EdgeInsets.all(16),
      child: SheetContainer(),
    );
  }
}

class SheetContainer extends StatefulWidget {
  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 225,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.grey[500], spreadRadius: 2)
              ]),
          child: Column(
            children: [Text('Enter Bet Details'), InputArea(), SubmitButton()],
          ),
        ),
      ],
    );
  }
}

class InputArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedTextField(),
      ],
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: 'Enter some text'),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  void _pushTapPage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TapCounter()));
  }

  void addNewBet(Betting betting) {
    final bettingBox = Hive.box('bets');
    bettingBox.add(betting);
    print(betting);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.grey[800],
      onPressed: () {
        final testData = Betting('test', '01/01/2020', 10.0, 10.0, 'complete');
        addNewBet(testData);
        // _pushTapPage(context)
      },
      child: Text(
        'Start Tapping',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
