import 'package:arms/src/constants/constants.dart';

const deliveryHours = [
  '午前中',
  '12:00 〜 13:00',
  '13:00 〜 14:00',
  '14:00 〜 15:00',
  '15:00 〜 16:00',
  '16:00 〜 17:00',
  '17:00 〜 18:00',
  '18:00 〜 19:00',
  '19:00 〜 20:00',
  '20:00 〜 21:00',
];

enum DeliveryTimeZoneType {
  form10amTo11am,
  form11amTo12am,
  form12amTo13pm,
  form13pmTo14pm,
  form14pmTo15pm,
  form15pmTo16pm,
  form16pmTo17pm,
  form17pmTo18pm,
  form18pmTo19pm,
  form19pmTo20pm,
  form20pmTo21pm,
}

class DeliveryTime {
  const DeliveryTime({
    required this.type,
    required this.string,
    required this.hour,
  });

  final DeliveryTimeZoneType type;
  final String string;
  final int hour;

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'string': string,
      'hour': hour,
    };
  }

  factory DeliveryTime.fromMap(Map<String, dynamic> map) {
    return DeliveryTime(
      type: map['type'] as DeliveryTimeZoneType,
      string: map['string'] as String,
      hour: map['hour'] as int,
    );
  }
}

class ScheduledDeliveryDate {
  const ScheduledDeliveryDate({
    required this.date,
    required this.deliveryTime,
  });

  factory ScheduledDeliveryDate.fromMap(Map<String, dynamic> map) {
    return ScheduledDeliveryDate(
        date: DateTime.parse(map['date'] as String),
        deliveryTime: DeliveryTime.fromMap(
          map['deliveryTime'] as Map<String, dynamic>,
        ));
  }

  factory ScheduledDeliveryDate.init() {
    late DeliveryTime deliveryTime;
    late DateTime date;
    final now = DateTime.now();
    for(var time in Constants.deliveryTimes) {
      if (now.hour + 1 == time.hour) {
        deliveryTime = time;
        break;
      } else {
        deliveryTime = Constants.deliveryTimes.first;
      }
    }

    if (now.hour >= 21) {
      date = now.add(const Duration(days: 1));
    } else {
      date = DateTime(now.year, now.month, now.day, deliveryTime.hour);
    }

    return ScheduledDeliveryDate(
      date: date,
      deliveryTime: deliveryTime,
    );
  }

  final DateTime date;
  final DeliveryTime deliveryTime;

  Map<String, dynamic> toMap() {
    return {
      'data': date.toIso8601String(),
      'hour': deliveryTime,
    };
  }

  ScheduledDeliveryDate copyWith({
    DateTime? date,
    DeliveryTime? deliveryTime,
  }) {
    return ScheduledDeliveryDate(
      date: date ?? this.date,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  String displaySchedule() {
    final now = DateTime.now();
    late String dateString;
    if (date.month == now.month && date.day == now.day) {
      dateString = 'Today';
    } else {
      dateString = '${date.month}/${date.day}';
    }
    return '$dateString, ${deliveryTime.string}';
  }
}
