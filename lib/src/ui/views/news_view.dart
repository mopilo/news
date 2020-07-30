import 'package:flutter/material.dart';
import 'package:news/src/core/services/news_service.dart';
import 'package:news/src/ui/views/single_news_view.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsService = Provider.of<NewsService>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          expandedHeight: 100,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                  color: Colors.grey),
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text('New'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 4))),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 16, bottom: 5),
              child: Text(
                'Latest News',
                style: TextStyle(color: Color(0xFF14568C), fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 5),
              child: Text(
                'Top Stories For You',
                style: TextStyle(color: Color(0xFF14568C), fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 120),
              child: Divider(
                color: Color(0xFF14568C),
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SingleNewsView(
                        newsArticle: newsService.articles[i],
                      );
                    }));
                  },
                  child: Hero(
                    tag: newsService.articles[i].url,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0),
                      height: 220,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              newsService.articles[i].urlToImage ?? '',
                            )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          ' ${newsService.articles[i].title} ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ],
                              backgroundColor: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: newsService.articles.length,
          ),
        )
      ],
    ));
  }
}
