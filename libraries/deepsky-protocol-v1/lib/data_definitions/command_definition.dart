import 'package:deepsky_protocol_v1/src/exception.dart';
import 'package:json5/json5.dart';

/// パースできないコマンド定義がある場合の例外
class DPV1InvalidCommandDefinitionException extends DPV1Exception{
  DPV1InvalidCommandDefinitionException(String json5) : super(
    DPV1ErrorCodes.invalidCommandDefinition,
    "cannot parse command definition: $json5",
  );
}

/// Json5で定義されるread/write/notifyコマンド
/// Serviceの中に定義される
class DPV1CommandDefinition{
  /// コマンド名
  final String name;
  /// コマンドタグ
  final int tag;
  /// Notifyコマンドかどうか
  final bool isNotify;

  DPV1CommandDefinition(this.name, this.tag, this.isNotify);

  /// Json5形式の文字列からコマンド定義を生成する
  factory DPV1CommandDefinition.fromJson5(String json5){
    try{
      var obj = JSON5.parse(json5);
      if(obj is! Map<String, dynamic>){
        throw DPV1InvalidCommandDefinitionException(json5);
      }
      return DPV1CommandDefinition.fromDynamic(obj);
    }
    catch(e, stackTrace){
      print(e);
      print(stackTrace);

      throw DPV1InvalidCommandDefinitionException(json5);
    }
  }

  factory DPV1CommandDefinition.fromDynamic(dynamic obj){
    final String name = obj["name"];
    final int tag = obj["tag"] as int;
    final bool isNotify = obj["is_notify"];
    return DPV1CommandDefinition(name, tag, isNotify);
  }
}