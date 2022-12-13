import 'package:flutter/material.dart';

import '../../../model/model_user.dart';
import 'list_mission_account.dart';

class MissionAccountScreen extends StatefulWidget {
  final ModelUser user;
  const MissionAccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MissionAccountScreen> createState() => _MissionAccountScreenState();
}

class _MissionAccountScreenState extends State<MissionAccountScreen> {
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
                  Text(widget.user.email),
                  const Text("List des missions ")
                ],
              ),
            ))),
        body: ListMissionAccountUser(
          userMail: widget.user.email,
        ),
      ),
    );
  }
}
