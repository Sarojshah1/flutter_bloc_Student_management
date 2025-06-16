import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/app/service_locator/service_locator.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';
import 'package:student_management/features/students/presentation/view_model/students_event.dart';

import '../../../../students/presentation/view/show_students.dart';
import '../../../../students/presentation/view_model/students_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => serviceLocator<CourseViewModel>(),
        // child: const _DashboardContent(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BatchViewModel>(),
        // child: const _DashboardContent(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<StudentsBloc>(),
        child: const DashboardView(),
      )
    ], child: _DashboardContent());
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Courses",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<CourseViewModel, CourseState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                }
                if (state.courses.isEmpty) {
                  return const Center(
                    child: Text('No courses available', style: TextStyle(fontSize: 16)),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: state.courses.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return InkWell(
                        onTap: () {
                          final courseId = course.courseId ?? '';
                          if (courseId.isNotEmpty) {
                            final studentsBloc = context.read<StudentsBloc>();
                            studentsBloc.add(FetchStudentsByCourse(courseId));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: studentsBloc,
                                  child: ShowStudents(batchId: '', courseId: courseId,),
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.courseName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  course.courseId ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Batches",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<BatchViewModel, BatchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                }
                if (state.batches.isEmpty) {
                  return const Center(
                    child: Text('No Batches available', style: TextStyle(fontSize: 16)),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: state.batches.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      final batch = state.batches[index];
                      return InkWell(
                        onTap: () {
                          final batchId = batch.batchId ?? '';
                          if (batchId.isNotEmpty) {
                            final studentsBloc = context.read<StudentsBloc>();
                            studentsBloc.add(FetchStudentsByBatch(batchId));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: studentsBloc,
                                  child: ShowStudents(batchId: batchId, courseId:"",),
                                ),
                              ),
                            );
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  batch.batchName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  batch.batchId ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
