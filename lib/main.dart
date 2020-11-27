import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:tlauth/localnotifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TL Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TL Auth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _oAuth({override_url}) async {
    try {
      String url = override_url ??
          'https://auth.truelayer-sandbox.com/?response_type=code&client_id=sandbox-ezcoclient-7792ff&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://applinktest2.makeitsimple.co.uk/oauthredirect/&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock';
      print('attempting TL oauth url $url');
//      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: (override_url != null) ? "https" : "tlauth");
      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: "tlauth");
      print("got the result");
      print(result);
      LocalNotifications.send('Truelayer', 'Response $result');
      final accessCode = Uri.parse(result).queryParameters['code'];
      print('access code is ' + accessCode);
    } catch (error) {
      print('error in authflow $error');
      LocalNotifications.send('Truelayer authflow error', '$error');
    }
  }

  void _oAuthLive({override_url}) async {
    try {
      String url = override_url ??
          'https://auth.truelayer.com/?response_type=code&client_id=beam-7b9cf8&scope=info%20accounts%20transactions%20offline_access&redirect_uri=https://applinktest2.makeitsimple.co.uk/oauthredirect/&providers=uk-ob-all%20uk-oauth-all';
      print('attempting TL oauth url $url');
      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: "tlauth");
      print("got the result");
      print(result);
      LocalNotifications.send('Truelayer', 'Response $result');
      final accessCode = Uri.parse(result).queryParameters['code'];
      print('access code is ' + accessCode);
    } catch (error) {
      print('error in authflow $error');
      LocalNotifications.send('Truelayer authflow error', '$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Authenticate sandbox using deep link'),
              onPressed: _oAuth,
            ),
//            RaisedButton(
//              child: Text('Authenticate sandbox using app link'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer-sandbox.com/?response_type=code&client_id=sandbox-ezcoclient-7792ff&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://applinktest2.makeitsimple.co.uk/oauthredirect/&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock');
//              },
//            ),
            RaisedButton(
              child: Text('Authenticate live using deep link'),
              onPressed: _oAuthLive,
            ),
//            RaisedButton(
//              child: Text('Authenticate live using app link'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer.com/?response_type=code&client_id=beam-7b9cf8&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://applinktest2.makeitsimple.co.uk/oauthredirect/&providers=uk-ob-all%20uk-oauth-all');
//              },
//            ),
//            SizedBox(
//              height: 50,
//            ),
//            RaisedButton(
//              child: Text('Authenticate sandbox using app link form POST'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer-sandbox.com/?response_type=code&response_mode=form_post&client_id=sandbox-ezcoclient-7792ff&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://applinktest2.makeitsimple.co.uk/oauthredirect/&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock');
//              },
//            ),
//            RaisedButton(
//              child: Text('Authenticate sandbox console redirect'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer-sandbox.com/?response_type=code&client_id=sandbox-ezcoclient-7792ff&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://console.truelayer-sandbox.com/redirect-page&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock');
//              },
//            ),
//            RaisedButton(
//              child: Text('Authenticate sandbox console redirect form POST'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer-sandbox.com/?response_type=code&response_mode=form_post&client_id=sandbox-ezcoclient-7792ff&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://console.truelayer-sandbox.com/redirect-page&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock');
//              },
//            ),
//            RaisedButton(
//              child: Text('Authenticate live console redirect'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer.com/?response_type=code&client_id=beam-7b9cf8&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://console.truelayer.com/redirect-page&providers=uk-ob-all%20uk-oauth-all');
//              },
//            ),
//            RaisedButton(
//              child: Text('Authenticate live console redirect form POST'),
//              onPressed: () {
//                _oAuth(
//                    override_url:
//                        'https://auth.truelayer.com/?response_type=code&response_mode=form_post&client_id=beam-7b9cf8&scope=transactions%20accounts%20info%20offline_access&redirect_uri=https://console.truelayer.com/redirect-page&providers=uk-ob-all%20uk-oauth-all');
//              },
//            ),
          ],
        ),
      ),
    );
  }
}
