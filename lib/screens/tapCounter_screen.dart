import 'package:counterbet/widgets/fabNewBet.dart';
import 'package:flutter/material.dart';

class TapCounter extends StatefulWidget {
  @override
  _TapCounterState createState() => _TapCounterState();
}

class _TapCounterState extends State<TapCounter> {
  int _userClick = 0;
  int _totalClick = 10;

  void _incrementClick() {
    if (_userClick < _totalClick) {
      setState(() {
        _userClick++;
      });
    } else if (_userClick == _totalClick) {
      completedAlert();
      print('Wooo it the end');
    }
  }

  Future<void> completedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tap limit reached'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have reached the total number of taps required'),
                Text('Please enter your ending balance'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Bet'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterNumber(
              userClick: _userClick,
              totalClick: _totalClick,
            )
          ],
        ),
      ),
      floatingActionButton: AddNewBet(
        height: 150.0,
        width: 150.0,
        butPressed: () {
          _incrementClick();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CounterNumber extends StatelessWidget {
  CounterNumber({Key key, this.userClick, this.totalClick}) : super(key: key);
  final userClick;
  final totalClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            userClick.toString(),
            style: TextStyle(fontSize: 125.0),
          ),
          Text(
            '/$totalClick',
            style: TextStyle(fontSize: 35.0),
          ),
        ],
      ),
    );
  }
}
