import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

import '../../domain/repository/i_student_repository.dart';
import '../data_source/i_student_data_source.dart';

class StudentRepositoryImpl implements IStudentRepository {
  final IStudentDataSource _dataSource;

  StudentRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudentsByBatch(String batchId) async {
    try {
      final students = await _dataSource.getStudentsByBatch(batchId);
      return Right(students);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudentsByCourse(String courseId) async {
    try {
      final students = await _dataSource.getStudentsByCourse(courseId);
      return Right(students);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
