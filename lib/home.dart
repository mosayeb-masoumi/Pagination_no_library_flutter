
import 'package:flutter/material.dart';
import 'package:pagination_no_library_flutter/pagination_no_library.dart';
import 'package:pagination_no_library_flutter/pagination_no_library_end_list_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            RaisedButton(
               child: Text("simple pagination no library"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginationNoLibrary()),
                  );
                }),
            SizedBox(height: 10,),
            RaisedButton(
                child: Text("simple pagination no library show text while list ended"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginationNoLibraryEndListText()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
