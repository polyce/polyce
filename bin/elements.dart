/**
 * Created by lejard_h on 24/12/15.
 */

import "utils.dart";

String elements_library_path = "./lib/elements";

create(String name,
    [String dartContent,
    String htmlContent,
    String cssContent,
    String innerHtmlContent = ""]) async {

  name = toSnakeCase(name);
  print(name);
  if (name == null || !name.contains("_")) {
    throw "The element name is invalid";
  }

  if (dartContent == null) {
    dartContent = _elementDartTemplate(name);
  }
  if (htmlContent == null) {
    htmlContent = _elementHtmlTemplate(name, innerHtmlContent);
  }
  if (cssContent == null) {
    cssContent = _elementCssTemplate(name);
  }
  await writeInDartFile(
      "$elements_library_path/${toSnakeCase(name)}/${toSnakeCase(name)}.dart",
      dartContent);
  await writeInFile(
      "$elements_library_path/${toSnakeCase(name)}/${toSnakeCase(name)}.html",
      htmlContent);
  await writeInFile(
      "$elements_library_path/${toSnakeCase(name)}/${toSnakeCase(name)}.css",
      cssContent);

  addToLibrary(name, "$elements_library_path/elements.dart");
}

_elementDartTemplate(String name) => '''
    @HtmlImport('${toSnakeCase(name)}.html')
    library elements.${toSnakeCase(name)};
    import '../../polyce_app.dart';
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

_elementHtmlTemplate(String name, [String innerContent = ""]) => '''
    <dom-module id="${toLispCase(name)}">
    <link rel="import" type="css" href="${toSnakeCase(name)}.css">
    <template>
    <!-- local DOM for your element -->
    $innerContent
    </template>
    </dom-module>
    ''';

_elementCssTemplate(String name) => '''
  :host {
    font-family: 'Roboto', 'Noto', sans-serif;
    font-weight: 300;
    display: block;
    }
    ''';
