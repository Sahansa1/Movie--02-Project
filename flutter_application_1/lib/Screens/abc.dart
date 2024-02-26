import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading; 
  final Text? title;
  final Text? subtitle; 
  final Widget? trailing; 
  final double? height; 
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    required this.height, 
  });

  @override
  Widget build(BuildContext context) {
    return Material( 
      child: InkWell( 

        
        child: SizedBox( 
          height: height, 
          child: Row( 
            children: [
              Padding( 
                padding: const EdgeInsets.only(left: 12.0, right: 12.0,top:12,bottom: 12),
                child: leading, 
              ),
              Expanded( 
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 12.0,top:50,bottom: 12),
                    child:title ?? const SizedBox(),
                    ), 
                    const SizedBox(height: 10), 
                    subtitle ?? const SizedBox(), 
                  ],
                ),
              ),
              Padding( 
                padding: const EdgeInsets.all(12.0),
                child: trailing, 
              )
            ],
          ),
        ),
      ),
    );
  }
}