import 'package:flutter/material.dart';
import 'package:pagination_no_library_flutter/repository.dart';
import 'package:pagination_no_library_flutter/user_model.dart';

class PaginationNoLibrary extends StatefulWidget {
  const PaginationNoLibrary({Key? key}) : super(key: key);

  @override
  _PaginationNoLibraryState createState() => _PaginationNoLibraryState();
}

class _PaginationNoLibraryState extends State<PaginationNoLibrary> {
  ScrollController _scrollController = ScrollController();
  List<UserModel> items = [];
  bool loading = false, allLoaded = false;

  fetchData() async {
    if (allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });

    List<UserModel> newData =
        items.length >= 60 ? [] : await MyRepository().fetchData();
    if (newData.isNotEmpty) {
      items.addAll(newData);
    }

    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        // listview reached to the bottom and new Data called
        print("new data called");
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("simple pagination no library"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (items.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // title: Text(items[index].toString()),
                        title: Text("list item "+index.toString()),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                      );
                    },
                    itemCount: items.length),

                if(loading)...[
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(

                        decoration: BoxDecoration(
                          color: Color.fromRGBO(64, 60, 60, 0.5019607843137255),
                        ),

                        height: 80,
                        // width: MediaQuery.of(context).size.width,
                        width: constraints.maxWidth,
                        child: Center(
                            child: CircularProgressIndicator()),
                      ))
                ]

                //show more loading view
              ],
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
