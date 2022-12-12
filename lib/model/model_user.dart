import 'model_mission.dart';
import 'dart:convert';

List<ModelUser> modelUserListFromJson(String val) => List<ModelUser>.from(
    json.decode(val)['hydra:member'].map((user) => ModelUser.fromJson(user)));

class ModelUser {
  final int id;
  final String email;
  final List<String> role;
  final List<String> missions;

  ModelUser(
      {required this.id,
      required this.email,
      required this.missions,
      required this.role});

  factory ModelUser.fromJson(Map<String, dynamic> data) => ModelUser(
      id: data['id'],
      email: data['email'],
      missions: List<String>.from(data['missions'].map((x) => x['name'])),
      role: List<String>.from(data['roles'].map((x) => x)));
}
