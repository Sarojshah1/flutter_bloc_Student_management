import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/students/domain/usecases/get_student_by_course.dart';
import 'package:student_management/features/students/domain/usecases/get_students_by_batch.dart';
import 'package:student_management/features/students/domain/usecases/params/student_params.dart';
import 'students_event.dart';
import 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final GetStudentsByBatch getStudentsByBatch;
  final GetStudentsByCourse getStudentsByCourse;

  StudentsBloc({
    required this.getStudentsByBatch,
    required this.getStudentsByCourse,
  }) : super(StudentsInitial()) {
    on<FetchStudentsByBatch>(_onFetchStudentsByBatch);
    on<FetchStudentsByCourse>(_onFetchStudentsByCourse);
  }

  Future<void> _onFetchStudentsByBatch(
      FetchStudentsByBatch event,
      Emitter<StudentsState> emit,
      ) async {
    emit(StudentsLoading());
    final result = await getStudentsByBatch(BatchIdParam(event.batchId));
    result.fold(
          (failure) => emit(StudentsError(failure.message)),
          (students) => emit(StudentsLoaded(students)),
    );
  }

  Future<void> _onFetchStudentsByCourse(
      FetchStudentsByCourse event,
      Emitter<StudentsState> emit,
      ) async {
    emit(StudentsLoading());
    final result = await getStudentsByCourse(CourseIdParam(event.courseId));
    print(result);
    result.fold(
          (failure) => emit(StudentsError(failure.message)),
          (students) => emit(StudentsLoaded(students)),
    );
  }
}
