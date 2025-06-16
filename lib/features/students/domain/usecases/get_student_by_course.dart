import 'package:dartz/dartz.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/students/domain/usecases/params/student_params.dart';

import '../repository/i_student_repository.dart';

class GetStudentsByCourse implements UsecaseWithParams<List<StudentEntity>, CourseIdParam> {
  final IStudentRepository _studentRepository;

  GetStudentsByCourse({required IStudentRepository studentRepository})
      : _studentRepository = studentRepository;

  @override
  Future<Either<Failure, List<StudentEntity>>> call(CourseIdParam params) {
    return _studentRepository.getStudentsByCourse(params.courseId);
  }
}
