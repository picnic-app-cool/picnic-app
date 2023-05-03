import 'dart:convert';

import 'package:hive/hive.dart';

class HiveJsonAdapter extends TypeAdapter<Map<String, dynamic>> {
  HiveJsonAdapter(
    this.typeId,
  );

  @override
  final int typeId;

  @override
  Map<String, dynamic> read(BinaryReader reader) => jsonDecode(reader.readString()) as Map<String, dynamic>;

  @override
  void write(BinaryWriter writer, Map<String, dynamic> obj) => writer.writeString(jsonEncode(obj));
}
