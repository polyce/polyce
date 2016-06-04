/**
 * Created by lejard_h on 24/12/15.
 */

import "dart:io";
import "polyce.dart";
import "utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

const String cssdefault = ''':host {
    font-family: 'Roboto', 'Noto', sans-serif;
    font-weight: 300;
    display: block;
    }''';

const String htmldefault =  "<span>{{field}}</span>";

create(String name,
{String dartContent,
    String htmlContent,
    String cssContent: cssdefault,
    String innerHtmlContent: htmldefault,
bool autonotify: true}) async {

  name = toSnakeCase(name);
  if (name == null || !name.contains("_")) {
    name = "${name}_element";
  }

  if (dartContent == null) {
    dartContent = elementDartTemplate(name, autonotify: autonotify);
  }
  if (htmlContent == null) {
    htmlContent = elementHtmlTemplate(name, innerHtmlContent, cssContent);
  }
  await writeInDartFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.dart",
      dartContent);
  await writeInFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.html",
      htmlContent);

  if (library_path == (options != null ? options["elements"] : null)) {
    addToLibrary("${toSnakeCase(name)}/${toSnakeCase(name)}.dart", "$library_path/elements.dart");
  }
}

propertyTemplate(String name, Type type, bool autonotify) {
  name = toCamelCase(name);
  name = name.replaceRange(0, 1, name[0].toLowerCase());

  if (autonotify) {
    return "@observable @property String $name;";
  }
  return '''
    @property $type _$name;
    @reflectable $type get $name => _$name;
    void set $name($type val) {
      _$name = val;
      notifyPath("$name", val);
    }
  ''';
}

elementDartTemplate(String name, {bool autonotify: true}) => '''
    @HtmlImport('${toSnakeCase(name)}.html')
    library elements.${toSnakeCase(name)};
    import 'package:polyce/polyce.dart';
    @PolymerRegister('${toLispCase(name)}')
    class ${toCamelCase(name)} extends PolymerElement ${ autonotify ? "with AutonotifyBehavior, Observable" : ""} {
    ${toCamelCase(name)}.created() : super.created();
    ${propertyTemplate("field", String, autonotify)}
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
    /// Called when ${toLispCase(
    name)} has been fully prepared (Shadow DOM created, property observers set up, event listeners attached).
    ready() {
    }
    }
    ''';

elementHtmlTemplate(String name, [String innerContent = htmldefault, String cssContent = cssdefault]) => '''
    <dom-module id="${toLispCase(name)}">
    <template>
    <style>
      $cssContent
    </style>
    <!-- local DOM for your element -->
    $innerContent
    </template>
    </dom-module>
    ''';

