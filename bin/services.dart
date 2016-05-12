/**
 * Created by lejard_h on 24/12/15.
 */

import "polyce.dart";
import "utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, [String content]) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = serviceDartTemplate(name);
  }
  await writeInDartFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);
  if (library_path == (options != null ? options["services"] : null)) {
    addToLibrary("${toSnakeCase(name)}.dart", "$library_path/services.dart");
  }
}

serviceDartTemplate(String name) => '''
    library services.${toSnakeCase(name)};
        import 'package:polyce/polyce.dart';
        @serializable
        class ${toCamelCase(name)} extends PolyceService {
        HttpService get http => Polyce.http_service;
        @observable String foo = "bar";

        static ${toCamelCase(name)} _instance;

        ${toCamelCase(name)}._constructor() : super._constructor();

        factory ${toCamelCase(name)}() {
          if (_instance == null) {
            _instance = new ${toCamelCase(name)}._init();
          }
          return _instance;
        }

        initialize() {

        }

        }

        final ${toCamelCase(name)} ${toSnakeCase(name)} = new ${toCamelCase(name)}();
        ''';
