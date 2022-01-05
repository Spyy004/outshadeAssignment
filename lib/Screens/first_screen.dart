import 'package:flutter/material.dart';
import 'package:outshadeassignment/Constants/fonts&themes.dart';
import 'package:outshadeassignment/Constants/usersdirectory.dart';
import 'package:outshadeassignment/Models/user_status_model.dart';
import 'package:outshadeassignment/Models/users_model.dart';
import 'package:outshadeassignment/Screens/seconde_screen.dart';
import 'package:outshadeassignment/sharedpreferences/shared_prefs_logic.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();
  SharedPrefs sharedPrefs = SharedPrefs();
  void signInuser(BuildContext context, String id, String name, int idx,
      String age, String gender, BuildContext contexti) {
    print("USer Signed In Called $id");
    Provider.of<UserStatus>(context, listen: false)
        .signInUser(id, name, idx, age, gender, contexti);
  }

  void signOutUser(BuildContext context, String id, int idx) {
    Provider.of<UserStatus>(context, listen: false).signOutUser(id, idx);
  }

  void initializeStatus(BuildContext context) {
    Provider.of<UserStatus>(context, listen: false).initializeStatus(context);
  }

  Future<UserList> getUsersList(BuildContext context) async {
    initializeStatus(context);
    return UserList.fromJson(userDir);
  }

  void doNothing() {}
  @override
  Widget build(BuildContext context) {
    var isSignedIn = Provider.of<UserStatus>(context).isSignedIn;
    // Provider.of<UserStatus>(context,listen: false).initializeStatus();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<UserList>(
              future: getUsersList(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.users!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return ListTile(
                            onTap: () {
                              isSignedIn[index]
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SingleUserInfo(
                                                index: index,
                                              )),
                                    )
                                  : doNothing();
                            },
                            title: Text(
                              snapshot.data!.users![index].name.toString(),
                              style: nameStyle,
                            ),
                            trailing: FlatButton(
                              onPressed: () {
                                print(isSignedIn[index]);
                                isSignedIn[index]
                                    ? signOutUser(
                                        context,
                                        snapshot.data!.users![index].id
                                            .toString(),
                                        index)
                                    : showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Gender",
                                                  style: nameStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                    controller: gender),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Age",
                                                  style: nameStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: age,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: false,
                                                          signed: false),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Center(
                                                  child: FlatButton(
                                                      color: Colors.black,
                                                      onPressed: () {
                                                        signInuser(
                                                            context,
                                                            snapshot
                                                                .data!
                                                                .users![index]
                                                                .id
                                                                .toString(),
                                                            snapshot
                                                                .data!
                                                                .users![index]
                                                                .name
                                                                .toString(),
                                                            index,
                                                            age.text,
                                                            gender.text,
                                                            context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SingleUserInfo(
                                                                    index:
                                                                        index,
                                                                  )),
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                              },
                              child: isSignedIn[index]
                                  ? Text(
                                      "Sign Out",
                                      style: signIn,
                                    )
                                  : Text(
                                      "Sign In",
                                      style: signIn,
                                    ),
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      });
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
