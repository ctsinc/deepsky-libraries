import 'dart:math';
import 'dart:typed_data';

import 'package:deepsky_core/deepsky_core.dart';
import 'package:deepsky_protocol_v1/src/exception.dart';

/// バイト列からカウンターをパースする際に長さが期待したものではない
class DPV1InvalidCounterLengthException extends DPV1Exception{
  final int expectedLength;
  final int actualLength;
  DPV1InvalidCounterLengthException(this.expectedLength, this.actualLength) : super(
    DPV1ErrorCodes.invalidCounterLength,
    "Invalid counter length: expected $expectedLength, actual $actualLength"
  );
}

/// Deepsky Protocol v1 Counter
/// カウンター実体は整数
/// 4byteとの相互変換を行う
/// (mutable)
class DPV1Counter extends DSByteCodable{
  /// カウンター
  int counter;

  DPV1Counter(this.counter);

  /// バイト列
  Uint8List get bytes => encode();

  /// カウンターをインクリメントする
  void increment(){
    counter++;
  }

  /// バイト列からカウンターをデコードする
  @override void decode(Uint8List bytes) {
    if(bytes.length != 4){
      throw DPV1InvalidCounterLengthException(4, bytes.length);
    }
    counter = ByteData.view(bytes.buffer).getUint32(0);
  }

  /// カウンターをバイト列にエンコードする
  @override Uint8List encode() {
    final byteData = ByteData(4);
    byteData.setUint32(0, counter);
    return byteData.buffer.asUint8List();
  }

  /// バイト列からカウンターを生成する
  factory DPV1Counter.fromBytes(Uint8List bytes){
    final counter = DPV1Counter(0);
    counter.decode(bytes);
    return counter;
  }

  /// ランダムな初期カウンターを生成する
  factory DPV1Counter.generateRandom(){
    Random rng = Random.secure();
    Uint8List raw = Uint8List.fromList([
      0x00,
      rng.nextInt(16),
      rng.nextInt(16),
      rng.nextInt(16),
    ]);
    return DPV1Counter.fromBytes(raw);
  }

}