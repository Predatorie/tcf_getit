import 'dart:async';

import 'package:chopper/chopper.dart';

import '../../keys/auth.dart';

class AuthInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    return chain.proceed(applyHeader(chain.request, 'Authorization', Keys.key));
  }
}
