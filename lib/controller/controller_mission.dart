import 'package:flutter_api/service/remote_service/remote_mission_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../model/model_mission.dart';
import '../model/model_token_jwt.dart';
import 'login/authentication_manager.dart';

class MissionController extends GetxController {
  static MissionController instance = Get.find();
  RxList<ModelMission> MissionList =
      List<ModelMission>.empty(growable: true).obs;
  RxBool isMissionLoading = false.obs;

  RxString decodetokenString = "".obs;

  @override
  void onInit() {
    getAdMissions();
    super.onInit();
    getAccount();
  }

  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());

  void getAccount() {
    String? token = _authmanager.addToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    ModelTokenJson modelTokenJson = ModelTokenJson.fromJson(decodedToken);
    print(modelTokenJson.userName);
    decodetokenString.value = modelTokenJson.userName;
  }

  void getAdMissions() async {
    try {
      String? token = _authmanager.addToken();
      isMissionLoading(true);
      var result = await RemoteMissionService().get(token!);
      if (result != null) {
        MissionList.assignAll(modelMissionListFromJson(result.body));
      }
    } finally {
      print(MissionList.first.id);
      isMissionLoading(false);
    }
  }

  void adMission(String name, String description, int idUser) async {
    try {
      String? token = _authmanager.addToken();
      var result = await RemoteMissionService().adMission(
          description: description, idUser: idUser, name: name, token: token!);
      if (result.statusCode == 201) {
        getAdMissions();
      }
    } catch (e) {
      print(e);
    }
  }
}
