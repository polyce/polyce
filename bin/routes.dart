/**
 * Created by lejard_h on 24/12/15.
 */

import "package:polyce/src/utils.dart";
import "polyce.dart";
import "elements.dart" as element;

final String library_path_default = ".";
String library_path = library_path_default;

create(String name, String path,
    {String dartTemplate,
    String htmlTemplate: element.htmldefault,
    String cssTemplate: element.cssdefault,
    bool isDefault: false,
    bool isAbstract,
    String redirectTo,
    String parent,
    bool autonotify: true}) async {
  name = toSnakeCase(name);
  if (dartTemplate == null) {
    dartTemplate = routeDartTemplate(name, "${name}Route", path, isDefault,
        isAbstract: isAbstract, parent: parent, redirectTo: redirectTo, autonotify: autonotify);
  }
  htmlTemplate = element.elementHtmlTemplate("${name}-route", htmlTemplate, cssTemplate);

  await writeInDartFile(
      "lib/${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.dart",
      dartTemplate);
  await writeInFile(
      "lib/${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.html",
      htmlTemplate);

  if (library_path == (options != null ? options.settings["routes"]?.path : null)) {
    addToLibrary("${options.settings["routes"]?.path}/${toSnakeCase(name)}/${toSnakeCase(name)}.dart",
        "lib/${options.settings["routes"]?.library}");
  }
}

_notEmptyButNull(String value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  return '"$value"';
}

routeDartTemplate(String name, String routeName, String path, bool isDefault,
        {bool isAbstract: false, String redirectTo: "", String parent: "", bool autonotify: true}) =>
    '''
      @HtmlImport("${toSnakeCase(name)}.html")
      library route_elements.${toSnakeCase(name)};
      import "dart:html";
      import "package:polyce/polyce.dart";
      @PolyceRoute("${toCamelCase(routeName)}", "$path", isDefault: $isDefault,
      isAbstract: $isAbstract, parent: ${_notEmptyButNull(toCamelCase(parent))}, redirectTo: ${_notEmptyButNull(toCamelCase(redirectTo))})
      @PolymerRegister("${toLispCase(name)}")
      class ${toCamelCase(name)} extends PolymerElement ${ autonotify ? "with AutonotifyBehavior, Observable, PolymerAppRouteBehavior" : "" } {
      ${toCamelCase(name)}.created() : super.created();
      ${element.propertyTemplate("field", String, autonotify)}
      /// Called when an instance of ${toLispCase(name)} is inserted into the DOM.
      attached() {
      super.attached();
      }
      /// Called when an instance of ${toLispCase(name)} is removed from the DOM.
      detached() {
      super.detached();
      }
      /// Called when an attribute (such as  a class) of an instance of ${toLispCase(name)} is added, changed, or removed.
      attributeChanged(String name, String oldValue, String newValue) {
      super.attributeChanged(name, oldValue, newValue);
      }
      /// Called when ${toLispCase(name)} has been fully prepared (Shadow DOM created, property observers set up, event listeners attached).
      ready() {
      }
      /// Called when PolyceRouter enter on ${toLispCase(name)}
      enter(RouteEnterEvent event, [Map params]) {}
      }
      ''';
