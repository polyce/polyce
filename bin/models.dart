/**
 * Created by lejard_h on 24/12/15.
 */

import "polyce.dart";
import "utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, {String content}) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = modelDartTemplate(name);
  }
  await writeInDartFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);

  if (library_path == (options != null ? options["models"] : null)) {
    addToLibrary("${toSnakeCase(name)}.dart", "$library_path/models.dart");
  }
}

modelDartTemplate(String name) => '''
      library models.${toSnakeCase(name)};
      import "package:polyce_app/polyce_app.dart";
      /// @serializable specify that ${toCamelCase(name)} can be serialize/deserialize by polymer_app
      @serializable
      class ${toCamelCase(name)} extends PolyceModel {
      @observable String bar;
      /// The Serializer need to have an empty constructor on the class or a contructor with optionnal value
      ${toCamelCase(name)}([this.bar]);
      ${toCamelCase(name)}.foo(this.bar);
      }
      ''';
