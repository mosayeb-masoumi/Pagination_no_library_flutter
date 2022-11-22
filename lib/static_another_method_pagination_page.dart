import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class StaticAnotherMethodPaginationPage extends StatefulWidget {
  const StaticAnotherMethodPaginationPage({Key? key}) : super(key: key);

  @override
  State<StaticAnotherMethodPaginationPage> createState() => _StaticAnotherMethodPaginationPageState();
}

class _StaticAnotherMethodPaginationPageState extends State<StaticAnotherMethodPaginationPage> {

  final controller = ScrollController();

  // List<String> items = List.generate(15, (index) => "Item ${index + 1}");
  List<String> items = [];

  bool hasMore = true;
  int page = 1;
  bool isLoading = false;



  List<PostModel> totalStaticItems =[];


  @override
  void initState() {
    super.initState();

    // fetchDaynamicData();
    fetchStaticData();

    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset){
        // fetchDaynamicData();
        fetchStaticData();
      }
    });

  }


  Future fetchDaynamicData() async {


    if(isLoading) {
      return;
    }else{
      isLoading = true;
    }


    const limit = 25;
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List newItems = json.decode(response.body);
      setState(() {
        page++;
        isLoading = false;

        if(newItems.length < limit){
          hasMore = false;
        }

        items.addAll(newItems.map<String>((item){
          final number = item["id"];
          return"item $number";
        }).toList());
      });
    }


  }


  Future fetchStaticData() async{
    if(isLoading) {
      return;
    }else{
      isLoading = true;
    }

    const limit = 70;
    List<PostModel> newItems =
    [];

    if(totalStaticItems.length < 70){
      newItems = getList();
    }

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      page++;
      isLoading = false;

      if(totalStaticItems.length >= limit){
        hasMore = false;
      }else{
        hasMore = true;
      }

      totalStaticItems.addAll(newItems);
    });

  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }


  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
      totalStaticItems.clear();
    });

    // fetchDaynamicData();

    fetchStaticData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("pagination no library"),
      ),
      body: RefreshIndicator(

        onRefresh: refresh,

        //dynamic
        // child: ListView.builder(
        //   controller: controller,
        //   padding: EdgeInsets.all(8),
        //   itemCount: items.length + 1,
        //   itemBuilder: (context , index){
        //
        //     if(index< items.length){
        //       final item = items[index];
        //       return ListTile(title: Text(item),);
        //     }else{
        //       return Center(child: hasMore ? CircularProgressIndicator(color: Colors.blue,) : Text("no more item"),);
        //     }
        //   },
        // ),


        //static
        // child: SingleChildScrollView(
        //   child: Column(
        //     children: [
             child: Expanded(
               child: ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  padding: EdgeInsets.all(8),
                  itemCount: totalStaticItems.length + 1,
                  itemBuilder: (context , index){

                    if(index< totalStaticItems.length){
                      final item = totalStaticItems[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.red,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Center(child: Text(index.toString())),
                      );
                    }else{
                      return  Container(
                        height: 70,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.greenAccent,
                          child: Center(child: hasMore ? CircularProgressIndicator(color: Colors.blue,) : Text("no more item"),));
                    }
                  },
                ),
             ),
        //     ],
        //   ),
        // ),



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
