import 'package:flutter/material.dart';

Widget tittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
          color: Colors.white.withOpacity(0.9),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget boldtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget normaltext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25));
}

Widget homeMovieName(String title) {
  return Text(
    title,
    textAlign: TextAlign.left, // Aligns the text to the left
    style: TextStyle(
      fontFamily: 'open sans',
      decoration: TextDecoration.none,
      color: const Color.fromARGB(255, 139, 138, 138).withOpacity(0.9),
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
  );
}

Widget homeMovieYear(String title) {
  return Text(
    title,
    textAlign: TextAlign.right, 
    style: TextStyle(
      fontFamily: 'open sans',
      decoration: TextDecoration.none,
      color: const Color.fromARGB(255, 168, 167, 167).withOpacity(0.9),
      fontSize: 10,
      fontWeight: FontWeight.w100,
      letterSpacing: 1.25,
    ),
  );
}

Widget datetext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Color.fromARGB(255, 220, 210, 210).withOpacity(0.9),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ratingtext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

Widget ultratittletext(String title) {
  return Text(title,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'open sans',
          color: Colors.white.withOpacity(0.9),
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25));
}

Widget genrestext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25));
}

Widget overviewText(String title) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.9),
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
  );
}

Widget overviewTtitle(String title) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.9),
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
  );
}

Widget detailsBoxTitle(String title) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.9),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
  );
}

Widget detailsBoxDetail(String title) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'open sans',
        decoration: TextDecoration.none,
        color: const Color.fromARGB(255, 180, 177, 177).withOpacity(0.9),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
  );
}


Widget Tabbartext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: Colors.white.withOpacity(1),
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1));
}
Widget datestext(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: 'open sans',
          decoration: TextDecoration.none,
          color: const Color.fromARGB(255, 152, 151, 151).withOpacity(0.9),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.02));
}

