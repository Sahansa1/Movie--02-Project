import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/ListSeries.dart';

class SeriesDetailsScreen extends StatelessWidget {
  const SeriesDetailsScreen({
    super.key, 
    required this.series
    });

  final ListSeries series;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const BackButton(),

          backgroundColor: Colors.amber,
          expandedHeight:500,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title:Text(series.name),
            background: Image.network(
              '${Constants.imagePath}${series.backdrop_path}',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ), 
        ), 
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              const Text('Overview'
              ),
              const SizedBox(height: 16),
              Text(
                series.overview,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                        ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('First Air Date: '),
                        Text(series.first_air_date),
                      ],),
                    ),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                          ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Rating: '),
                        const Icon( Icons.star,
                        color: Colors.amber,
                        ),
                        Text('${series.vote_average.toStringAsFixed(1)}/10'),
                      ],),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                          ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Popularity: '),
                        Text(series.popularity.toString()),
                      ],),
                    ),

                     Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                          ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Origin countries: '),
                         Text(series.origin_country.join(', ')), 
                      ],),
                    ),

                  ],
                ),
              ),
            ],),
          ),
        )   
      ],
      ),
      
    );
  }
}

