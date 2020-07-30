import 'package:flutter/material.dart';
import 'package:news/src/core/routes/route_manager.dart';
import 'package:news/src/core/services/location_service.dart';
import 'package:news/src/core/services/news_service.dart';
import 'package:provider/provider.dart';


class NewslineApp extends StatefulWidget {
  @override
  _NewslineAppState createState() => _NewslineAppState();
}

class _NewslineAppState extends State<NewslineApp> {
  NewsService _newsService;
  LocationService _locationService;
  bool onboard = false;

  @override
  void initState() {
    _newsService = NewsService();
    _locationService = LocationService();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<NewsService>(
          create: (_) => _newsService,
        ),
        ChangeNotifierProvider<LocationService>(
          create: (_) => _locationService,
        )
      ],
      child: MaterialApp(
        title: 'Newsline',
        theme: ThemeData(
            primaryColor: Color(0xFF14568C), brightness: Brightness.light),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: buildNamedRoutes(_newsService, _locationService),
      ),
    );
  }
}
