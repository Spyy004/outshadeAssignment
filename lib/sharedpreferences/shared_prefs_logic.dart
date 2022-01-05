import 'package:flutter/cupertino.dart';
import 'package:outshadeassignment/Models/user_status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
class SharedPrefs
{
  Future<List<String>?>getSignedInUser(BuildContext context)async
  {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.getStringList('userInfo')??null;
    if(value!=null)
      {
        int x = int.parse(value[0])-1;
        Provider.of<UserStatus>(context,listen: false).changeLoginStatus(x);
      }
    print(value);
    return value;
  }
  logOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
  }
  loginUser(String id,String name,String age, String gender,BuildContext context)async
  {
    final prefs = await SharedPreferences.getInstance();
    List<String>userDetails = [id,name,age,gender];
    await getSignedInUser(context);
    await prefs.setStringList('userInfo', userDetails);
  }
}