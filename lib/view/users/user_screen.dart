import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import 'list_user.dart';

class UserSreen extends StatefulWidget {
  const UserSreen({Key? key}) : super(key: key);

  @override
  State<UserSreen> createState() => _UserSreenState();
}

class _UserSreenState extends State<UserSreen> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PersistentBottomSheetController _bottomSheetController;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: SafeArea(
                child: AppBar(
              title: const Text("Liste des utilisateurs"),
            ))),
        key: scaffoldkey,
        body: const ListUserSreen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildBottomSheet(),
      ),
    );
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
                              email = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Merci d'entrer un email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                helperText: "Exemple : 'dana@gmail.com '",
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
                                labelText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            textCapitalization: TextCapitalization.sentences,
                            onSaved: (value) {
                              password = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Merci d'entrer un password";
                              } else if (value.length > 35) {
                                return "Pas plus de 50 caractères";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                helperText: "Exemple : 'Weybg@123'",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Mot de passe",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
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
                                  userController.signUp(email, password);

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
