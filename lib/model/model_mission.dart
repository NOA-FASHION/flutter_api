import 'model_user.dart';
import 'dart:convert';

List<ModelMission> modelMissionListFromJson(String val) =>
    List<ModelMission>.from(json
        .decode(val)['hydra:member']
        .map((mission) => ModelMission.fromJson(mission)));

class ModelMission {
  final int id;
  final String name;
  final String description;
  final int user;
  final String emailUser;

  ModelMission(
      {required this.user,
      required this.emailUser,
      required this.id,
      required this.name,
      required this.description});

  factory ModelMission.fromJson(Map<String, dynamic> data) => ModelMission(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      user: data['user']['id'],
      emailUser: data['user']['email']);
}
