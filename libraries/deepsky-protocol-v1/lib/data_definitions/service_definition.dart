import 'package:deepsky_protocol_v1/data_definitions/command_definition.dart';
import 'package:deepsky_protocol_v1/src/exception.dart';
import 'package:json5/json5.dart';

/// パースできないコマンド定義がある場合の例外
class DPV1InvalidServiceDefinitionException extends DPV1Exception{
  DPV1InvalidServiceDefinitionException(String json5) : super(
    DPV1ErrorCodes.invalidServiceDefinition,
    "cannot parse service definition: $json5",
  );
}

/// Protocol v1 BLE Service定義
class DPV1ServiceDefinition{
  /// サービス名
  final String name;
  /// サービスUUID
  final String uuid;
  /// Write Characteristic UUID
  final String write;
  /// Notify Characteristic UUID
  final String notify;

  /// コマンド定義
  final List<DPV1CommandDefinition> commands;

  DPV1ServiceDefinition(this.name, this.uuid, this.write, this.notify, this.commands);

  /// Json5形式の文字列からサービス定義を生成する
  factory DPV1ServiceDefinition.fromJson5(String json5){
    try{
      var obj = JSON5.parse(json5);
      if(obj is! Map<String, dynamic>){
        throw DPV1InvalidServiceDefinitionException(json5);
      }
      return DPV1ServiceDefinition.fromDynamic(obj);
    }
    catch(e, stackTrace){
      print(e);
      print(stackTrace);

      throw DPV1InvalidServiceDefinitionException(json5);
    }
  }

  /// ダイナミックオブジェクトからコマンド定義を生成する
  factory DPV1ServiceDefinition.fromDynamic(dynamic obj){
    final String name = obj["name"];
    final String uuid = obj["uuid"];
    final String write = obj["write"];
    final String notify = obj["notify"];
    final List<DPV1CommandDefinition> commands = (obj["commands"] as List<dynamic>).map((e) => DPV1CommandDefinition.fromDynamic(e)).toList();
    return DPV1ServiceDefinition(name, uuid, write, notify, commands);
  }
}