import 'package:flutter/cupertino.dart';
import 'package:outshadeassignment/sharedpreferences/shared_prefs_logic.dart';
import 'package:provider/provider.dart';

class UserStatus extends ChangeNotifier
{
  final _isLoggedIn = List.filled(15, false,growable: true);
  SharedPrefs sharedPrefs = SharedPrefs();
  void signOutUser(String id,int idx){
    sharedPrefs.logOutUser();
    _isLoggedIn[idx]=false;
    notifyListeners();
  }
  void signInUser(String id,String name,int idx,String gender,String age,BuildContext context)
  {
      sharedPrefs.loginUser(id,name,age,gender,context);
      _isLoggedIn[idx]=true;
      notifyListeners();
  }
  void initializeStatus(BuildContext context)async
  {
    List<String>? currUser = await sharedPrefs.getSignedInUser(context);
    if(currUser!.isNotEmpty) {{
        int x = int.parse(currUser[0]);
        _isLoggedIn[x - 1] = true;
      }
    }
    notifyListeners();
  }
  void changeLoginStatus(int id)
  {
    _isLoggedIn[id]=false;
    notifyListeners();
  }
  List<bool> get isSignedIn{
    return _isLoggedIn;
  }
}