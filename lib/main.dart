import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'profile_view.dart';


void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Credentials? _credentials;
  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('<YOUR_DOMAIN_HERE>', '<YOUR_CLIENT_ID>');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height:300),
          if (_credentials == null)
            ElevatedButton(
              onPressed: () async {
                final credentials = await auth0.webAuthentication().login();

                setState(() {
                  _credentials = credentials;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xffea5328)),
                elevation: MaterialStateProperty.all<double>(4),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
              ),
              child: Text("Log in"),
            )

          else
            Column(
              children: [
                ProfileView(user: _credentials!.user),
                ElevatedButton(
                    onPressed: () async {
                      await auth0.webAuthentication().logout();

                      setState(() {
                        _credentials = null;
                      });
                    },
                    child: const Text("Log out"))
              ],
            )
        ],
      ),
    );
  }
}