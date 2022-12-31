import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../controller/login/authentication_controler.dart';
import '../../model/model_user.dart';
import 'list_mission.dart';

class Mission extends StatefulWidget {
  const Mission({Key? key}) : super(key: key);

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  AuthenticationManager _authManager = Get.find();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PersistentBottomSheetController _bottomSheetController;
  late String mission;
  late String description;
  late int idUser;
  late ModelUser selected = ModelUser(
    email: "select",
    id: 2,
    missions: [],
    role: [],
  );
  late bool selecte = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: SafeArea(
                child: AppBar(
              title: const Text("Mission en cours"),
              actions: [
                IconButton(
                    onPressed: () {
                      _authManager.logOut();
                    },
                    icon: const Icon(Icons.logout_rounded))
              ],
            ))),
        key: scaffoldkey,
        body: const ListMission(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildBottomSheet(),
      ),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState!(() {
      selected = value;
    });
  }

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
        heroTag: null,
        // child: Lottie.asset('assets/float.json'),
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange[900],
        onPressed: () {
          _bottomSheetController = scaffoldkey.currentState!.showBottomSheet(
            (context) {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          IconButton(
                            alignment: Alignment.topRight,
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onSaved: (value) {
                              mission = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Merci d'entrer un nom pour la mission";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                helperText: "Exemple : 'Tâche quotidienne '",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                labelText: "Nom de la mission",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onSaved: (value) {
                              description = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Merci d'entrer une description pour la mission";
                              } else if (value.length > 35) {
                                return "Pas plus de 50 caractères";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                helperText: "Exemple : 'Liste des tâches'",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Description",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Obx(() => DropdownButton<ModelUser>(
                                hint: const Text("Select item"),
                                dropdownColor: Colors.transparent,
                                underline: Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  height: 4,
                                  color: Colors.black,
                                ),
                                value: selecte
                                    ? userController.UserList[0]
                                    : selected,
                                onChanged: (ModelUser? value) {
                                  setState(() {
                                    updateController(value);
                                    selecte = false;
                                    idUser = value!.id;
                                  });
                                },
                                items: userController.UserList.map(
                                    (ModelUser dropDownStringItem) {
                                  return DropdownMenuItem<ModelUser>(
                                    value: dropDownStringItem,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      margin: const EdgeInsets.only(bottom: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                  dropDownStringItem.email,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                          Center(
                            child: IconButton(
                              iconSize: 60,
                              alignment: Alignment.topRight,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.orange[900],
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  missionsController.adMission(
                                      mission, description, idUser);

                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
