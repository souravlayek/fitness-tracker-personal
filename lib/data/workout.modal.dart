import 'dart:convert';

enum WeightType { number, kg, pound }

class WorkOut {
  final String id;
  final String workoutName;
  WorkOut({
    required this.id,
    required this.workoutName,
  });

  WorkOut copyWith({
    String? id,
    String? workoutName,
  }) {
    return WorkOut(
      id: id ?? this.id,
      workoutName: workoutName ?? this.workoutName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutName': workoutName,
    };
  }

  factory WorkOut.fromMap(Map<String, dynamic> map) {
    return WorkOut(
      id: map['id'] ?? '',
      workoutName: map['workoutName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkOut.fromJson(String source) =>
      WorkOut.fromMap(json.decode(source));

  @override
  String toString() => 'WorkOut(id: $id, workoutName: $workoutName)';
}

class Weight {
  final num weight;
  final WeightType type;
  Weight({
    required this.weight,
    required this.type,
  });

  Weight copyWith({
    num? weight,
    WeightType? type,
  }) {
    return Weight(
      weight: weight ?? this.weight,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'type': type,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      weight: map['weight'] ?? 0,
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source));

  @override
  String toString() => 'Weight(weight: $weight, type: $type)';
}

class TrackingData {
  final WorkOut workout;
  final Weight weight;
  final num reps;
  final num sets;
  TrackingData({
    required this.workout,
    required this.weight,
    required this.reps,
    required this.sets,
  });

  TrackingData copyWith({
    WorkOut? workout,
    Weight? weight,
    num? reps,
    num? sets,
  }) {
    return TrackingData(
      workout: workout ?? this.workout,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workout': workout.toMap(),
      'weight': weight.toMap(),
      'reps': reps,
      'sets': sets,
    };
  }

  factory TrackingData.fromMap(Map<String, dynamic> map) {
    return TrackingData(
      workout: WorkOut.fromMap(map['workout']),
      weight: Weight.fromMap(map['weight']),
      reps: map['reps'] ?? 0,
      sets: map['sets'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackingData.fromJson(String source) =>
      TrackingData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrackingData(workout: $workout, weight: $weight, reps: $reps, sets: $sets)';
  }
}
