import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
       width: 70,
       margin: const EdgeInsetsDirectional.only(
        top: 16,
        start: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(8),
      ),

      child: IconButton(onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}