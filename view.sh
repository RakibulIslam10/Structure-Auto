#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

for viewName in "$@"; do
  capitalizedViewName=$(capitalize "$viewName")
  base_dir="lib/views/$viewName"
  echo "📦 Generating view: $viewName"

  mkdir -p "$base_dir/controller"
  mkdir -p "$base_dir/screen"
  mkdir -p "$base_dir/widget"

  # Controller
  cat <<EOF > "$base_dir/controller/${viewName}_controller.dart"
import 'package:get/get.dart';

class ${capitalizedViewName}Controller extends GetxController {
  // TODO: Add logic
}
EOF

  # Mobile Screen Part
  cat <<EOF > "$base_dir/screen/${viewName}_screen_mobile.dart"
part of "${viewName}_screen.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ${capitalizedViewName}ScreenMobile extends StatelessWidget {
  final controller = Get.put(${capitalizedViewName}Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${capitalizedViewName}')),
      body: Center(child: Text('${capitalizedViewName} Screen')),
    );
  }
}
EOF

  # Main Screen File
  cat <<EOF > "$base_dir/screen/${viewName}_screen.dart"
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/${viewName}_controller.dart';

part "${viewName}_screen_mobile.dart";

class ${capitalizedViewName}Screen extends StatelessWidget {
  final controller = Get.put(${capitalizedViewName}Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${capitalizedViewName}')),
      body: Center(child: Text('${capitalizedViewName} Screen')),
    );
  }
}
EOF

  # 👇 এই অংশটি এখানে রাখতে হবে, EOF-এর বাইরে
  page_file="lib/routes/pages.dart"

  sed -i "/\/\/Page Route List/a \\
    GetPage(
      name: Routes.$viewName,
      page: () => const ${capitalizedViewName}Screen(),
      binding: ${capitalizedViewName}Binding(),
      transition: Transition.rightToLeft,
    )," "$page_file"

  echo "✅  View created successfully"
done
