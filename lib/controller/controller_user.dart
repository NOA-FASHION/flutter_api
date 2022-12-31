import 'package:get/get.dart';

import '../model/model_user.dart';
import '../service/remote_service/remote_user_service.dart';
import 'login/authentication_controler.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  RxList<ModelUser> UserList = List<ModelUser>.empty(growable: true).obs;
  RxBool isUserLoading = false.obs;

  @override
  void onInit() {
    getAdUsers();
    super.onInit();
  }

  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());

  void getAdUsers() async {
    try {
      String? token = _authmanager.addToken();
      isUserLoading(true);
      var result = await RemoteUserService().get(token!);
      if (result != null) {
        UserList.assignAll(modelUserListFromJson(result.body));
      }
    } finally {
      isUserLoading(false);
    }
  }

  void signUp(String email, String password) async {
    try {
      String? token = _authmanager.addToken();
      var result = await RemoteUserService().signUp(
        email: email,
        password: password,
        token: token!,
      );
      if (result.statusCode == 201) {
        getAdUsers();
      }
    } catch (e) {
      print(e);
    }
  }
}
