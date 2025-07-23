#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

# Function to create route and binding
create_route_and_binding() {
  capitalizedViewName=$(capitalize "$1")
  viewName="$1"
  
  # Check if pages.dart exists, if not create it
  if [ ! -f "lib/routes/pages.dart" ]; then
    echo "lib/routes/pages.dart not found. Creating the file..."
    mkdir -p lib/routes
    touch lib/routes/pages.dart
  fi

  # Add the route to pages.dart inside the RoutePageList class
  echo "    GetPage(" >> lib/routes/pages.dart
  echo "      name: Routes.${capitalizedViewName}Screen," >> lib/routes/pages.dart
  echo "      page: () => const ${capitalizedViewName}Screen()," >> lib/routes/pages.dart
  echo "      binding: ${capitalizedViewName}Binding()," >> lib/routes/pages.dart
  echo "      transition: Transition.rightToLeft," >> lib/routes/pages.dart
  echo "    )," >> lib/routes/pages.dart
}

# Function to update Routes class with new route constants
update_routes_class() {
  capitalizedViewName=$(capitalize "$1")
  viewName="$1"

  # Check if Routes class exists, if not create it
  if ! grep -q "class Routes" "lib/routes/routes.dart"; then
    echo "class Routes {" > lib/routes/routes.dart
    echo "  static var list = RoutePageList.list;" >> lib/routes/routes.dart
  fi

  # Add new route constant to Routes class
  echo "  static const ${capitalizedViewName}Screen = '/${capitalizedViewName}Screen';" >> lib/routes/routes.dart
}

# Iterate over all view names provided as arguments
for viewName in "$@"; do
  capitalizedViewName=$(capitalize "$viewName")
  base_dir="lib/views/$viewName"
  echo "📦 Generating view: $viewName"

  # Create necessary directories
  mkdir -p "$base_dir/controller"
  mkdir -p "$base_dir/screen"
  mkdir -p "$base_dir/widget"

  # Create Controller file
  cat <<EOF > "$base_dir/controller/${viewName}_controller.dart"
import 'package:get/get.dart';

class ${capitalizedViewName}Controller extends GetxController {
  // TODO: Add logic
}
EOF

  # Create Mobile Screen file
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

  # Create Main Screen file
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

  # Create route and binding
  create_route_and_binding "$viewName"

  # Update Routes class with new route constant
  update_routes_class "$viewName"

  echo "✅  View created successfully"
done
