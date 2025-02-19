import 'package:deepsky_protocol_v1/data_definitions/service_definition.dart';
import 'package:test/test.dart';

void main(){
  test('ServiceDefinitionでJson5がパースできる', (){
    String json5 = '''
{
  name: "Common",
  uuid: "747B5ADE-3A17-CDC0-D6F2-4B8D10CCFE0C",
  write: "F824EE93-8CCC-EF25-0963-C205898ECB35",
  notify: "3AEF494B-2256-AC39-E15F-D8C97CD4BDAB",
  commands: [
    {
      name: "device-connection-state",
      tag: 0x00,
      is_notify: true,
    },
    {
      name: "key-exchange",
      tag: 0x011,
      is_notify: false,
    },
    {
      name: "setup-ready-state",
      tag: 0x12,
      is_notify: true,
    },
    {
      name: "soft-request",
      tag: 0x14,
      is_notify: false,
    },
    {
      name: "registered-phone-count",
      tag: 0x15,
      is_notify: true,
    },
    {
      name: "send-device-id",
      tag: 0x20,
      is_notify: false,
    },
    {
      name: "install-mode",
      tag: 0xA0,
      is_notify: false,
    },
  ],
}
    ''';
    var def = DPV1ServiceDefinition.fromJson5(json5);
    expect(def.name, "Common");
    expect(def.uuid, "747B5ADE-3A17-CDC0-D6F2-4B8D10CCFE0C");
    expect(def.write, "F824EE93-8CCC-EF25-0963-C205898ECB35");
    expect(def.notify, "3AEF494B-2256-AC39-E15F-D8C97CD4BDAB");
    expect(def.commands.length, 7);
    expect(def.commands[0].name, "device-connection-state");
    expect(def.commands[0].tag, 0x00);
    expect(def.commands[0].isNotify, true);
  });
}