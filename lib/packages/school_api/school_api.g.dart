// GENERATED CODE - DO NOT MODIFY BY HAND

part of school_api;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolLifeTicketAdapter extends TypeAdapter<SchoolLifeTicket> {
  @override
  final int typeId = 0;

  @override
  SchoolLifeTicket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolLifeTicket(
      duration: fields[0] as String,
      displayDate: fields[1] as String,
      reason: fields[2] as String,
      type: fields[3] as String,
      isJustified: fields[4] as bool,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SchoolLifeTicket obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.displayDate)
      ..writeByte(2)
      ..write(obj.reason)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isJustified)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolLifeTicketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
