import 'package:flutter/widgets.dart';
import 'package:news/src/core/services/location_service.dart';
import 'package:news/src/core/services/news_service.dart';
import 'package:news/src/ui/views/loading_view.dart';
import 'package:news/src/ui/views/news_view.dart';

Map<String, WidgetBuilder> buildNamedRoutes(
    NewsService newsService, LocationService locationService) {
  Map<String, WidgetBuilder> namedRoutes = {
    '/news': (BuildContext context) => NewsView(),
    '/': (BuildContext context) => LoadingView(
          newsService: newsService,
          locationService: locationService,
        ),
  };
  return namedRoutes;
}
