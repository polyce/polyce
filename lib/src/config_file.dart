import "dart:io";
import "package:yaml/yaml.dart";
import 'utils.dart';


class ConfigSettings {
  Map<String, dynamic> _yaml;
  final String name;

  ConfigSettings(this.name, this._yaml);

  String get library => _yaml != null ? _yaml["library"] : null;
  String get path => _yaml != null ? _yaml["path"] : null;
}

class ConfigFile {

  String _pathFile;
  File _file;
  Map<String, dynamic> _yaml;

  Map<String, ConfigSettings> _settings;

  ConfigFile.fromYaml(this._pathFile) {
    _file = new File(_pathFile);
    if (_file.existsSync()) {
      _yaml = loadYaml(_file.readAsStringSync()) as Map<String, dynamic>;
    } else {
      output("Can't find '$_pathFile' file\n", Color.gray);
    }
  }

  String get name => _yaml != null ? _yaml["name"] : null;

  Map<String, ConfigSettings> get settings {
    if (_settings == null && _yaml != null && _yaml.containsKey("settings")) {
      _settings = {};
      (_yaml["settings"] as Map<String, Map<String, dynamic>>).forEach((String name, Map<String, dynamic> values) {
        _settings[name] = new ConfigSettings(name, values);
      });
    }
    return _settings ?? {};
  }
}