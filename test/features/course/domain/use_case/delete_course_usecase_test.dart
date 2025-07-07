import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockCourseRepository mockCourseRepository;
  late DeleteCourseUsecase usecase;
  setUp(() {
    mockCourseRepository = MockCourseRepository();
    usecase = DeleteCourseUsecase(courseRepository: mockCourseRepository);
  });
  test('delete course usecase ...', () async {
   when(() => mockCourseRepository.deleteCourse('courseId123'))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(DeleteCourseParams(id: 'courseId123'));

    // assert
    expect(result, const Right(null));
    verify(() => mockCourseRepository.deleteCourse('courseId123')).called(1);
    verifyNoMoreInteractions(mockCourseRepository);
  });
}