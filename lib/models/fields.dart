import 'dart:convert';

Rotation rotationFromJson(String str) => Rotation.fromJson(json.decode(str));

String rotationToJson(Rotation data) => json.encode(data.toJson());

class Rotation {
  Field field;
  List<List<dynamic>> step;
  static int count = 0;

  Rotation({
    required this.field,
    required this.step,
  }){
    count++;
    if (count > 5) {
      throw Exception("Maximum number of instances reached.");
    }
  }

  factory Rotation.fromJson(Map<String, dynamic> json) => Rotation(
    field: Field.fromJson(json["field"]),
    step: List<List<dynamic>>.from(json["step"].map((x) => List<dynamic>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "field": field.toJson(),
    "step": List<dynamic>.from(step.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}

class Field {
  Field({
    required this.n,
    required this.p,
    required this.k,
    required this.temp,
    required this.hum,
    required this.rain,
    required this.ph,
    required this.crops,
    required this.history,
  });

  int n;
  int p;
  int k;
  double temp;
  double hum;
  double rain;
  double ph;
  List<String> crops;
  List<String> history;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    n: json["n"],
    p: json["p"],
    k: json["k"],
    temp: json["temp"]?.toDouble(),
    hum: json["hum"]?.toDouble(),
    rain: json["rain"]?.toDouble(),
    ph: json["ph"]?.toDouble(),
    crops: List<String>.from(json["crops"].map((x) => x)),
    history: List<String>.from(json["history"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "n": n,
    "p": p,
    "k": k,
    "temp": temp,
    "hum": hum,
    "rain": rain,
    "ph": ph,
    "crops": List<String>.from(crops.map((x) => x)),
    "history": List<String>.from(history.map((x) => x)),
  };

  static List<Rotation> rotationPlan = [];
}
