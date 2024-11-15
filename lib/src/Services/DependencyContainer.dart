class DependencyContainer {
  static final Map<String, dynamic> _dependencies = {};

  // Private constructor to prevent instantiation
  DependencyContainer._();

  static void setDependency(String key, dynamic value) {
    _dependencies[key] = value;
  }

  static dynamic getDependency(String key) {
    if (_dependencies.containsKey(key)) {
      return _dependencies[key];
    }
    print("Dependency '$key' not found.");
    return null;
  }

  static T? resolve<T>(String key) {
    final dependency = getDependency(key);
    if (dependency is T) {
      return dependency;
    } else {
      print("Dependency '$key' is not of type ${T.toString()}");
      return null;
    }
  }

  static void clearDependencies() {
    _dependencies.clear();
  }
}