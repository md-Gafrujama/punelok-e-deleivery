import 'package:delivary_partner/authentication/shared/authprovider.dart';
import 'package:delivary_partner/core/infra/secured_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

enum AuthStatus {
  initial,
  otpSent,
  verified,
}
class AuthController extends StateNotifier<AsyncValue<AuthStatus>> {
  final Ref ref;

  AuthController(this.ref) : super(const AsyncData(AuthStatus.initial));
//requesting for send otp
  Future<void> requestOtp(String phone) async {
    state = const AsyncData(AuthStatus.initial); // 👈 force reset so listener fires again on retry
    state = const AsyncLoading();
    try {
      await ref.read(authApiProvider).requestOtp(phone);
      state = const AsyncData(AuthStatus.otpSent);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
 //verify otp 
Future<void> verifyOtp(String phone, String otp) async {
  state = const AsyncData(AuthStatus.initial);
  state = const AsyncLoading();
  try {
    final data = await ref.read(authApiProvider).verifyOtp(phone, otp);
    
    // 👈 prints OTP token from backend

    if (data['success'] == true) {
      final token = data['accessToken'] as String?;
      if (token != null) {
        await SecureStorageService.saveToken(token);
      }
      state = const AsyncData(AuthStatus.verified);
    } else {
      state = AsyncError(
        Exception(data['message'] ?? 'Invalid OTP'),
        StackTrace.current,
      );
    }
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}
//logout 
Future<void> logout() async {
  await SecureStorageService.deleteToken();
  state = const AsyncData(AuthStatus.initial);
}

}