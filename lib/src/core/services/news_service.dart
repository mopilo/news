import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:news/src/core/models/news_article.dart';
import 'package:news/src/core/shared/secret_key.dart';
import 'package:rxdart/subjects.dart';

// Utility to track the progress of News Articles
enum NewsLoadState { Loading, Loaded, Vacant }

/// `NewsService` will act as a utility class and perform all
/// operations related to the NewsArticles.
class NewsService extends ChangeNotifier {
  /// Stores the master list of `NewsArticle` instances
  List<NewsArticle> _articlesList = [];

  /// Getter for the news articles list
  List<NewsArticle> get articles {
    return _articlesList;
  }

  /// To enable listening to changes of `NewsLoadState`
  PublishSubject<NewsLoadState> _newsLoadStateSubject = PublishSubject();

  /// Getter for `NewsLoadState` PublishSubject
  PublishSubject<NewsLoadState> get newsLoadState {
    return _newsLoadStateSubject;
  }

  /// Instance of Database Helper class

  /// Fetch news articles from NewsApi.org, optionally accepts
  /// the request query params.
  Future getArticlesFromApi(
      {String country = 'in', String query = '', String category = ''}) async {
    String baseUrl = 'https://newsapi.org/v2/top-headlines';

    String requestParams = '?apiKey=${SecretKey.apiKey}' +
        '&country=$country' +
        '&q=$query' +
        '&category=$category';

    // Update NewsLoadState to Loading
    _newsLoadStateSubject.add(NewsLoadState.Loading);

    try {
      http.Response apiResponse = await http.get(baseUrl + requestParams);

      if (apiResponse.statusCode != 200) {
        updateNewsLoadState();
      } 
    } catch (exception) {
      print(exception);
    }
  }


  /// Update NewsLoadState as per the availability of articles
  void updateNewsLoadState() {
    if (_articlesList.length > 0) {
      _newsLoadStateSubject.add(NewsLoadState.Loaded);
    } else {
      _newsLoadStateSubject.add(NewsLoadState.Vacant);
    }
  }
}
