import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  const Movies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, 
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
         return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Color.fromARGB(255, 36, 139, 168),
            height:200,
            width:200,
         )
          );
        },
      ),
    );
  }
}

