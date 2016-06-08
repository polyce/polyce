/**
 * Created by lejard_h on 24/12/15.
 */

import "package:polyce/src/utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, {String content}) async {
  name = toSnakeCase(name);
  String lib = "";
  if (library_path == (options != null ? options.settings["models"].path : null)) {
    lib = "lib/";
  }
  if (content == null) {
    content = modelDartTemplate(name);
  }
  await writeInDartFile(
      "$lib${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);

  if (lib == "lib/") {
    addToLibrary("${options.settings["models"]?.path}/${toSnakeCase(name)}.dart", "$lib${options.settings["models"]?.library}");
    buildModel();
  }
}

modelDartTemplate(String name) => '''
      library ${options?.name != null ? '${options.name}.' : ''}models.${toSnakeCase(name)};
      import "package:polyce/polyce.dart";
      ${ options?.name != null ? "import 'package:${options?.name}/convert.dart';" : ""}
      class ${toCamelCase(name)} extends PolyceModel {

      @observable String foo;

      ${toCamelCase(name)}();

      @override
      Map<dynamic, dynamic> encode() =>  new ${toCamelCase(name)}Encoder().convert(this);

      factory ${toCamelCase(name)}.decode(Map<dynamic, dynamic> data) => new ${toCamelCase(name)}Decoder().convert(data);

      }
      ''';
