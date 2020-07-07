import 'package:flutter/material.dart';

class AddNewBet extends StatelessWidget {
  AddNewBet({Key key, this.butIcon, this.butPressed, this.height, this.width})
      : super(key: key);

  final butIcon;
  final butPressed;
  final height;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          elevation: 10,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: butPressed,
        ),
      ),
    );
  }
}
