import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../modal/TodoTask.dart';

class ApiProvider {
  final String baseUrl = "https://api.mohamed-sadek.com";
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.mohamed-sadek.com',
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  ApiProvider() {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120,
    ));
  }

  // إضافة التوكن في الهيدر إذا كان موجودًا
  Future<void> _addAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      _dio.options.headers['token'] = token;
    } else {
      _dio.options.headers.remove('token');
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      _dio.options.headers.remove('token');

      final response = await _dio.post(
        '/User/Login',
        data: {'UserName': email, 'Password': password},
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['Data'] != null) {
        final token = response.data['Data'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        _dio.options.headers['token'] = token;
        return token;
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('بيانات تسجيل الدخول غير صحيحة');
      }
      throw Exception('فشل تسجيل الدخول: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Logout token: $token');

      if (token != null && token.isNotEmpty) {
        final response = await _dio.post(
          '/User/Logout',
          options: Options(
            headers: {
              'token': token,
              'accept': 'text/plain',
            },
          ),
        );
        print('Logout response: ${response.statusCode} - ${response.data}');
      } else {
        print('No token found for logout.');
      }

      await prefs.remove('token');
      _dio.options.headers.remove('token');
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
        });
        _dio.options.headers.remove('token');
        print('Logout handled as successful despite 401.');
        return true;
      }
      print('Logout DioException: ${e.message}');
      return false;
    } catch (e) {
      _dio.options.headers.remove('token');
      print('Logout error: $e');
      return false;
    }
  }

  Future<bool> signUp(String email, String name, String password) async {
    try {
      final response = await _dio.post(
        '/User/POST',
        data: {
          'UserName': email,
          'Name': name,
          'Password': password,
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  Future<List<ToDo>> getTasks() async {
    try {
      await _addAuthHeader();
      final response = await _dio.get('/Task/GetAuthorized');

      if (response.statusCode == 200 && response.data != null) {
        final todoTask = TodoTask.fromJson(response.data);
        return todoTask.data ?? [];
      }

      return [];
    } catch (e) {
      throw Exception('Failed to fetch tasks: ${e.toString()}');
    }
  }

  Future<bool> createTask(String todoText) async {
    try {
      await _addAuthHeader();
      final response = await _dio.post(
        '/Task/POST',
        data: {
          'Title': todoText,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to create task: ${e.toString()}');
    }
  }

  Future<bool> updateTask(String id, bool isDone, String todoText) async {
    try {
      await _addAuthHeader();
      final response = await _dio.put(
        '/Task/PUT',
        data: {'id': id, 'isDone': isDone, 'Title': todoText},
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update task: ${e.toString()}');
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await _addAuthHeader();
      final response = await _dio.delete(
        '/Task/Delete',
        queryParameters: {'id': id},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception('Failed to delete task: ${e.toString()}');
    }
  }
}
