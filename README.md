# Markdown Browser

A package to simplify browsing markdown files.

This package is useful in situations where, the application required to provide set of markdown files as help content or user manual and require a browser widget to dispay it inside flutter application.

The markdown files can be placed either in assets folder or served from a external server.

## Screenshots

## Features

* Browse across the markdown files within the same folder / served under the same base URL.
* Opens other Links in webview
* Supports Header browsing and history
* Supports Latex equations (both $<>$  and $$<>$$)
* Basic Navigation menu, which disappears when reading the document.
* provided as widget hence it can be embedded into any other widget. Not necessary to be a standalone page.

For rendering markdown files, **markdown_widget**  package is used. Refer [demo](https://asjqkkkk.github.io/markdown_widget) to understand the features supported and the limitations.

## Getting started

### Add the package to your `pubspec.yaml` file

```bash
flutter pub add markdown_browser
```

### Add riverpod

This package uses riverpod to mange state.

```bash
flutter pub add flutter_riverpod
```

As required by riverpod, wrap the entire application in a "ProviderScope" widget.

```dart
  void main() {
    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }
```

### Invoke widget

```dart
import 'package:markdown_browser/markdown_browser.dart';
```

Use the Widget

```dart
    MarkdownBrowser(
        urlBase: "http://127.0.0.1:5000",
        onExitCB: () {
            // Your logic to remove the Markdown browser
        }),
        landingPage: "my_indexPage.md", // defaults to index.md
        onGetMarkDownCB: (String path) async {
            final String content = // your logic to download/load the file
            return content
        } // defaults to internal http based logic
        
```

## Usage

Refer the provided example, to understand how to use this package for both offline content and online content.

### Offline

Store the folder containing under assets and add it into `<Application>/pubspec.yaml`. Do not forget to add the subfolders inside the content.

```yaml

flutter:
  assets:
  - assets/user_manual_1/
  - assets/user_manual_1/topic/

```

Invoke the widget with urlBase `assets/user_manual_1`

### Online

Ensure the link `<urlBase>/<landingPage>` is valid.

To test this package for online feature, a test server is provided under example/server folder.
If you are tesing a desktop application, ensure you have python3, python3-pip and python3-venv are installed and run the provided script.

On a linux box, this can be done as below

```bash
sudo apt install python3 python3-pip python3-venv -y
cd example/server
bash start_server.sh

```

This will start the Flask server and serve on local as well as network address.

```text
....
 * Serving Flask app 'server.py'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://x.x.x.x:5000

```

If you are testing the application on the same machine, the online variant should work without any change using `http://127.0.0.1:5000`.

If you are testing on a mobile device or another machine, ensure that the server is serving on the network by modifying the BaseURL to `http://x.x.x.x:5000` before running the flutter app.

## Additional information

### Planned enhancements

* [ ] if the page failes in the middle of browsing, provide a back button to go back to the previous file
* [ ] expose more customization permitted by markdown_widget to the application.
* [ ] Testing more markdown content

### Known issues

* [ ]  Unable to navigate to the specific section in the same markdown file or another if the link is pointing to a section. This doesn't seems to be supported by markdown_widget package

## Change Log

* Version **0.1.0**, 2023-10-19
  * Initial Release with basic support
  * basic testing on Linux and Android

## Support

If you face any issue or have any enhancement suggestions, create [issue on github](https://github.com/cloudonlanapps/markdown_browser/issues) or contact me at cloudonlanapps (at) gmail (doc) com

You may also send your pull request if you want to contribute.