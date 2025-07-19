#!/bin/bash

BASE_DIR="lib"

echo "📁 Creating Your Custom Stucture ..."

# Bindings
mkdir -p $BASE_DIR/bind
touch $BASE_DIR/bind/splash_bindings.dart

# Core folders
mkdir -p $BASE_DIR/core/api
mkdir -p $BASE_DIR/core/helpers
mkdir -p $BASE_DIR/core/languages
mkdir -p $BASE_DIR/core/themes
mkdir -p $BASE_DIR/core/utils

# Resources
mkdir -p $BASE_DIR/res
touch $BASE_DIR/res/assets.dart

# Routes
mkdir -p $BASE_DIR/routes
touch $BASE_DIR/routes/pages.dart
touch $BASE_DIR/routes/routes.dart

# Views and file
mkdir -p $BASE_DIR/views/splash/screens
touch $BASE_DIR/views/splash/screens/splash_screen_mobile.dart
touch $BASE_DIR/views/splash/screens/splash_screen.dart

mkdir -p $BASE_DIR/views/onboard/screens
touch $BASE_DIR/views/onboard/screens/onboard_screen_mobile.dart
touch $BASE_DIR/views/onboard/screens/onboard_screen.dart

# Main entry
touch $BASE_DIR/main.dart
touch $BASE_DIR/initial.dart

# FILE in code
cat <<EOF > "$BASE_DIR/views/splash/screens/splash_screen_mobile.dart"
part of "splash_screen.dart";

//hello rakib vai

EOF

cat <<EOF > "$BASE_DIR/views/splash/screens/splash_screen.dart"
part "splash_screen_mobile.dart";

//hello rakib vai 2

EOF

echo "✅  Your Structure All File Folder Created Successfully!"


curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/refs/heads/main/get_dependencies.sh | bash

