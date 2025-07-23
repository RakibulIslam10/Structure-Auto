#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

# Function to create route and binding
create_route_and_binding() {
  capitalizedViewName=$(capitalize "$1")
  viewName="$1"
  
  # রুট ফাইল যোগ করা
  echo "GetPage(" >> lib/routes/routes.dart
  echo "  name: Routes.${capitalizedViewName}," >> lib/routes/routes.dart
  echo "  page: () => const ${capitalizedViewName}Screen()," >> lib/routes/routes.dart
  echo "  binding: ${capitalizedViewName}Binding()," >> lib/routes/routes.dart
  echo "  transition: Transition.rightToLeft," >> lib/routes/routes.dart
  echo "), " >> lib/routes/routes.dart

  # ব্যান্ডিং ফাইল তৈরি করা
  cat <<EOF > "lib/bind/${viewName}_binding.dart"
import 'package:get/get.dart';
import '../controller/${viewName}_controller.dart';

class ${capitalizedViewName}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ${capitalizedViewName}Controller());
  }
}
EOF
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
      body: Center(child: Text('${capitalizedViewName} Screen'))),
    );
  }
}
EOF

  # রুট এবং ব্যান্ডিং তৈরি করা
  create_route_and_binding "$viewName"

  echo "✅  View created successfully"
done
