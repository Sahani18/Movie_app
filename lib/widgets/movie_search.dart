import 'package:flutter_movie/Screens/movie_List.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/constant.dart';

class SearchMovie extends StatefulWidget {
  final String data;

  const SearchMovie({Key key, this.data}) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  bool isLoading = false;
  List searchResult;
  bool isEmpty=false;

  getSearchMovie() async {
    TMDB tmdb = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: ConfigLogger(
        showErrorLogs: true,
        showLogs: true,
      ),
    );
    Map searchMovie = await tmdb.v3.search
        .queryMovies(widget.data, includeAdult: false, page: 1);
    Map searchTvShow = await tmdb.v3.search
        .queryTvShows(widget.data, page: 1);
    setState(() {
      searchResult = searchMovie['results']+searchTvShow['results'];
      searchResult==null?isEmpty=true:isEmpty=false;
      isLoading = true;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FullMovieList(
              fullMovieList: searchResult,
              name: "Search Result",
            )));
  }

  @override
  void initState() {
    super.initState();
    this.getSearchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF18181B),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
