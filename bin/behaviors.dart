/**
 * Created by lejard_h on 24/12/15.
 */

import "polyce.dart";
import "utils.dart";
import "elements.dart" as element;

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, {String content, bool autonotify: true}) async {
  name = toSnakeCase(name);
  if (content == null) {
    content = behaviorDartTemplate(name, autonotify: autonotify);
  }
  await writeInDartFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}.dart", content);

  if (library_path == (options != null ? options["behaviors"] : null)) {
    addToLibrary("${toSnakeCase(name)}.dart", "$library_path/behaviors.dart");
  }
}

behaviorDartTemplate(String name, {bool autonotify: true}) => '''
    library elements.${toSnakeCase(name)};
    import "package:polyce/polyce.dart";
    @behavior
    abstract class ${toCamelCase(name)} ${ autonotify ? "implements AutonotifyBehavior, Observable" : "" } {

    ${element.propertyTemplate("field", String, autonotify)}

    /// Called when an instance of ${toCamelCase(name)} is inserted into the DOM.
    static attached(${toCamelCase(name)} instance) {
    }
    /// Called when an instance of ${toCamelCase(name)} is removed from the DOM.
    static detached(${toCamelCase(name)} instance) {
    }
    /// Called when an attribute (such as  a class) of an instance of ${toCamelCase(name)} is added, changed, or removed.
    static attributeChanged(String name, String oldValue, String newValue) {
    }
    /// Called when ${toCamelCase(name)} has been fully prepared (Shadow DOM created, property observers set up, event listeners attached).
    static ready(${toCamelCase(name)} instance) {
    }
    }
    ''';
