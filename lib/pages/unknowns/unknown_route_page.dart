import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/main.dart';

class UnknownRoutePage extends StatelessWidget {
  final String route;

  const UnknownRoutePage({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Unknown route: $route"),
          const SizedBox(height: 16),
          FutureBuilder(
            future: SampleCallNativeFlutter.platformVersion,
            builder: (context, snapshot) => Text(
              snapshot.data?.toString() ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
