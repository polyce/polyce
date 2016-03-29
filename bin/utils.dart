/**
 * Created by lejard_h on 23/12/15.
 */

import "dart:io";
import "dart:async";
import "package:dart_style/dart_style.dart";

toSnakeCase(String name) => name
    ?.replaceAll("-", "_")
    ?.replaceAll(" ", "_")
    ?.replaceAllMapped(new RegExp('(?!^)([A-Z])'), (Match g) => "_${g[1]}")
    ?.toLowerCase();

toLispCase(String name) => name
    ?.replaceAll("_", "-")
    ?.replaceAll(" ", "-")
    ?.replaceAllMapped(new RegExp('(?!^)([A-Z])'), (Match g) => "-${g[1]}")
    ?.toLowerCase();

toCamelCase(String str) => toLispCase(str)?.split('-')?.map((e) {
      if (e == null || e.isEmpty) {
        return e;
      }
      return e[0].toUpperCase() + e.substring(1);
    })?.join('');

Future<Directory> createDirectory(String path) async {
  Directory dir = new Directory(path);
  if (!dir.existsSync()) {
    await dir.create(recursive: true);
  }
  if (dir.existsSync()) {
    output("'$path' directory created.\n", Color.green);
  } else {
    output("Fail to create '$path' directory.\n", Color.red);
    throw "Impossible to create directory $path}";
  }
  return dir;
}

Future<File> createFile(String path) async {
  File file = new File(path);
  if (!file.existsSync()) {
    await file.create(recursive: true);
  }
  if (file.existsSync()) {
    output("'$path' file created.\n", Color.green);
  } else {
    output("Fail to create '$path' file.\n", Color.red);
    throw "Impossible to create file $path";
  }
  return file;
}

DartFormatter _formatter = new DartFormatter();

writeInDartFile(String path, String content) async =>
    writeInFile(path, _formatter.format(content));

writeInFile(String path, String content) async {
  File fileDart = await createFile(path);
  await fileDart.writeAsString(content);
  return fileDart;
}

enum Color { blue, red, yellow, gray, green, white }

int _colorId(Color color) => {
      Color.blue: 34,
      Color.red: 31,
      Color.yellow: 33,
      Color.gray: 90,
      Color.green: 32,
      Color.white: 0
    }[color];

String _colorize(String input, Color color) {
  return '\u001b[${_colorId(color)}m$input\u001b[39m';
}

void output(String input, Color color) {
  if (Platform.isWindows) stdout.write(input);
  stdout.write(_colorize(input, color));
}

addToLibrary(String name, [String path = "library.dart"]) {
  //print("Add ${green(name)} to library.\n");
  File lib = new File(path);
  if (!lib.existsSync()) {
    writeInFile(path, "library $name;\n");
  }

  lib.writeAsStringSync(
      "export '$name';\n",
      mode: FileMode.APPEND);
}
