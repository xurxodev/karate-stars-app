import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/share_button.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserPage extends StatelessWidget {
  static const routeName = '/browser';

  /* static Widget create(String url) {
    return BlocProvider<BrowserBloc>(
        bloc: getIt<BrowserBloc>(), child: BrowserPage());
  }*/

  static Widget create() {
    return BrowserPage();
  }

  @override
  Widget build(BuildContext context) {
    //final BrowserBloc _browserBloc = BlocProvider.of<BrowserBloc>(context);

    final String url = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            ShareButton(
              onPressed: () => Share.share(url),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
        body: WebView(
            initialUrl: url, javascriptMode: JavascriptMode.unrestricted));
  }
}
