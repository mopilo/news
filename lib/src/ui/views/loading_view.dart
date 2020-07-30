import 'package:flutter/material.dart';
import 'package:news/src/core/services/location_service.dart';
import 'package:news/src/core/services/news_service.dart';
import 'package:news/src/ui/widgets/loading_screen_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingView extends StatefulWidget {
  final LocationService locationService;
  final NewsService newsService;

  LoadingView({this.locationService, this.newsService});
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  String _loadingText;
  bool onboard = false;

  @override
  void initState() {
    traceLocationState();
    this.widget.locationService.getUserLocation();
    checkIfOpenedBefore();
    super.initState();
  }

  void checkIfOpenedBefore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool openedBefore = prefs.getBool('openedBefore');

    if (openedBefore != null) {
      if (openedBefore) {
        setState(() {
          onboard = false;
        });
      }
    } else {
      setState(() {
        onboard = true;
      });
      prefs.setBool('openedBefore', true);
    }
  }

  void traceLocationState() {
    if (mounted)
      this
          .widget
          .locationService
          .locationStateSubject
          .listen((LocationState locationState) {
        if (locationState == LocationState.Available) {
          traceNewsLoadState();
        } else if (locationState == LocationState.Finding) {
          setState(() {
            _loadingText = 'Getting Your Location...';
          });
        }
      });
  }

  void traceNewsLoadState() {
    if (mounted)
      this
          .widget
          .newsService
          .newsLoadState
          .listen((NewsLoadState newsLoadState) {
        if (newsLoadState == NewsLoadState.Loading) {
          setState(() {
            _loadingText = 'Fetching News Articles...';
          });
        } else if (newsLoadState == NewsLoadState.Loaded) {
          // onboard
              // ? Navigator.pushReplacementNamed(context, '/onboard')
              Navigator.pushReplacementNamed(context, '/news');
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreenWidget(
      loadingText: _loadingText,
    );
  }
}
