import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract class IStudentRepository {
  Future<Either<Failure, List<StudentEntity>>> getStudentsByBatch(String batchId);
  Future<Either<Failure, List<StudentEntity>>> getStudentsByCourse(String courseId);
}