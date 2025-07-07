import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/domain/use_case/get_all_course_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockCourseRepository mockCourseRepository; 
  late GetAllCourseUsecase usecase;
  setUp(() {
    mockCourseRepository = MockCourseRepository();
    usecase = GetAllCourseUsecase(courseRepository: mockCourseRepository);
  });
  final course1 = CourseEntity(courseId: '1', courseName: 'Course 1');
  final course2 = CourseEntity(courseId: '2', courseName: 'Course 2');
  final courses = [course1, course2];
  test('get all course usecase ...', () async {
   when(() => mockCourseRepository.getCourses())
        .thenAnswer((_) async => Right(courses));
    
    final result = await usecase();

    // assert
    expect(result, Right(courses));
    verify(() => mockCourseRepository.getCourses()).called(1);
    verifyNoMoreInteractions(mockCourseRepository);
  });
}