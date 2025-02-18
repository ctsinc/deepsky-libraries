import 'package:deepsky_core/deepsky_core.dart';

import 'auth.dart';

typedef ConnectionId = DSStringEncodable;

/// 鍵交換機能を提供するために必要な機能を実装するためのインターフェース
abstract class DPV1KeyExchangeFeatureProvider{
  /// 鍵交換対象が通信可能状態になるまで待機する
  Future waitForCommunicationReady(ConnectionId connectionId, Duration timeout);

  /// 鍵交換対象デバイスに対して鍵交換モードを要求し、セットアップモードになるまで待機する
  Future requestRemoteSetup(ConnectionId connectionId, Duration timeout);

  /// 鍵交換後にセキュア通信が確立されているか確認する
  /// 確立されていない場合は例外をスローする
  Future verifySecureCommunication(ConnectionId connectionId);
}

/// 鍵交換を実施するためのエージェント
class DPV1KeyExchangeAgent{
  /// 鍵交換機能を提供するための機能プロバイダ
  final DPV1KeyExchangeFeatureProvider featureProvider;
  /// セキュリティ機能を提供するためのプロバイダ
  final DPV1SecurityProvider securityProvider;

  DPV1KeyExchangeAgent({required this.featureProvider, required this.securityProvider});

  
}