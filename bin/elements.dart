/**
 * Created by lejard_h on 24/12/15.
 */

import "polyce.dart";
import "utils.dart";

final String library_path_default = ".";
String library_path = library_path_default;

create(String name,
    [String dartContent,
    String htmlContent,
    String cssContent = cssdefault,
    String innerHtmlContent = ""]) async {

  name = toSnakeCase(name);
  if (name == null || !name.contains("_")) {
    throw "The element name is invalid";
  }

  if (dartContent == null) {
    dartContent = elementDartTemplate(name);
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

elementDartTemplate(String name) => '''
    @HtmlImport('${toSnakeCase(name)}.html')
    library elements.${toSnakeCase(name)};
    import 'package:polyce/polyce.dart';
    @PolymerRegister('${toLispCase(name)}')
    class ${toCamelCase(name)} extends PolymerElement with AutonotifyBehavior, Observable {
    ${toCamelCase(name)}.created() : super.created();
    @observable @property String field;
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

elementHtmlTemplate(String name, [String innerContent = "", String cssContent = cssdefault]) => '''
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

const String cssdefault =  '''
  :host {
    font-family: 'Roboto', 'Noto', sans-serif;
    font-weight: 300;
    display: block;
    }
    ''';
