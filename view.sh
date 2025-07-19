#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

for viewName in "$@"; do
  capitalizedViewName=$(capitalize "$viewName")
  base_dir="lib/views/$viewName"
  
  echo "📦 Generating Your View"
  
  mkdir -p "$base_dir/controller"
  mkdir -p "$base_dir/screen"
  mkdir -p "$base_dir/widget"
  
  echo "📦 Generating Your Bindings"
  
 BASE_DIR="lib"
 mkdir -p $BASE_DIR/bind
 touch $BASE_DIR/bind/$viewName_bindings.dart


 echo "📦 Generating Your Routing"

if [ ! -f "$ROUTES_DIR/routes.dart" ]; then
  cat <<EOF > "$ROUTES_DIR/routes.dart"
class Routes {
  // Route constants
}
EOF
fi

if [ ! -f "$ROUTES_DIR/pages.dart" ]; then
  cat <<EOF > "$ROUTES_DIR/pages.dart"
part of 'routes.dart';

import 'package:get/get.dart';

class RoutePageList {
  static List<GetPage> list = [
    // Pages will be added here
  ];
}
EOF
fi


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

  echo "✅  View created successfully"
done
