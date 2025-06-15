import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/auth/data/model/student_api_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/data/data_source/sudent_data_source.dart';

class StudentRemoteDatasource implements IStudentDataSource {
  final ApiService _apiService;

  StudentRemoteDatasource({required ApiService apiservice}) : _apiService = apiservice;

  @override
  Future<void> registerStudent(StudentEntity studentData) async {
    try {
      final model = AuthApiModel.fromEntity(studentData);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: model.toJson(),
      );

      print(response);

      if (response.statusCode == 201) {
        return;
      }
    } on DioException catch (e) {
      throw Exception('Failed to register student: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      final response = await _apiService.dio.post(ApiEndpoints.login, data: {
        "username": username,
        "password": password,
      });
      print(response.data['token']);

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception("Login failed: ${response.statusCode} ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to login: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(String filePath) async {
    print(filePath);
    try {
      final formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiService.dio.post(ApiEndpoints.uploadImage, data: formData);

      if (response.statusCode == 200) {

        return response.data['data'];
      } else {
        throw Exception("Failed to upload image: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload picture: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<StudentEntity> getCurrentUser() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getMe);

      if (response.statusCode == 200) {
        return AuthApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception("Failed to fetch current user: ${response.statusCode} ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch current user: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
