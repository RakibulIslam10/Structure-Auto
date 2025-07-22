#!/bin/bash

echo "📁 Creating Custom API Method..."

BASE_DIR="lib"
mkdir -p "$BASE_DIR/core/api/services"
touch "$BASE_DIR/core/api/services/api_request.dart"

echo "✅ Folder created. Writing Dart code..."

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:starting/core/api/end_point/api_end_points.dart';
import '../../utils/app_storage.dart';
import '../../utils/basic_import.dart';

class ApiRequest {
  /// ✅ POST Request
  static Future<R> post<R>({
    required String endPoint,
    required Map<String, dynamic> body,
    required RxBool isLoading,
    required R Function(Map<String, dynamic>) fromJson,
    bool showSuccessSnackBar = false,
    bool showErrorSnackBar = true,
    Function(String error)? onError,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final headers = await _bearerHeaderInfo();

      log('|📤|---------[ 📦 POST REQUEST STARTED ]---------|📤|');
      log('📍 URL: $endPoint');
      log('📦 BODY: ${jsonEncode(body)}');

      final response = await http
          .post(
            Uri.parse('${ApiEndPoints.baseUrl}/$endPoint'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      log('|📥|---------[ 📒 POST RESPONSE RECEIVED ]---------|📥|');

      log('|✅|---------[ ✅ POST REQUEST COMPLETED ]---------|✅|');

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        final result = fromJson(json);
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: Strings.requestCompletedSuccessfully,
          );
        }

        if (onSuccess != null) onSuccess(result);
        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        if (showErrorSnackBar) CustomSnackBar.error(errorMessage);
        if (onError != null) onError(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      isLoading.value = false;
      final message = e.toString();
      log('🐞🐞🐞 UNHANDLED ERROR: $message');
      if (showErrorSnackBar) CustomSnackBar.error(message);
      if (onError != null) onError(message);
      throw message;
    }
  }

  /// ✅ GET Request
  /// ✅ GET Request
  static Future<T> get<T>({
    required String endPoint,
    required RxBool isLoading,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? queryParams,
    bool showSuccessSnackBar = false,
    bool showErrorSnackBar = true,
    Function(String error)? onError,
    Function(T result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      final headers = await _bearerHeaderInfo();

      log('|🚀🚀🚀|---------[📦📦📦 GET REQUEST STARTED ]---------|🚀🚀🚀|');
      log('📍 URL: $endPoint');
      Uri uri = Uri.parse('${ApiEndPoints.baseUrl}/$endPoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
        log('🔗 With Params: ${uri.toString()}');
      }

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 20));

      log('|📥|---------[ 📗 GET RESPONSE RECEIVED ]---------|📥|');

      log('|✅|---------[ ✅ GET REQUEST COMPLETED ]---------|✅|');

      isLoading.value = false;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final result = fromJson(json);
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: Strings.requestCompletedSuccessfully,
          );
        }

        if (onSuccess != null) onSuccess(result);
        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        if (showErrorSnackBar) CustomSnackBar.error(errorMessage);
        if (onError != null) onError(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      isLoading.value = false;
      final message = e.toString();
      log('🐞🐞🐞 UNHANDLED ERROR: $message');
      if (showErrorSnackBar) CustomSnackBar.error(message);
      if (onError != null) onError(message);
      throw message;
    }
  }

  /// ✅ Header Generator
  static Future<Map<String, String>> _bearerHeaderInfo() async {
    final token = AppStorage.token;
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      if (token.isNotEmpty) HttpHeaders.authorizationHeader: "Bearer $token",
    };
  }
}
EOF

echo "✅ Dart file written to: $BASE_DIR/core/api/services/api_request.dart"
