// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NombreCasa {
  final String nombre_casa;
  NombreCasa({
    required this.nombre_casa,
  });

  NombreCasa copyWith({
    String? nombre_casa,
  }) {
    return NombreCasa(
      nombre_casa: nombre_casa ?? this.nombre_casa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombre_casa': nombre_casa,
    };
  }

  factory NombreCasa.fromMap(Map<String, dynamic> map) {
    return NombreCasa(
      nombre_casa: map['nombre_casa'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NombreCasa.fromJson(String source) =>
      NombreCasa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NombreCasa(nombre_casa: $nombre_casa)';

  @override
  bool operator ==(covariant NombreCasa other) {
    if (identical(this, other)) return true;

    return other.nombre_casa == nombre_casa;
  }

  @override
  int get hashCode => nombre_casa.hashCode;
}
