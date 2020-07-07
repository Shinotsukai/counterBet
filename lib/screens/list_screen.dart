import 'package:counterbet/model/betData.dart';
import 'package:counterbet/screens/addDetails_screen.dart';
import 'package:counterbet/widgets/addBottomSheet.dart';
import 'package:counterbet/widgets/fabNewBet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BetStatsContainer(),
            BetList(),
          ],
        ),
      ),
      floatingActionButton: BottomSheet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class BetStatsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TotalEarnings(), TotalBets()],
      ),
    );
  }
}

class TotalEarnings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100.0,
        child: Card(
          child: Center(
            child: Text('Test'),
          ),
        ),
      ),
    );
  }
}

class TotalBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100.0,
        child: Card(
          child: Center(
            child: Text('Test'),
          ),
        ),
      ),
    );
  }
}

class BetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WatchBoxBuilder(
        box: Hive.box('bets'),
        builder: (context, bettingBox) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            itemCount: bettingBox.length,
            itemBuilder: (context, index) {
              final betData = bettingBox.get(index) as Betting;

              return SizedBox(
                  width: double.infinity,
                  child: BetListTile(
                    betData: betData,
                    deleteItem: () {
                      bettingBox.deleteAt(index);
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}

class BetListTile extends StatefulWidget {
  BetListTile({Key key, this.betData, this.deleteItem}) : super(key: key);

  final Betting betData;
  final Function deleteItem;

  @override
  _BetListTileState createState() => _BetListTileState();
}

class _BetListTileState extends State<BetListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.deleteItem,
      child: Card(
        child: ListTile(
          leading: Text(widget.betData.status),
          title: Text(widget.betData.title),
          subtitle: Text(widget.betData.date),
          trailing: Text('£' + widget.betData.closingBal.toString()),
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  void _pushPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddDetails()));
  }

  void _bottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => AddBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AddNewBet(
        height: 70.0,
        width: 70.0,
        butPressed: () {
          _pushPage();
        },
      ),
    );
  }
}
