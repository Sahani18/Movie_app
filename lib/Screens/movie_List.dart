import 'package:flutter/material.dart';
import 'package:flutter_movie/Screens/movie_detail_page.dart';

class FullMovieList extends StatefulWidget {
  final List fullMovieList;
  final String name;

  const FullMovieList({Key key, this.fullMovieList, this.name})
      : super(key: key);

  @override
  _FullMovieListState createState() => _FullMovieListState();
}

class _FullMovieListState extends State<FullMovieList> {
  bool isLoading = false;

  getList() {
    if (widget.fullMovieList.length != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color(0xFF18181B),
      ),
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF18181B),
              padding: EdgeInsets.only(top: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 3),
                  itemCount: widget.fullMovieList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                                  movieDetail: widget.fullMovieList[index],
                                )));
                      },
                      child: Card(
                        shadowColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Container(
                          color: Color(0xFF18181B),
                          height: 140,
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                width: 170,
                                color: Color(0xFF18181B),
                                child: widget.fullMovieList[index]
                                            ['poster_path'] ==
                                        null
                                    ? Image.asset("assets/default.png")
                                    : Image.network(
                                        "https://image.tmdb.org/t/p/w500/" +
                                            widget.fullMovieList[index]
                                                ['poster_path'],
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Container(
                                height: 40,
                                width: 160,
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  widget.fullMovieList[index]['title'] != null
                                      ? widget.fullMovieList[index]['title']
                                      : widget.fullMovieList[index]['name'],
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
          : Center(child: CircularProgressIndicator()),
    );
  }
}
