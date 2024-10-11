import 'dart:developer';

class ErrorHandler {
  static showLog(e, stacktrace) {
    log(e.toString(), stackTrace: stacktrace);
  }
}
