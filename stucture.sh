#!/bin/bash

# Function: capitalize first letter
capitalize() {
  echo "$1" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }'
}

BASE_DIR="lib"
ROUTES_DIR="$BASE_DIR/routes"

mkdir -p "$ROUTES_DIR"

# Create routes.dart if missing
if [ ! -f "$ROUTES_DIR/routes.dart" ]; then
  cat <<EOF > "$ROUTES_DIR/routes.dart"
class Routes {
  static var list = RoutePageList.list;
  // Route constants will be added here
}
EOF
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
fi

# Add route constant function
add_route_constant() {
  local route_const_name=$1
  local route_path=$2
  local file="$ROUTES_DIR/routes.dart"

  if ! grep -q "static const $route_const_name" "$file"; then
    sed -i "/^}/i \  static const $route_const_name = '/$route_path';" "$file"
  fi
}

# Add GetPage entry function
add_getpage_entry() {
  local route_const_name=$1
  local screen_class=$2
  local binding_class=$3
  local import_path=$4
  local file="$ROUTES_DIR/pages.dart"

  if ! grep -q "import '$import_path';" "$file"; then
    sed -i "1i import '$import_path';" "$file"
  fi

  if ! grep -q "name: Routes.$route_const_name" "$file"; then
    sed -i "/];/i \
    GetPage(\
      name: Routes.$route_const_name,\
      page: () => const $screen_class(),\
      binding: $binding_class(),\
      transition: Transition.rightToLeft,\
    )," "$file"
  fi
}

for viewName in "$@"; do
  capitalizedViewName=$(capitalize "$viewName")
  base_dir="$BASE_DIR/views/$viewName"
  
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

  # Binding file with proper code
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
    echo "🔧 Created binding with code: $binding_file"
  else
    echo "⚠️ Binding already exists: $binding_file"
  fi

  route_const_name="${viewName}Screen"
  route_path="$viewName"
  screen_class="${capitalizedViewName}Screen"
  binding_class="${capitalizedViewName}Binding"
  import_path="../views/$viewName/screen/${viewName}_screen.dart"

  add_route_constant "$route_const_name" "$route_path"
  add_getpage_entry "$route_const_name" "$screen_class" "$binding_class" "$import_path"

  echo "✅ View '$capitalizedViewName' created and routing updated successfully!"
done
