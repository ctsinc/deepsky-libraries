import 'package:deepsky_core/deepsky_core.dart';
import 'package:deepsky_protocol_v1/deepsky_protocol_v1.dart';
import 'package:deepsky_protocol_v1/src/counter.dart';
import 'package:deepsky_protocol_v1/src/packet.dart';

/// キーペアを一意に識別するためのハンドラ
abstract class DPV1KeyPairHandler{
  String get identifier;
}

/// ローカルで生成されたキー
class DPV1LocalGeneratedKey{
  final DPV1KeyPairHandler keyPairHandler;
  final DSByteEncodable publicKey;

  DPV1LocalGeneratedKey(this.keyPairHandler, this.publicKey);
}

/// 共通鍵を一意に識別するためのハンドラ
abstract class DPV1SharedKeyIdentifier{
  String get identifier;
}

/// Protocol v1 セキュア通信のために実装すべきインターフェース
abstract class DPV1SecurityProvider{

  /// ECDH-Hellman 楕円鍵暗号方式でキーペアを生成する
  /// 曲線: secp256r1 (NIST P-256)
  Future<DPV1LocalGeneratedKey> generateKeyPair();

  /// 共通鍵を生成する
  /// [keyIdentifier] キー識別子
  /// [keyPairHandler] generateKeyPairで生成した鍵を特定するためのキーペアハンドラ
  /// [remotePublicKey] 相手の公開鍵
  Future agreement(DPV1SharedKeyIdentifier keyIdentifier, DPV1KeyPairHandler keyPairHandler, DSByteEncodable remotePublicKey);

  /// 認証パケットを生成する
  /// [message] 認証対象のメッセージ
  /// [keyIdentifier] キー識別子
  /// [counter] カウンター
  ///
  /// 1. messageの前に乱数、カウンタを付加して [乱数(2byte), カウンタ(4byte), message] とする
  /// 2. 1.のデータのHMACを生成する (HMAC-SHA256) 共通鍵はkeyIdentifierによって取得する
  /// 3. 2.で得られた32byteの上位6byteをpayloadとしてパケットを生成する
  Future<DPV1Packet> generateAuthPacket(DPV1Message message, DPV1SharedKeyIdentifier keyIdentifier, DPV1Counter counter);

  /// 共通鍵を削除する
  /// [keyIdentifier] 削除対象のキー識別子
  Future removeSharedKey(DPV1SharedKeyIdentifier keyIdentifier);
}