/**
 * Created by lejard_h on 30/12/15.
 */

part of polyce;

@behavior
abstract class PolyceRouter {
  List<Page> _pages = [];

  static List<Page> pagesRouter = [];

  @Property(notify: true)
  List<Page> get pages => _pages;
  set pages(List<Page> value) {
    _pages = value;
    notifyPath("pages", value);
  }

  static attached(PolyceRouter instance) async {
    await init.run(typeFilter: [PolyceRoute]);
    print(pagesRouter);
    instance.pages = pagesRouter;
  }

  static goToDefault(
          {Map parameters,
          Route startingFrom,
          bool replace: false,
          Map queryParameters,
          bool forceReload: false}) =>
      PolymerRouterBehavior.goToDefault(
          parameters: parameters,
          startingFrom: startingFrom,
          replace: replace,
          queryParameters: queryParameters,
          forceReload: forceReload);

  static goToName(String name,
          {Map parameters,
          Route startingFrom,
          bool replace: false,
          Map queryParameters,
          bool forceReload: false}) =>
      PolymerRouterBehavior.goToName(name,
          parameters: parameters,
          startingFrom: startingFrom,
          replace: replace,
          queryParameters: queryParameters,
          forceReload: forceReload);
}