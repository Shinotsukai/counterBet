import 'package:counterbet/model/betData.dart';
import 'package:counterbet/widgets/fabNewBet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TapCounter extends StatefulWidget {
  TapCounter(
      {Key key,
      this.betTitle,
      this.betDate,
      this.betOpening,
      this.betSpinSize,
      this.betLimit})
      : super(key: key);

  final betTitle;
  final betDate;
  final double betOpening;
  final double betSpinSize;
  final double betLimit;

  @override
  _TapCounterState createState() => _TapCounterState();
}

class _TapCounterState extends State<TapCounter> {
  int _userClick = 0;
  int _totalClick;
  double betClosing = 10;

  setTapLimits() {
    double spinAmount = (widget.betLimit / widget.betSpinSize);
    _totalClick = spinAmount.round();
    print(_totalClick);
  }

  void _incrementClick() {
    if (_userClick < _totalClick) {
      setState(() {
        _userClick++;
      });
    } else if (_userClick == _totalClick) {
      completedAlert();
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
                saveBetDetails();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void saveToBox(Betting betting) {
    final bettingBox = Hive.box('bets');

    bettingBox.add(betting);
  }

  void saveBetDetails() {
    final newBet = Betting(widget.betTitle, widget.betDate, widget.betOpening,
        betClosing, 'complete');
    saveToBox(newBet);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTapLimits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
