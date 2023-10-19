import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:markdown_browser/markdown_browser.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markdown Browser Demo',
      initialRoute: '/',
      home: const MainPage(),
      routes: {
        MainPage.routeName: (context) {
          return const MainPage();
        },
        MarkdownBrowserPage.routeName: (context) {
          return const MarkdownBrowserPage();
        },
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static const String routeName = '/main_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Browser Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OpenManual(
              urlBase: "assets/user_manual_1",
              label: "Open Offline Manual",
              icon: Icon(MdiIcons.cellphoneLink),
            ),
            const SizedBox(
              height: 16,
            ),
            OpenManual(
              urlBase: "http://127.0.0.1",
              label: "Open Online Manual",
              icon: Icon(MdiIcons.cellphoneLink),
            ),
          ],
        ),
      ),
    );
  }
}

class OpenManual extends StatelessWidget {
  const OpenManual(
      {super.key,
      required this.urlBase,
      required this.label,
      required this.icon});
  final String urlBase;
  final String label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(
                context,
                MarkdownBrowserPage.routeName,
                arguments: {"urlBase": urlBase},
              ),
          icon: icon,
          label: Text(label,
              style: Theme.of(context).textTheme.bodyLarge!,
              textAlign: TextAlign.center)),
    );
  }
}

class MarkdownBrowserPage extends StatelessWidget {
  const MarkdownBrowserPage({super.key, this.arguments});
  final Map<String, String>? arguments;
  static const String routeName = '/markdown_browser_page';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    if (args.containsKey("urlBase") &&
        args["urlBase"] != null &&
        args["urlBase"]!.isNotEmpty) {
      return Scaffold(
        body: MarkdownBrowser(
            urlBase: args["urlBase"]!,
            onExitCB: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("urlBase is not provided"),
        ),
      );
    }
  }
}
