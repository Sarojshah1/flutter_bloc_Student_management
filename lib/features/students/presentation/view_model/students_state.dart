import 'package:equatable/equatable.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object?> get props => [];
}

class StudentsInitial extends StudentsState {}

class StudentsLoading extends StudentsState {}

class StudentsLoaded extends StudentsState {
  final List<StudentEntity> students;

  const StudentsLoaded(this.students);

  @override
  List<Object?> get props => [students];
}

class StudentsError extends StudentsState {
  final String message;

  const StudentsError(this.message);

  @override
  List<Object?> get props => [message];
}
