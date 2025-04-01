import 'package:equatable/equatable.dart';

/// * The sensor identifier is an important concept and can have its own type.
typedef SensorID = String;

class Sensor extends Equatable {
  const Sensor({
    required this.sensorId,
    required this.type,
    required this.value,
    required this.timestamp,
  });

  /// Unique sensor ID
  final SensorID sensorId;
  final String type;
  final double value;
  final DateTime timestamp;

  @override
  List<Object?> get props => [
        sensorId,
        type,
        value,
        timestamp,
      ];

  @override
  bool? get stringify => true;

  Sensor copyWith({
    SensorID? sensorId,
    String? type,
    double? value,
    DateTime? timestamp,
  }) {
    return Sensor(
      sensorId: sensorId ?? this.sensorId,
      type: type ?? this.type,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': sensorId,
      'type': type,
      'value': value,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Sensor.fromMap(Map<String, dynamic> map) {
    return Sensor(
      sensorId: map['id'] as String,
      type: map['type'] as String,
      value: map['value'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }
}
