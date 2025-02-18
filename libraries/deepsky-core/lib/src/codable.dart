import 'dart:typed_data';

/// Encodable interface
abstract class DSByteEncodable{
  /// Encode to byte array
  Uint8List encode();
}

/// Decodable interface
abstract class DSByteDecodable{
  /// Decode from byte array
  void decode(Uint8List bytes){
    throw UnimplementedError("subclass must implement this method");
  }
}

/// DSByteCodable = DSByteEncodable + DSByteDecodable
abstract class DSByteCodable implements DSByteEncodable, DSByteDecodable {}
