import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  final _baseUrl = "https://jsonplaceholder.typicode.com/posts";
  int _page = 2;
  final int _limit = 20;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  List _posts =[];



  void _loadMore() async{
     if(_hasNextPage == true &&
         _isFirstLoadRunning ==false &&
         _isLoadMoreRunning == false &&
         _scrollController.position.extentAfter < 300  // this line of clause is for appear progressbar after reach the end of list
     ){

       setState(() {
         _isLoadMoreRunning =true;
       });

       _page += 1;
       // call data
       try{
         // final response = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
         final response = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
         // final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts?_page=2&_limit=10"));

         final List fetchedPosts = json.decode(response.body);
         if(fetchedPosts.isNotEmpty){
           setState(() {
             _posts.addAll(fetchedPosts);
           });
         }else{
           setState(() {
             _hasNextPage = false;
           });
         }

       }catch (err){
         if1(kDebugMode){
           print("Something went wrong");
         }
       }

       setState(() {
         _isLoadMoreRunning = false;
       });

     }

  }


  void _firstLoad() async{

    setState(() {
      _isFirstLoadRunning = true;
    });

    // call data
    try{
      final response = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _posts = json.decode(response.body);
      });
    }catch (err){
      if(kDebugMode){
        print("Something went wrong");
      }
    }




    setState(() {
      _isFirstLoadRunning = false;
    });
  }


  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
  }



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("pagination no library"),
      ),

      body: _isFirstLoadRunning? const Center(
        child: CircularProgressIndicator(),
      ):Column(
        children: [

          Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                  controller: _scrollController,
                  itemBuilder: (context , index){
                   return itemWidget(context , index);
                  })),
          if(_isLoadMoreRunning == true)
            const Padding(
                padding: EdgeInsets.only(top: 10 ,bottom: 40),
              child: Center(child: CircularProgressIndicator(),),
            ),

          if(_hasNextPage == false)
            const Padding(
              padding: EdgeInsets.only(top: 10 ,bottom: 40),
              child: Center(child: Text("no more data"),),
            )
        ],
      ),

    );
  }

  Widget itemWidget(BuildContext context, int index) {
     return Card(
       margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
       child: ListTile(
         title: Text(_posts[index]["title"]),
         subtitle: Text(_posts[index]["body"]),
         trailing: Text(_posts[index]["id"]),
       ),
     );

  }
}
