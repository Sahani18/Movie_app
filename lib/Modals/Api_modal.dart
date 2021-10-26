// import 'package:flutter/material.dart';
// import 'package:flutter_movie/widgets/constant.dart';
// import 'package:tmdb_api/tmdb_api.dart';
//
// class MovieApi {
//   List topRatedMovies;
//   List tvShowsData;
//   List trendingMovies;
//   List popularMovies;
//   List nowPlaying;
//   List getRecommended;
//   List getRecommended2;
//   List getRecommended3;
//
//   movieListFunction() async {
//     TMDB tmdb = TMDB(
//       ApiKeys(apiKey, accessToken),
//       logConfig: ConfigLogger(
//         showErrorLogs: true,
//         showLogs: true,
//       ),
//     );
//     Map topRated = await tmdb.v3.movies.getTopRated();
//     Map trending =
//         await tmdb.v3.trending.getTrending(timeWindow: TimeWindow.day);
//     Map tvShows = await tmdb.v3.discover.getTvShows();
//     Map popular = await tmdb.v3.movies.getPouplar();
//     Map nowplaying = await tmdb.v3.movies.getNowPlaying(page: 2);
//     Map recommended1 = await tmdb.v3.movies.getRecommended(2);
//     Map recommended2 = await tmdb.v3.movies.getRecommended(81);
//     Map recommended3 = await tmdb.v3.movies.getRecommended(81);
//   }
// }
//
// class SetState extends StatefulWidget {
//  //  List topRatedMovies;
//  //   List tvShowsData;
//  // List trendingMovies;
//  // List popularMovies;
//  //  List nowPlaying;
//  // List getRecommended;
//
//
//
//   @override
//   _SetStateState createState() => _SetStateState();
// }
//
// class _SetStateState extends State<SetState> {
//   MovieApi movieApi = MovieApi();
//
//   @override
//   getIndfor() {
//     setState(() {
//       nowPlaying = movieApi.movieListFunction()
//       widget.topRatedMovies = movieApi.topRatedMovies["results"];
//       trendingMovies = trending["results"];
//       tvShowsData = tvShows["results"];
//       popularMovies = popular["results"];
//       getRecommended = recommended1['results'];
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
