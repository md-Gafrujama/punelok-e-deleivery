import 'package:delivary_partner/core/network/api_endpoints.dart';
import 'package:delivary_partner/core/shared/dio_client_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthApi {
 final Ref ref;

    AuthApi({required this.ref});
  Future<void> requestOtp(String phone) async {
  try {
    await ref.read(dioClientProvider).post(
     ' ${APIEndpoints.sendotp}',
      // APIEndpoints.BaseUrl
      // '/send-otp',
      data: {"phoneNumber": phone},
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    // 👈 OTP will print here if server returns it
  } on DioException {
    rethrow;
  }
}
Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
  try {
    final response = await ref.read(dioClientProvider).post(
      ' ${APIEndpoints.verifyotp}',
      // "/verify-otp",
      data: {"phoneNumber": phone, "otp": otp},
      options: Options(
        validateStatus: (status) => status != null && status < 500,
      ),
    );

   

    final statusOk = response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;

    // ✅ ALSO check message — server may return 200 for failures
    final message = response.data['message']?.toString().toLowerCase() ?? '';
    final messageOk = message.contains('success') || 
                      message.contains('verified') ||
                      message.contains('login');

    final isSuccess = statusOk && messageOk; // 👈 both must be true

    return {
      'success': isSuccess,
      'message': isSuccess ? 'OTP verified' : (response.data['message'] ?? 'Invalid OTP'),
      ...Map<String, dynamic>.from(response.data),
    };
  } on DioException catch (e) {
    return {
      'success': false,
      'message': e.response?.data?['message'] ?? 'Invalid OTP',
    };
  }
}
}
