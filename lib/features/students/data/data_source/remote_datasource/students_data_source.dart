
import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/auth/data/model/student_api_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

import '../i_student_data_source.dart';

class StudentRemoteDataSource implements IStudentDataSource {
  final ApiService _apiService;

  StudentRemoteDataSource({required ApiService apiservice}) : _apiService = apiservice;

  @override
  Future<List<StudentEntity>> getStudentsByBatch(String batchId) async {
    try {
      final response = await _apiService.dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getStudentsByBatch}$batchId',
        options: Options(
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NDY2YjBkZGRiMWJiOTIyYWEwYTRlMyIsImlhdCI6MTc1MDA3NTMyMywiZXhwIjoxNzUyNjY3MzIzfQ.4ihqH-D7FVI5QND-Ehybi_rhHwSLWebl1Qn9qtv4fv0',

          },
        ),

      );

      if (response.statusCode == 201) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => AuthApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception('Failed to load students by batch: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentEntity>> getStudentsByCourse(String courseId) async {
    try {
      final response = await _apiService.dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getStudentsByCourse}$courseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NDY2YjBkZGRiMWJiOTIyYWEwYTRlMyIsImlhdCI6MTc1MDA3NTMyMywiZXhwIjoxNzUyNjY3MzIzfQ.4ihqH-D7FVI5QND-Ehybi_rhHwSLWebl1Qn9qtv4fv0',

          },
        ),
      );

      if (response.statusCode == 201) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => AuthApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception('Failed to load students by course: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
