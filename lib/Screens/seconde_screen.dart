import 'package:flutter/material.dart';
import 'package:outshadeassignment/Constants/fonts&themes.dart';
import 'package:outshadeassignment/Models/user_status_model.dart';
import 'package:outshadeassignment/Screens/first_screen.dart';
import 'package:outshadeassignment/sharedpreferences/shared_prefs_logic.dart';
import 'package:provider/provider.dart';

class SingleUserInfo extends StatelessWidget {
  SingleUserInfo({Key? key, required, required this.index}) : super(key: key);
  final int index;
  SharedPrefs prefs = SharedPrefs();
  void signOutUser(BuildContext context, String id, int idx) {
    Provider.of<UserStatus>(context, listen: false).signOutUser(id, idx);
  }

  Future<List<String>?> getCurrentUser(BuildContext context) async {
    return await prefs.getSignedInUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>?>(
          future: getCurrentUser(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                        child: Text(
                      "User Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Name",
                      style: nameStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      snapshot.data![1],
                      style: nameStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Gender",
                      style: nameStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      snapshot.data![2],
                      style: nameStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Age",
                      style: nameStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      snapshot.data![3],
                      style: nameStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                signOutUser(context, snapshot.data![0], index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FirstPage()));
                              },
                              color: Colors.black,
                              child: Text(
                                "Log Out",
                                style: signIn.copyWith(color: Colors.white),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FirstPage()));
                              },
                              color: Colors.black,
                              child: Text(
                                "Go Back",
                                style: signIn.copyWith(color: Colors.white),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
