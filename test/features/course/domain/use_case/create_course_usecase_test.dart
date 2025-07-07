import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockCourseRepository mockCourseRepository;
  late CreateCourseUsecase usecase;
  setUp(() {
    mockCourseRepository = MockCourseRepository();
    usecase = CreateCourseUsecase(courseRepository: mockCourseRepository);
    registerFallbackValue(CourseEntity.empty());
  });
  test('create course usecase ...', () async {
    when(() => mockCourseRepository.createCourse(any()))
        .thenAnswer((_) async => const Right(null));

        final params = CreateCourseParams(courseName: 'Test Course');
    final result = await usecase(params);

    // assert
    expect(result, const Right(null));
    verify(() => mockCourseRepository.createCourse(any())).called(1);
    verifyNoMoreInteractions(mockCourseRepository);
  });

 
}