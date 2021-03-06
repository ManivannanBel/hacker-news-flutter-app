import 'package:flutter/material.dart';
import 'package:new_app/src/bloc/comments_provider.dart';
import 'package:new_app/src/screens/news_detail.dart';
import 'screens/news_list.dart';
import 'bloc/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();

          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(itemId: itemId);
        },
      );
    }
  }
}
