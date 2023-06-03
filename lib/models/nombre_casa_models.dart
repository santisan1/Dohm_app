// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NombreCasa {
  final String nombreCasa;
  NombreCasa({
    required this.nombreCasa,
  });

  NombreCasa copyWith({
    String? nombreCasa,
  }) {
    return NombreCasa(
      nombreCasa: nombreCasa ?? this.nombreCasa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombreCasa': nombreCasa,
    };
  }

  factory NombreCasa.fromMap(Map<String, dynamic> map) {
    return NombreCasa(
      nombreCasa: map['nombreCasa'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NombreCasa.fromJson(String source) =>
      NombreCasa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NombreCasa(nombreCasa: $nombreCasa)';

  @override
  bool operator ==(covariant NombreCasa other) {
    if (identical(this, other)) return true;

    return other.nombreCasa == nombreCasa;
  }

  @override
  int get hashCode => nombreCasa.hashCode;
}
