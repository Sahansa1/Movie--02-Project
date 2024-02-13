import 'package:flutter/material.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text("BingeWatch"),
          leading:IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
            },
          ),
          actions: [
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.search)
              ),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.more_vert)
              )
          ],
        ),
        body: Container(
          color: Colors.amber,
          child: Text("This is Bingewatch"), 
         
        ),
        
      ),

    );
  }
}

