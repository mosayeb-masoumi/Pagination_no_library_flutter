import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class StaticDataPaginationPage extends StatefulWidget {

  const StaticDataPaginationPage({Key? key}) : super(key: key);

  @override
  State<StaticDataPaginationPage> createState() => _StaticDataPaginationPageState();
}

class _StaticDataPaginationPageState extends State<StaticDataPaginationPage> {



  final _baseUrl = "https://jsonplaceholder.typicode.com/posts";
  int _page = 2;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  List<PostModel> _totalPosts =[];




  void _loadMore() async{
    if(_hasNextPage == true &&
        _isFirstLoadRunning ==false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300  // this line of clause is for appear progressbar after reach the end of list
    ){

      setState(() {
        _isLoadMoreRunning =true;
      });

      await Future.delayed(Duration(seconds: 2));

      _page += 1;
      // call data
      try{

       List<PostModel> nextPageList =[];
        if(_totalPosts.length < 50){  // total amount 50
           nextPageList = getList();
        }


        if(nextPageList.isNotEmpty){
          setState(() {
            _totalPosts.addAll(nextPageList);
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


    await Future.delayed(Duration(seconds: 2));

    // call data
    try{
      setState(() {
        _totalPosts = getList();
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
                  itemCount: _totalPosts.length,
                  controller: _scrollController,
                  itemBuilder: (context , index){
                    return itemWidget(context , index);
                  })),
          if(_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10 ,bottom: 40),
              child: Center(child: CircularProgressIndicator(),),
            ),

          // if(_hasNextPage == false)
          //    Container(
          //      color: Colors.red,
          //     padding: EdgeInsets.only(top: 10 ,bottom: 40),
          //     child: Center(child: Text("no more data"),),
          //   )
        ],
      ),

    );
  }

  Widget itemWidget(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: ListTile(
        title: Text("$index"),
        subtitle: Text("${_totalPosts[index].index}"),
      ),
    );
  }



  List<PostModel> getList(){
    List<PostModel> list =[];
    list.add(PostModel(0));
    list.add(PostModel(1));
    list.add(PostModel(2));
    list.add(PostModel(3));
    list.add(PostModel(4));
    list.add(PostModel(5));
    list.add(PostModel(6));
    list.add(PostModel(7));
    list.add(PostModel(8));
    list.add(PostModel(9));
    return list;
  }

}


class PostModel{
  int index;
  PostModel(this.index);
}

