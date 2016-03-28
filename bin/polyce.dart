/**
 * Created by lejard_h on 23/03/16.
 */

import 'dart:io';
import 'dart:async';
import "package:args/args.dart";
import "utils.dart";

enum Color { blue, red, yellow, gray, green, white}

int _colorId(Color color) =>
    {Color.blue: 34, Color.red: 31, Color.yellow: 33, Color.gray: 90, Color.green: 32, Color.white: 0}[color];

String _colorize(String input, Color color) {
  return '\u001b[${_colorId(color)}m$input\u001b[39m';
}

void output(String input, Color color) {
  if (Platform.isWindows) stdout.write(input);
  stdout.write(_colorize(input, color));
}

StreamSubscription _progressSubscription;

void _progress() {
  _progressSubscription =
      new Stream.periodic(const Duration(seconds: 1)).listen((_) {
    output('.', Color.white);
  });
}

void _endProgress() {
  _progressSubscription.cancel();
  stdout.write('\n');
}

createApp(String name, bool isMaterial) async {
  name = toSnakeCase(name);
  output('Cloning template repository', Color.green);
  _progress();
  ProcessResult result;
  try {
    result = await Process.run('git', [
      'clone',
      'https://github.com/polyce/app_template${isMaterial ? '_material' : ''}',
      '-bmaster',
      '--single-branch',
      name,
    ]);
  } catch (e) {
    output('\n••• Couldn\'t run git clone', Color.red);
  }

  _endProgress();


  if (result.exitCode != 0) {
    output('${result.stderr}\n', Color.red);
    exit(1);
  }

  Directory.current = name;

  try {
    await new Directory('.git').delete(recursive: true);
  } catch (e) {
    output('$e\n', Color.red);
    exit(1);
  }

  output('Running Pub Get', Color.green);

  _progress();

  try {
    await Process.run('pub', ['get']);
  } catch (e) {
    output('\n••• Couldn\'t run pub get', Color.red);
  }

  _endProgress();

  output('Hint: cd $name && pub serve\n',
      Color.grey);

  return 0;
}

main(List<String> args) async {
  ArgParser parser = new ArgParser()
    ..addCommand(
        "app",
        new ArgParser()
          ..addFlag("material", defaultsTo: true)
          ..addOption("name", defaultsTo: "polyce_app", abbr: "n"))
    ..addCommand("element")
    ..addCommand("service")
    ..addCommand("behavior")
    ..addCommand("model")
    ..addCommand("route");

  ArgResults results = parser.parse(args);

  switch (results?.command?.name) {
    case "app":
      return createApp(results.command['name'], results.command['material']);
  }
}
