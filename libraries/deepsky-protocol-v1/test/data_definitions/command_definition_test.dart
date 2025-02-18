import 'package:deepsky_protocol_v1/data_definitions/command_definition.dart';
import 'package:test/test.dart';

void main(){
  test('CommandDefinitionでjson5がパースできる', (){
    String json5 = '''
    {
      name: "device-connection-state",
      tag: 0xa0,
      is_notify: true,
    }
    ''';
    var def = DPV1CommandDefinition.fromJson5(json5);
    expect(def.name, "device-connection-state");
    expect(def.tag, 0xa0);
    expect(def.isNotify, true);
  });
}