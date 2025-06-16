import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/features/students/presentation/view_model/students_bloc.dart';
import 'package:student_management/features/students/presentation/view_model/students_event.dart';
import 'package:student_management/features/students/presentation/view_model/students_state.dart';

import '../../../auth/domain/entity/student_entity.dart';

class ShowStudents extends StatelessWidget {
  final String batchId;
  final String courseId;

  const ShowStudents({
    super.key,
    required this.batchId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    context.read<StudentsBloc>().add(FetchStudentsByBatch(batchId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.school),
            tooltip: 'Load By Batch',
            onPressed: () {
              context.read<StudentsBloc>().add(FetchStudentsByBatch(batchId));
            },
          ),
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'Load By Course',
            onPressed: () {
              context.read<StudentsBloc>().add(FetchStudentsByCourse(courseId));
            },
          ),
        ],
      ),
      body: BlocBuilder<StudentsBloc, StudentsState>(
        builder: (context, state) {
          if (state is StudentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentsLoaded) {
            final students = state.students;
            if (students.isEmpty) {
              return const Center(child: Text('No students found.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: students.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final StudentEntity student = students[index];
                final imageUrl = student.image != null && student.image!.isNotEmpty
                    ? "${ApiEndpoints.imageUrl}/${student.image}"
                    : 'https://via.placeholder.com/150';

                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(imageUrl),
                  ),
                  title: Text("${student.fName} ${student.lName}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("ID: ${student.userId ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
                      Text("Phone: ${student.phone ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
                      Text("Batch: ${student.batch.batchName}", style: const TextStyle(fontSize: 12)),
                      Text(
                        "Courses: ${student.courses.map((e) => e.courseName).join(', ')}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                );
              },
            );
          } else if (state is StudentsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is StudentsInitial) {
            return const Center(child: Text('Please select an option to load students.'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
