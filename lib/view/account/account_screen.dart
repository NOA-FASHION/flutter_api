import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import 'list_mission_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late String mission;
  late String description;
  late int idUser;

  late bool selecte = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: SafeArea(
                child: AppBar(
              toolbarHeight: 100,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "profil de l'utilisateur",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Obx(() => Text(
                      "compte : ${missionsController.decodetokenString.value}")),
                  const Text("List des missions en cours")
                ],
              ),
            ))),
        body: const ListMissionAccount(),
      ),
    );
  }
}
