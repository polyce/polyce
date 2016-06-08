library __projectName__.elements.test_behavior;

import "package:polyce/polyce.dart";
import "package:__projectName__/__projectName__.dart";

@behavior
abstract class TestBehavior implements AutonotifyBehavior, Observable {
  /// Called when an instance of TestBehavior is inserted into the DOM.
  static attached(TestBehavior instance) {
  }

  /// Called when an instance of TestBehavior is removed from the DOM.
  static detached(TestBehavior instance) {
  }

  /// Called when an attribute (such as  a class) of an instance of TestBehavior is added, changed, or removed.
  static attributeChanged(String name, String oldValue, String newValue) {
  }

  /// Called when TestBehavior has been fully prepared (Shadow DOM created, property observers set up, event listeners attached).
  static ready(TestBehavior instance) {}
}
