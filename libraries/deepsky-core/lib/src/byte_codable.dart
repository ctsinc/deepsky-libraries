import 'dart:typed_data';

/// Encodable interface
abstract class DSByteEncodable{
  /// Encode to byte array
  Uint8List encode();
}

/// Decodable interface
abstract class DSByteDecodable{
  /// Decode from byte array
  void decode(Uint8List bytes);
}

/// DSByteCodable = DSByteEncodable + DSByteDecodable
/// DSByteCodableはbyte配列に変換可能なオブジェクトを表す
abstract class DSByteCodable implements DSByteEncodable, DSByteDecodable {}
