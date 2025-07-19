#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

BASE_DIR="lib"
ROUTES_DIR="$BASE_DIR/routes"

# Ensure routes directory exists
mkdir -p "$ROUTES_DIR"

# Create routes.dart if missing
if [ ! -f "$ROUTES_DIR/routes.dart" ]; then
  cat <<EOF > "$ROUTES_DIR/routes.dart"
class Routes {
  static var list = RoutePageList.list;
  // Route constants will be added here
}
EOF
  echo "🛣️ Created $ROUTES_DIR/routes.dart"
fi

# Create pages.dart if missing
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
  echo "📃 Created $ROUTES_DIR/pages.dart"
fi

# Function to add route constant if not exists
add_route_constant() {
  local route_const_name=$1
  local route_path=$2
  local file="$ROUTES_DIR/routes.dart"

  if ! grep -q "static const $route_const_name" "$file"; then
    sed -i "/^}/i \  static const $route_const_name = '/$route_path';" "$file"
    echo "🛣️ Added route constant $route_const_name"
  else
    echo "⚠️ Route constant $route_const_name already exists"
  fi
}

# Function to add GetPage entry if not exists
add_getpage_entry() {
  local route_const_name=$1
  local screen_class=$2
  local binding_class=$3
  local import_path=$4
  local file="$ROUTES_DIR/pages.dart"

  # Add import if not exists
  if ! grep -q "import '$import_path';" "$file"; then
    sed -i "1i import '$import_path';" "$file"
    echo "📥 Added import $import_path"
  fi

  # Add GetPage entry if not exists
  if ! grep -q "name: Routes.$route_const_name" "$file"; then
    sed -i "/];/i \
    GetPage(\
      name: Routes.$route_const_name,\
      page: () => const $screen_class(),\
      binding: $binding_class(),\
      transition: Transition.rightToLeft,\
    )," "$file"
    echo "📃 Added GetPage for $screen_class"
  else
    echo "⚠️ GetPage for $route_const_name already exists"
  fi
}

for viewName in "$@"; do
  capitalizedViewName=$(capitalize "$viewName")
  base_dir="$BASE_DIR/views/$viewName"
  
  echo "📦 Generating Your View: $capitalizedViewName"

  mkdir -p "$base_dir/controller"
  mkdir -p "$base_dir/screen"
  mkdir -p "$base_dir/widget"

  echo "📦 Generating Your Bindings"
  mkdir -p "$BASE_DIR/bind"
  touch "$BASE_DIR/bind/${viewName}_binding.dart"  # Create empty binding file if needed, or overwrite later

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
      appBar: AppBar(title: Text('${capitalizedViewName} Mobile')),
      body: Center(child: Text('${capitalizedViewName} Mobile Screen')),
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

  # Create Binding file with content
  binding_file="$BASE_DIR/bind/${viewName}_binding.dart"
  if [ ! -f "$binding_file" ]; then
    cat <<EOF > "$binding_file"
import 'package:get/get.dart';
import '../views/$viewName/controller/${viewName}_controller.dart';

class ${capitalizedViewName}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${capitalizedViewName}Controller>(() => ${capitalizedViewName}Controller());
  }
}
EOF
    echo "🔧 Created binding: $binding_file"
  else
    echo "⚠️ Binding already exists: $binding_file"
  fi

  # Prepare routing info
  route_const_name="${viewName}Screen"
  route_path="$viewName"
  screen_class="${capitalizedViewName}Screen"
  binding_class="${capitalizedViewName}Binding"
  import_path="../views/$viewName/screen/${viewName}_screen.dart"

  # Add route and page entries
  add_route_constant "$route_const_name" "$route_path"
  add_getpage_entry "$route_const_name" "$screen_class" "$binding_class" "$import_path"

  echo "✅ View '$capitalizedViewName' created and routing updated successfully!"
done
