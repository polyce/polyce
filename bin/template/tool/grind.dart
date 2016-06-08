import 'dart:async';
import "package:polyce/src/config_file.dart";
import "package:polyce/src/utils.dart";
import 'package:grinder/grinder.dart';

ConfigFile options = new ConfigFile.fromYaml("polyce.settings.yaml");

main(List<String> args) => grind(args);

@Task("Generate Model Decoder")
codegen() {
  buildModel();
}
