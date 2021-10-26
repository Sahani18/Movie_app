import 'package:flutter/material.dart';
import 'package:flutter_movie/Screens/movie_detail_page.dart';

class MovieWidget extends StatelessWidget {
  final List movieWidget;

   MovieWidget({Key key, this.movieWidget}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        height: 270,
        width: 140,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieWidget.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        movieDetail: movieWidget[index],
                       // id: movieWidget[index]['id'],
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Color(0xFF18181B),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/" +
                                    movieWidget[index]['poster_path']),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          movieWidget[index]['title'] != null
                              ? movieWidget[index]['title']
                              : movieWidget[index]['name'],
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
