import 'package:pagination_no_library_flutter/user_model.dart';

class MyRepository{

  Future<List<UserModel>> fetchData() async{

    await Future.delayed(Duration(seconds: 2));
    List<UserModel> list = [];
    list.add(new UserModel(1 , "ali" ,"ali"));
    list.add(new UserModel(1 , "reza" ,"ali"));
    list.add(new UserModel(1 , "hasan" ,"ali"));
    list.add(new UserModel(1 , "ali" ,"ali"));
    list.add(new UserModel(1 , "reza" ,"ali"));
    list.add(new UserModel(1 , "hasan" ,"ali"));
    list.add(new UserModel(1 , "ali" ,"ali"));
    list.add(new UserModel(1 , "reza" ,"ali"));
    list.add(new UserModel(1 , "ali" ,"ali"));
    list.add(new UserModel(1 , "reza" ,"ali"));
    list.add(new UserModel(1 , "hasan" ,"ali"));
    list.add(new UserModel(1 , "ali" ,"ali"));
    list.add(new UserModel(1 , "reza" ,"ali"));
    list.add(new UserModel(1 , "hasan" ,"ali"));
    list.add(new UserModel(1 , "ali" ,"ali"));
    return list;

  }
}