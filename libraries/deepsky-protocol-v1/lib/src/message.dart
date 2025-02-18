import 'dart:typed_data';

import 'package:deepsky_core/deepsky_core.dart';
import 'package:deepsky_protocol_v1/src/exception.dart';

import 'packet.dart';

class DPV1InvalidMessageException extends DPV1Exception{
  DPV1InvalidMessageException() : super(
    DPV1ErrorCodes.invalidMessage,
    "cannot parse message"
  );
}

/// Deepsky Protocol v1 Message
/// メッセージはパケットの集合
class DPV1Message implements DSByteCodable{
  /// パケットリスト
  List<DPV1Packet> packets;

  /// パケットリストからメッセージを生成する
  DPV1Message(this.packets);

  /// バイト列
  Uint8List get raw{
    return packets.map((p) => p.raw).fold(Uint8List(0), (a, b) => Uint8List.fromList(a + b));
  }

  /// パケットリストからバイト列を生成する
  factory DPV1Message.fromPackets(List<DPV1Packet> packets){
    return DPV1Message(packets);
  }

  /// バイト列からメッセージを生成する
  factory DPV1Message.fromBytes(Uint8List bytes){
    DPV1Message result = DPV1Message([]);
    result.decode(bytes);
    return result;
  }

  /// バイト列からデコードする
  @override void decode(Uint8List bytes) {
    final packets = <DPV1Packet>[];
    int offset = 0;
    while(offset < bytes.length){
      final int length = bytes[offset + 1];
      //  長さが足りない場合は不正
      if(offset + 2 + length > bytes.length){
        throw DPV1InvalidMessageException();
      }
      final packet = DPV1Packet(bytes.sublist(offset, offset + 2 + length));
      packets.add(packet);
      offset += 2 + length;
    }
    this.packets = packets;
  }

  /// エンコードする
  @override Uint8List encode() {
    return raw;
  }
}