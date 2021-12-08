import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:tcf_getit/keys/auth.dart';

class HeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest = request.copyWith(headers: {
      'Authorization': Keys.key,
      'Content-Type': 'application/json'
    });
    return newRequest;
  }
}
