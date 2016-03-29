/**
 * Created by lejard_h on 24/12/15.
 */

import "utils.dart";

final String library_path_default = "./lib/services";
String library_path = library_path_default;

create(String name, [String content]) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = serviceDartTemplate(name);
  }
  await writeInDartFile("${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);
  if (library_path == library_path_default) {
    addToLibrary("${toSnakeCase(name)}.dart", "$library_path/services.dart");
  }
}

serviceDartTemplate(String name) => '''
    library services.${toSnakeCase(name)};
        import 'package:polyce_app/polyce_app.dart';
        @serializable
        @service
        class ${toCamelCase(name)} extends PolyceService {
        HttpService http = Polyce.getService(HttpService);
        @observable String foo = "bar";
        init() {
        print("init ${toCamelCase(name)}");
        }
        }
        ''';
