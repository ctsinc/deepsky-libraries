import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';

Builder iconIdGenerator(BuilderOptions options) => DSWIconIdGenerator();

/// assets/iconsのファイル名からアイコンIDを生成する
class DSWIconIdGenerator implements Builder{

  static String _snakeToLowerCamel(String snake) {
    return snake.split('_').asMap().entries.map((entry) {
      int index = entry.key;
      String word = entry.value;
      if (index == 0) {
        return word.toLowerCase();
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join('');
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final iconsDir = Directory('assets/icons');
    if(!iconsDir.existsSync()){
      log.warning("assets/iconsディレクトリが存在しません");
      return;
    }

    final files = iconsDir.listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.svg'))
        .map((file) => file.path.replaceAll(RegExp(r'\\'), '/'))
        .map((file) => file.split('/').last)
        .map((fileName) => fileName.replaceAll('.svg', ''))
        .toSet();

    final output = StringBuffer();
    output.writeln("part of 'icon_id.dart';\n");
    output.writeln("extension DSWIconIdExt on DSWIconId{");
    for(final file in files){
      final variableName = file.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
      output.writeln("  static const DSWIconId ${_snakeToLowerCamel(variableName)} = DSWIconId('$file');");
    }
    output.writeln("}");

    final outputId = AssetId(buildStep.inputId.package, 'lib/icons/icon_id.g.dart');
    await buildStep.writeAsString(outputId, output.toString());
  }

  @override Map<String, List<String>> get buildExtensions => {
    "lib/icons/icon_id.dart": ["lib/icons/icon_id.g.dart"]
  };

}