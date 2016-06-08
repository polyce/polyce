/**
 * Created by lejard_h on 24/12/15.
 */

import "polyce.dart";
import "package:polyce/src/utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, [String content]) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = serviceDartTemplate(name);
  }
  await writeInDartFile(
      "lib/${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);
  if (library_path == (options != null ? options.settings["services"]?.path : null)) {
    addToLibrary("${options.settings["services"]?.path}/${toSnakeCase(name)}.dart", "lib/${options.settings["services"]?.library}");
  }
}

serviceDartTemplate(String name) => '''
    library services.${toSnakeCase(name)};
        import 'package:polyce/polyce.dart';

        @Service()
        class ${toCamelCase(name)} extends PolyceService {
        HttpService get http => http_service;
        @observable String foo = "bar";

        static ${toCamelCase(name)} _instance;

        ${toCamelCase(name)}._constructor() : super.constructor() {
        }

        factory ${toCamelCase(name)}() {
          if (_instance == null) {
            _instance = new ${toCamelCase(name)}._constructor();
          }
          return _instance;
        }

        @override
initialize() {
}

        }

        final ${toCamelCase(name)} ${toSnakeCase(name)} = new ${toCamelCase(name)}();
        ''';