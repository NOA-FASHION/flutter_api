class ModelTokenJson {
  int iat;
  int exp;
  List<String> roles;
  String userName;
  ModelTokenJson(
      {required this.exp,
      required this.iat,
      required this.roles,
      required this.userName});

  factory ModelTokenJson.fromJson(Map<String, dynamic> data) => ModelTokenJson(
      iat: data['iat'],
      exp: data['exp'],
      userName: data['username'],
      roles: List<String>.from(data['roles'].map((x) => x)));
}
