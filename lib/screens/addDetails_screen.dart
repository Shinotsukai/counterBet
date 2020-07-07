import 'package:counterbet/model/betData.dart';
import 'package:counterbet/screens/tapCounter_screen.dart';
import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  TextEditingController _betTitle;
  TextEditingController _betOpening;
  TextEditingController _betSpinSize;
  TextEditingController _betLimit;
  TextEditingController _betDate;

  void _trackBet() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TapCounter(
              betTitle: _betTitle.text,
              betOpening: double.parse(_betOpening.text),
              betLimit: double.parse(_betLimit.text),
              betSpinSize: double.parse(_betSpinSize.text),
              betDate: _betDate.text,
            )));
    // print('on load test');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _betTitle = new TextEditingController();
    _betDate = new TextEditingController();
    _betLimit = new TextEditingController();
    _betOpening = new TextEditingController();
    _betSpinSize = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Bet Details'),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25.0,
                ),
                InputArea(
                    betTitle: _betTitle,
                    betOpening: _betOpening,
                    betSpinSize: _betSpinSize,
                    betLimit: _betLimit,
                    betDate: _betDate),
                SubmitButton(onTapped: _trackBet),
              ],
            ),
          ),
        ));
  }
}

class InputArea extends StatelessWidget {
  InputArea(
      {Key key,
      this.betTitle,
      this.betOpening,
      this.betSpinSize,
      this.betLimit,
      this.betDate})
      : super(key: key);

  final betTitle;
  final betOpening;
  final betSpinSize;
  final betLimit;
  final betDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedTextField(
          inputName: betTitle,
          labelText: 'Enter bet name',
          inputFormat: TextInputType.text,
        ),
        Row(
          children: [
            Expanded(
              child: DecoratedTextField(
                inputName: betSpinSize,
                labelText: 'Enter spin size',
                inputFormat: TextInputType.number,
              ),
            ),
            Expanded(
              child: DecoratedTextField(
                inputName: betLimit,
                labelText: 'Enter wager limit',
                inputFormat: TextInputType.number,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DecoratedTextField(
                inputName: betOpening,
                labelText: 'Enter opening balance',
                inputFormat: TextInputType.number,
              ),
            ),
            Expanded(
              child: DecoratedTextField(
                inputName: betDate,
                labelText: 'Enter date',
                inputFormat: TextInputType.datetime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  DecoratedTextField(
      {Key key,
      @required this.inputName,
      this.labelText,
      @required this.inputFormat})
      : super(key: key);

  final inputName;
  final labelText;
  final inputFormat;
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
        keyboardType: inputFormat,
        controller: inputName,
        decoration: InputDecoration.collapsed(hintText: labelText),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({Key key, this.onTapped}) : super(key: key);
  final onTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        color: Colors.blue,
        margin: EdgeInsets.only(top: 20.0),
        width: double.infinity,
        height: 80.0,
        child: Center(
            child: Text('Start Tapping',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
      ),
    );
  }
}
