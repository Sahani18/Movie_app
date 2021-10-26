import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/Screens/video_player_screen.dart';

import 'package:flutter_movie/widgets/constant.dart';

import 'package:http/http.dart' as http;

class MovieDetailPage extends StatefulWidget {
  final Map movieDetail;

  MovieDetailPage({this.movieDetail});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  List data;
  String link;

  getMovie() async {
    setState(() {
      link =
          "https://api.themoviedb.org/3/movie/${widget.movieDetail['id']}/videos?api_key=$apiKey&language=en-US";
    });

    var response = await http.get(Uri.parse(link));
    var decodedData = jsonDecode(response.body);
    setState(() {
      data = decodedData['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  width: width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color(0xFF18181B),
                    image: DecorationImage(
                        image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
                            widget.movieDetail['poster_path']),
                        fit: BoxFit.fill),
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: width,
                  color: Color(0xFF18181B),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        widget.movieDetail['title'] != null
                            ? widget.movieDetail['title']
                            : widget.movieDetail['name'],
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Text(
                        "Average vote : ${widget.movieDetail['vote_average']} ",
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 16,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Container(
                        height: 280,
                        child: Text(
                          widget.movieDetail['overview'],
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: FloatingActionButton(
              child: Icon(
                Icons.play_arrow_outlined,
                size: 40,
              ),
              onPressed: () {
                print('play button pressed');
                getMovie();
                //   getMovie();
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoPlayer(id: data[0]['key'])));
              },
              elevation: 3,
              splashColor: Colors.white,
            ),
            top: 270,
            left: 20,
          ),
        ],
      ),
    );
  }
}
