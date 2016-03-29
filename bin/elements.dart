/**
 * Created by lejard_h on 24/12/15.
 */

import "utils.dart";

final String library_path_default = "./lib/elements";
String library_path = library_path_default;

create(String name,
    [String dartContent,
    String htmlContent,
    String cssContent,
    String innerHtmlContent = ""]) async {

  name = toSnakeCase(name);
  if (name == null || !name.contains("_")) {
    throw "The element name is invalid";
  }

  if (dartContent == null) {
    dartContent = elementDartTemplate(name);
  }
  if (htmlContent == null) {
    htmlContent = elementHtmlTemplate(name, innerHtmlContent);
  }
  if (cssContent == null) {
    cssContent = elementCssTemplate(name);
  }
  await writeInDartFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.dart",
      dartContent);
  await writeInFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.html",
      htmlContent);
  await writeInFile(
      "${toSnakeCase(library_path)}/${toSnakeCase(name)}/${toSnakeCase(name)}.css",
      cssContent);

  if (library_path == library_path_default) {
    addToLibrary("${toSnakeCase(name)}/${toSnakeCase(name)}.dart", "$library_path/elements.dart");
  }
}

elementDartTemplate(String name) => '''
    @HtmlImport('${toSnakeCase(name)}.html')
    library elements.${toSnakeCase(name)};
    import 'package:polyce_app/polyce_app.dart';
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

elementHtmlTemplate(String name, [String innerContent = ""]) => '''
    <dom-module id="${toLispCase(name)}">
    <link rel="import" type="css" href="${toSnakeCase(name)}.css">
    <template>
    <!-- local DOM for your element -->
    $innerContent
    </template>
    </dom-module>
    ''';

elementCssTemplate(String name) => '''
  :host {
    font-family: 'Roboto', 'Noto', sans-serif;
    font-weight: 300;
    display: block;
    }
    ''';
