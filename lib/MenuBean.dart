class Menu {
  final String imageUrl;
  final String tags;
  final String title;
  final String burden; // 配料
  final String ingredients; // 佐料
  final List<Step> steps;

  static List<Menu> withJsons(List<dynamic> list) {
    return list.map((value) => Menu.withJson( value )).toList();
  }

  static List<Step> _parseSteps(List<dynamic> list) {
    return list.map((value) {
      return new Step.withJson(value);
    }).toList();
  }

  Menu.withJson(Map<String, dynamic> json)
      : imageUrl = json['albums'][0],
        tags = json['tags'],
        title = json['title'],
        burden = json['burden'],
        ingredients = json['ingredients'],
        steps = _parseSteps(json['steps']);
}

class Step {
  final String imageUrl;
  final String step;

  Step.withJson(Map<String, dynamic> json)
      : imageUrl = json['img'],
        step = json['step'];
}
