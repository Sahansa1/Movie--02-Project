/*import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/widgets/movie_details.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype.toString() == 'movie') {
      return MovieDetailsScreen(
        movie: snapshot.data[itemIndex], 
        id: 0,
        id: widget.newid,
      );
      
    } else {
      return errorui(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
*/