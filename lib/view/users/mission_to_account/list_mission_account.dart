import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/controller.dart';
import '../../../model/model_mission.dart';

class ListMissionAccountUser extends StatefulWidget {
  final String userMail;
  const ListMissionAccountUser({Key? key, required this.userMail})
      : super(key: key);

  @override
  State<ListMissionAccountUser> createState() => _ListMissionAccountUserState();
}

class _ListMissionAccountUserState extends State<ListMissionAccountUser> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (missionsController.MissionList.isEmpty) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            "Pas de mission en cours.",
            style: TextStyle(color: Colors.orange[600], fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        );
      }
      String accountToken = widget.userMail;
      List<ModelMission>? MissionListPerAccount;

      MissionListPerAccount = missionsController.MissionList.where(
          (c) => c.emailUser.contains(accountToken)).toList();
      return ListView.builder(
        itemCount: MissionListPerAccount.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
            child: Dismissible(
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
                      content: "les transactions ont bien été supprimées",
                      lotties: 'assets/trash.json'));
                }

                if (direction == DismissDirection.startToEnd) {
                  ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
                      content: "les transactions ont bien été supprimées",
                      lotties: 'assets/trash.json'));
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  final bool? resultat = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Confirmation",
                            style: TextStyle(color: Colors.blue),
                          ),
                          content: const Text(
                              "Voulez vous supprimer les transactions"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Oui"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Non"),
                            )
                          ],
                        );
                      });
                  return resultat;
                }
                if (direction == DismissDirection.endToStart) {
                  final bool? resultat = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Confirmation",
                            style: TextStyle(color: Colors.blue),
                          ),
                          content: const Text(
                              "Voulez vous supprimer les transactions"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Oui"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Non"),
                            )
                          ],
                        );
                      });
                  return resultat;
                }
                return true;
              },
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.only(right: 10.0),
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.delete,
                  size: 55.0,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                padding: const EdgeInsets.only(right: 10.0),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  size: 55.0,
                  color: Colors.white,
                ),
              ),
              key: Key(UniqueKey().toString()),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 45.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 10  horizontally
                        3.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 20.0,
                  child: ListTile(
                    onTap: () async {},
                    title: Container(
                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 15.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Nom ".toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(MissionListPerAccount![index].name)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(MissionListPerAccount[index].description),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Affecté à ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(MissionListPerAccount[index].emailUser),
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  SnackBar _buildSnackBar({@required String? content, String? lotties}) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      content: Container(
        height: 80,
        child: Row(
          children: [
            Lottie.asset(lotties!, width: 60),
            Text(
              content!,
              style: const TextStyle(color: Colors.purple),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
