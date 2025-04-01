import 'dart:convert';

import 'package:aquaponics/src/features/control/domain/sensor.dart';
import 'package:equatable/equatable.dart';

class History extends Equatable {
  const History([this.items = const {}]);

  /// All the items in the history, where:
  /// - key: sensor ID
  /// - value: quantity
  final Map<SensorID, int> items;

  factory History.fromMap(Map<String, dynamic> map) {
    return History(Map<SensorID, int>.from(map['items']));
  }

  Map<String, dynamic> toMap() => {'items': items};

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

extension HistoryItems on History {
  List<Sensor> toItemsList() {
    return items.entries.map((entry) {
      return Sensor(
        sensorId: entry.key,
        type: entry.key,
        value: entry.value.toDouble(),
        timestamp: entry.value == 0
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(
                entry.value,
              ),
      );
    }).toList();
  }
}
