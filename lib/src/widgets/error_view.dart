import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.errorString,
    required this.onExit,
  });
  final String errorString;
  final Function() onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            MdiIcons.alertBox,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            errorString.replaceAll("Exception: ", ""),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(onPressed: onExit, child: const Text("Exit"))
        ],
      ),
    );
  }
}
