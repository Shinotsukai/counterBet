// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'betData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BettingAdapter extends TypeAdapter<Betting> {
  @override
  final typeId = 0;
  @override
  Betting read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Betting(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as double,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Betting obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.openingBal)
      ..writeByte(3)
      ..write(obj.closingBal)
      ..writeByte(4)
      ..write(obj.status);
  }
}
