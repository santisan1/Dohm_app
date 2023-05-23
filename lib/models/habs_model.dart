// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HabsModel {
  final String asignedby;
  final String title;
  final String image;
  final int number;
  HabsModel({
    required this.asignedby,
    required this.title,
    required this.image,
    required this.number,
  });

  HabsModel copyWith({
    String? asignedby,
    String? title,
    String? image,
    int? number,
  }) {
    return HabsModel(
      asignedby: asignedby ?? this.asignedby,
      title: title ?? this.title,
      image: image ?? this.image,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'asigned_by': asignedby,
      'title': title,
      'image': image,
      'number': number,
    };
  }

  factory HabsModel.fromMap(Map<String, dynamic> map) {
    return HabsModel(
      asignedby: map['asignedby'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HabsModel.fromJson(String source) =>
      HabsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HabsModel(asigned_by: $asignedby, title: $title, image: $image, number: $number)';
  }

  @override
  bool operator ==(covariant HabsModel other) {
    if (identical(this, other)) return true;

    return other.asignedby == asignedby &&
        other.title == title &&
        other.image == image &&
        other.number == number;
  }

  @override
  int get hashCode {
    return asignedby.hashCode ^
        title.hashCode ^
        image.hashCode ^
        number.hashCode;
  }
}
