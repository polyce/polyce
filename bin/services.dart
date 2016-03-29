/**
 * Created by lejard_h on 24/12/15.
 */

import "utils.dart";

final String service_library_path_default = "./lib/services";
String service_library_path = service_library_path_default;

create(String name, [String content]) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = serviceDartTemplate(name);
  }
  await writeInDartFile(
      "$service_library_path/${toSnakeCase(name)}.dart", content);
  if (service_library_path == service_library_path_default) {
    addToLibrary("${toSnakeCase(name)}.dart", "$service_library_path/services.dart");
  }
}

serviceDartTemplate(String name) => '''
    library services.${toSnakeCase(name)};
        import '../polyce_app.dart';
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
