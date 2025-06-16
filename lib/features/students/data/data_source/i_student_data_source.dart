import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract class IStudentDataSource {
  Future<List<StudentEntity>> getStudentsByBatch(String batchId);
  Future<List<StudentEntity>> getStudentsByCourse(String courseId);
}