import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_series.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/repttext.dart';

class SeriesDetailsScreen extends StatelessWidget {

  const SeriesDetailsScreen({
    super.key, 
    required this.series, 
    });

  final ListSeries series;
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.colBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(),
            backgroundColor: const Color.fromARGB(255, 228, 227, 226),
            expandedHeight: 500,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(series.name),
              background: Image.network(
                '${Constants.imagePath}${series.poster_path}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  overviewTtitle('Overview'),
                  const SizedBox(height: 16),
                  overviewText(
                    series.overview,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colours.detailsBorder),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              datetext('First Air Date: '),
                              datetext(series.first_air_date),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 166, 169, 170)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              datetext('Rating: '),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text('${series.vote_average.toStringAsFixed(1)}/10'),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colours.detailsBorder),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              datetext('Popularity: '),
                              datetext(series.popularity.toString()),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 135, 139, 141)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              datetext('Origin countries: '),
                              datetext(series.origin_country.join(', ')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}