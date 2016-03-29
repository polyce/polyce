/**
 * Created by lejard_h on 23/03/16.
 */

import 'dart:io';
import 'dart:async';
import "dart:convert";
import "package:args/args.dart";
import "utils.dart";

import "elements.dart" as element;
import "services.dart" as service;
import "behaviors.dart" as behavior;
import "models.dart" as model;
import "routes.dart" as route;

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

  output('Hint: cd $name && pub serve\n', Color.gray);

  return 0;
}

initOptions() {
  File options_file = new File("app.options.json");
  if (options_file.existsSync()) {
    options = JSON.decode(options_file.readAsStringSync());
  } else {
    output("Can't find 'app.options.json' file\n", Color.gray);
  }
}

main(List<String> args) async {
  initOptions();
  ArgParser parser = new ArgParser()
    ..addCommand(
        "app",
        new ArgParser()
          ..addFlag("material",
              defaultsTo: true,
              help: "Generate a Material Design Application",
              negatable: true))
    ..addCommand(
        "element",
        new ArgParser()
          ..addOption("path",
              abbr: "p",
              defaultsTo: options != null
                  ? options["elements"]
                  : element.library_path_default))
    ..addCommand(
        "service",
        new ArgParser()
          ..addOption("path",
              abbr: "p",
              defaultsTo: options != null
                  ? options["services"]
                  : service.library_path_default))
    ..addCommand(
        "behavior",
        new ArgParser()
          ..addOption("path",
              abbr: "p",
              defaultsTo: options != null
                  ? options["behaviors"]
                  : behavior.library_path_default))
    ..addCommand(
        "model",
        new ArgParser()
          ..addOption("path",
              abbr: "p",
              defaultsTo: options != null
                  ? options["models"]
                  : model.library_path_default))
    ..addCommand(
        "route",
        new ArgParser()
          ..addOption("path",
              abbr: "p",
              defaultsTo: options != null
                  ? options["routes_elements"]
                  : route.library_path_default));

  ArgResults results = parser.parse(args);

  switch (results?.command?.name) {
    case "app":
      if (results.command.rest.isEmpty) {
        print(usage);
      } else {
        return createApp(results.command.rest[0] ?? "polyce_app",
            results.command['material']);
      }
      break;

    case "element":
      if (results.command.rest.isEmpty) {
        print(usage);
      } else {
        element.library_path = results.command["path"];
        return element.create(results.command.rest[0]);
      }
      break;
    case "service":
      if (results.command.rest.isEmpty) {
        print(usage);
      } else {
        service.library_path = results.command["path"];
        return service.create(results.command.rest[0]);
      }
      break;
    case "behavior":
      if (results.command.rest.isEmpty) {
        print(usage);
      } else {
        behavior.library_path = results.command["path"];
        return behavior.create(results.command.rest[0]);
      }
      break;
    case "model":
      if (results.command.rest.isEmpty) {
        print(usage);
      } else {
        model.library_path = results.command["path"];
        return model.create(results.command.rest[0]);
      }
      break;
    case "route":
      if (results.command.rest.length < 2) {
        print(usage);
      } else {
        route.library_path = results.command["path"];
        return route.create(results.command.rest[0], results.command.rest[1]);
      }
      break;
    default:
      print(usage);
  }
}

Map options;

String get usage => '''
polyce  app      --[no]-material [name]
        element  --path=(default: "." or define in app.options.json) [name]
        route    --path=(default: "." or define in app.options.json) [name] [path]
        model    --path=(default: "." or define in app.options.json) [name]
        service  --path=(default: "." or define in app.options.json) [name]
        behavior --path=(default: "." or define in app.options.json) [name]

If 'app.options.json' is present in your current folder,
the generated component will be automatically add to his library specified in the options file.
''';
