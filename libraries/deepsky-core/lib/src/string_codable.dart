/// Stringに変換可能なオブジェクトのためのインターフェース
abstract class DSStringEncodable{
  /// Encode to string
  String encode();
}

/// Stringから変換可能なオブジェクトのためのインターフェース
abstract class DSStringDecodable{
  /// Decode from string
  void decode(String string);
}

/// DSStringCodable = DSStringEncodable + DSStringDecodable
abstract class DSStringCodable implements DSStringEncodable, DSStringDecodable {}