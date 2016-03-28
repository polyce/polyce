/**
 * Created by lejard_h on 23/12/15.
 */

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
