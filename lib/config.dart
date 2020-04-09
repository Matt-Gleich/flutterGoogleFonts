import 'dart:io';

import 'package:console/console.dart';
import 'package:flutter_google_fonts/status.dart';
import 'package:yaml/yaml.dart';

class Config {
  static Map read({fileName = 'pubspec.yaml'}) {
    Console.write('📄 Reading Config ');
    var readTimer = TimeDisplay();
    readTimer.start();

    final file = File(fileName);
    String yamlString;
    try {
      yamlString = file.readAsStringSync();
    } on FileSystemException {
      Status.error('No ./$fileName found');
    }
    final yamlMap = loadYaml(yamlString);

    if (yamlMap == null || !(yamlMap['google_fonts'] is Map)) {
      Status.error('No config found in pubspec');
    }

    readTimer.stop();
    Status.success('Successfully read config');
    return yamlMap['google_fonts'] as Map;
  }
}
