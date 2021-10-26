import 'package:flutter/material.dart';
import 'package:flutter_movie/Screens/movie_List.dart';

import 'package:flutter_movie/widgets/constant.dart';

import 'package:flutter_movie/widgets/movie_catagory.dart';
import 'package:flutter_movie/widgets/movie_search.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String data;
  bool isSearch = false;
  bool isLoading = false;
  List topRatedMovies;
  List tvShowsData;
  List trendingMovies;
  List popularMovies;
  List nowPlaying;
  List getRecommended;

  movieListFunction() async {
    TMDB tmdb = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: ConfigLogger(
        showErrorLogs: true,
        showLogs: true,
      ),
    );

    Map trendingPage1 =
        await tmdb.v3.trending.getTrending(timeWindow: TimeWindow.day, page: 1);
    Map trendingPage2 =
        await tmdb.v3.trending.getTrending(timeWindow: TimeWindow.day, page: 2);
    Map trendingPage3 =
        await tmdb.v3.trending.getTrending(timeWindow: TimeWindow.day, page: 3);
    Map topRated1 = await tmdb.v3.movies.getTopRated(page: 1);
    Map topRated2 = await tmdb.v3.movies.getTopRated(page: 2);
    Map topRated3 = await tmdb.v3.movies.getTopRated(page: 3);

    Map tvShows1 = await tmdb.v3.discover.getTvShows(page: 1);
    Map tvShows2 = await tmdb.v3.discover.getTvShows(page: 2);
    Map tvShows3 = await tmdb.v3.discover.getTvShows(
      page: 3,
    );
    Map popular1 = await tmdb.v3.movies.getPouplar(page: 1);
    Map popular2 = await tmdb.v3.movies.getPouplar(page: 2);
    Map popular3 = await tmdb.v3.movies.getPouplar(page: 3);
    Map nowplaying1 = await tmdb.v3.movies.getNowPlaying(page: 1);
    Map nowplaying2 = await tmdb.v3.movies.getNowPlaying(page: 2);
    Map nowplaying3 = await tmdb.v3.movies.getNowPlaying(page: 3);
    Map recommended1 = await tmdb.v3.movies.getRecommended(2);
    Map recommended2 = await tmdb.v3.movies.getRecommended(85);
    Map recommended3 = await tmdb.v3.movies.getRecommended(58);

    setState(() {
      nowPlaying = nowplaying1['results'] +
          nowplaying2['results'] +
          nowplaying3['results'];
      topRatedMovies =
          topRated1["results"] + topRated2["results"] + topRated3["results"];
      trendingMovies = trendingPage1["results"] +
          trendingPage2['results'] +
          trendingPage3['results'];
      tvShowsData =
          tvShows1["results"] + tvShows2["results"] + tvShows3["results"];
      popularMovies =
          popular1["results"] + popular2["results"] + popular3["results"];
      getRecommended = recommended1['results'] +
          recommended2['results'] +
          recommended3['results'];
      isLoading = true;
    });
  }

  customAppBar() {
    return AppBar(
      title: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter Movie Name',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (value) {
            data = value;
            setState(() {});
          }),
      actions: [
        IconButton(
            onPressed: () {
              if (data != null) {
                setState(() {
                  isSearch == true ? isSearch = false : isSearch = true;
                });
                navigateToSearchPage(data);
              } else
                setState(() {
                  isSearch == false ? isSearch = true : isSearch = false;
                });
            },
            icon: Icon(Icons.search)),
      ],
      centerTitle: true,
      backgroundColor: Colors.black87,
      elevation: 3,
    );
  }

  navigateToSearchPage(String data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchMovie(data: data),
      ),
    );
  }

  defaultAppbar() {
    return AppBar(
      title: Text(
        "The Movie DB",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isSearch == true ? isSearch = false : isSearch = true;
              });
            },
            icon: Icon(Icons.search))
      ],
      centerTitle: true,
      backgroundColor: Colors.black87,
      elevation: 3,
    );
  }

  @override
  void initState() {
    super.initState();
    this.movieListFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: isSearch == true ? customAppBar() : defaultAppbar(),
        body: isLoading
            ? Container(
                color: Color(0xFF18181B),
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending Movies",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: trendingMovies,
                          name: "Trending Movies",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: trendingMovies),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Now Playing",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: nowPlaying,
                          name: "Now Playing",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: nowPlaying),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Rated Movies",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: topRatedMovies,
                          name: "Top Rated Movies",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: topRatedMovies),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tv Shows",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: tvShowsData,
                          name: "TV Shows",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: tvShowsData),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Now Playing",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: tvShowsData,
                          name: "Now Playing",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: nowPlaying),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recommended",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        ViewAll(
                          viewList: getRecommended,
                          name: "Recommended Movies",
                        ),
                      ],
                    ),
                    MovieWidget(movieWidget: getRecommended),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            : Container(
                color: Color(0xFF18181B),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                  ),
                ),
              ),
      ),
    );
  }
}

class ViewAll extends StatelessWidget {
  final List viewList;
  final String name;

  const ViewAll({Key key, this.viewList, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        "View all",
        style: TextStyle(
            color: Colors.pink, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FullMovieList(
                  fullMovieList: viewList,
                  name: name,
                )));
      },
    );
  }
}
