typedef ErrorCode = int;

/// Deepsky Protocol v1 Exception
abstract class DPV1Exception implements Exception {
  final ErrorCode errorCode;
  final String message;

  DPV1Exception(this.errorCode, this.message);

  @override
  String toString() {
    return 'EDPV1_${errorCode.toString().padLeft(3, "0")}: $message';
  }
}

class DPV1ErrorCodes{
  static const ErrorCode invalidMessage = 011;
  static const ErrorCode invalidCounterLength = 021;

  static const ErrorCode invalidCommandDefinition = 101;
  static const ErrorCode invalidServiceDefinition = 102;
}