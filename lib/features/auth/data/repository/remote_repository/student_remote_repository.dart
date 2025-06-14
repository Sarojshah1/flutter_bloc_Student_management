import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/data/data_source/remote_datasource/student_remote_datasource.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class StudentRemoteRepository implements IStudentRepository {
  final StudentRemoteDatasource _dataSource;

  StudentRemoteRepository({required StudentRemoteDatasource datasource})
      : _dataSource = datasource;

  @override
  Future<Either<Failure, void>> registerStudent(StudentEntity student) async {
    try {
      await _dataSource.registerStudent(student);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(String username, String password) async {
    try {
      final token = await _dataSource.loginStudent(username, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final result = await _dataSource.uploadProfilePicture(file.path);
      return Right(result);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getCurrentUser() async {
    try {
      final student = await _dataSource.getCurrentUser();
      return Right(student);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
