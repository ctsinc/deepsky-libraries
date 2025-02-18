import 'dart:typed_data';

import 'codable.dart';

/// Deepsky Protocol v1 Packet
/// [
/// tag 1 byte
/// length 1 byte
/// payload 0-n bytes
/// ]
class DPV1Packet implements DSByteCodable{
  /// バイト列
  Uint8List raw;

  /// タグ
  int get tag => raw[0];

  /// データ長
  int get length => raw[1];

  /// ペイロード
  Uint8List get payload => raw.sublist(2);

  /// バイト列からパケットを生成する
  DPV1Packet(this.raw);

  /// バイト列からパケットを生成する
  factory DPV1Packet.fromBytes(Uint8List bytes){
    return DPV1Packet(bytes);
  }

  /// タグとpayloadを指定してパケットを生成する
  factory DPV1Packet.fromPayload(int tag, Uint8List payload){
    final length = payload.length;
    final raw = Uint8List(2 + length);
    raw[0] = tag;
    raw[1] = length;
    raw.setRange(2, 2 + length, payload);
    return DPV1Packet(raw);
  }

  /// バイト列からデコードする
  @override void decode(Uint8List bytes) {
    raw = bytes;
  }

  /// エンコードする
  @override Uint8List encode() {
    return raw;
  }
}