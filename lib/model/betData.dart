import 'package:hive/hive.dart';

part 'betData.g.dart';

@HiveType(typeId: 0)
class Betting extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final double openingBal;
  @HiveField(3)
  final double closingBal;
  @HiveField(4)
  final String status;

  Betting(this.title, this.date, this.openingBal, this.closingBal, this.status);
}
