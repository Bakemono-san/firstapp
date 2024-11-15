import 'package:firstapp/src/Providers/ServiceFactory.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:firstapp/src/Services/DependencyContainer.dart';

class DependencyLoader {
  static Future<void> load() async {
    // Load the YAML file
    final String yamlString = await rootBundle.loadString('assets/config.yaml');
    final Map yamlMap = loadYaml(yamlString);

    var dependencies = yamlMap['dependencies'];

    for (var entry in dependencies.entries) {
      final String key = entry.key;
      final String className = entry.value['class'];
      print("className: $className");

      dynamic instance = Servicefactory.getService(className);
      if (instance != null) {
        DependencyContainer.setDependency(key, instance);
      } else {
        print("Failed to load service for: $className");
      }
    }
  }
}