/**
 * Created by lejard_h on 23/03/16.
 */

part of polyce;

Object _getAnnotation(Type element, Type annotation) {
    TypeMirror mir = jsProxyReflectable.reflectType(element);
    for (var dec in mir.metadata) {
        if (dec.runtimeType == annotation) {
            return dec;
        }
    }

    return null;
}

class PolyceRoute implements init.Initializer<Type> {
    final String name;
    final String path;
    final bool isDefault;
    final bool isAbstract;
    final String redirectTo;
    final String parent;

    const PolyceRoute(this.name, this.path,
        {this.isDefault: false, this.parent, this.redirectTo, this.isAbstract});

    initialize(Type element) {
        PolymerRegister reg = _getAnnotation(element, PolymerRegister);
        if (reg != null) {
            PolymerAppRouteBehavior routeElem =
            new Element.tag(reg.tagName) as PolymerAppRouteBehavior;
            PolyceRouter.pagesRouter.add(new Page(name, path,
                element: routeElem,
                isDefault: isDefault,
                isAbstract: isAbstract,
                redirectTo: redirectTo,
                parent: parent));
        }
    }
}
