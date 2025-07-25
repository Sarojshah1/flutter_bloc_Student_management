import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/batch/data/model/batch_api_model.dart';
import 'package:student_management/features/course/data/model/course_api_model.dart';

part 'student_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String? phone;
  final BatchApiModel batch;
  final List<CourseApiModel> course;
  final String username;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.image,
     this.phone,
    required this.batch,
    required this.course,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(
      userId: id,
      fName: fname,
      lName: lname,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: course.map((e) => e.toEntity()).toList(),
      username: username,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(StudentEntity entity) {
    return AuthApiModel(
      fname: entity.fName,
      lname: entity.lName,
      image: entity.image,
      phone: entity.phone,
      batch: BatchApiModel.fromEntity(entity.batch),
      course: entity.courses.map((e) => CourseApiModel.fromEntity(e)).toList(),
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [id, fname, lname, image, phone, batch, course, username, password];
}