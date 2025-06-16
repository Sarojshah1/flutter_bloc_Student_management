import 'package:equatable/equatable.dart';

class BatchIdParam extends Equatable {
  final String batchId;

  const BatchIdParam(this.batchId);

  @override
  List<Object> get props => [batchId];
}

class CourseIdParam extends Equatable {
  final String courseId;

  const CourseIdParam(this.courseId);

  @override
  List<Object> get props => [courseId];
}
