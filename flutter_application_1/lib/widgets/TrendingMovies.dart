import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width :double.infinity,
      child: CarouselSlider.builder(
        itemCount: 10,
        options: CarouselOptions(
          aspectRatio: 16/9,
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1)
        ),
        itemBuilder: (context,itemIndex,pageViewIndex){
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 300, 
              width:200,
              color: Colors.cyan,
            )
          );
        }
        
      ),
        
    );
  }
}