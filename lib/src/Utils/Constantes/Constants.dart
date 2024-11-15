class Constants {
  static Map<String, dynamic> dynamicConstants = {};

  static void setConstant(String key, dynamic value) {
    dynamicConstants[key] = value;
  }

  static dynamic getConstant(String key) {
    if (dynamicConstants.containsKey(key)) {
      return dynamicConstants[key];
    }
    print("Constant '$key' not found.");
    return null;
  }
}