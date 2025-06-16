import 'package:equatable/equatable.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchStudentsByBatch extends StudentsEvent {
  final String batchId;

  const FetchStudentsByBatch(this.batchId);

  @override
  List<Object?> get props => [batchId];
}

class FetchStudentsByCourse extends StudentsEvent {
  final String courseId;

  const FetchStudentsByCourse(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
