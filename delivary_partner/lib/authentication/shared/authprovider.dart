import 'package:delivary_partner/authentication/domain/apiservices.dart';
import 'package:delivary_partner/authentication/infra/authcontroller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

final authApiProvider = Provider((ref) => AuthApi(ref: ref));

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthStatus>>(
  (ref) => AuthController(ref),
);