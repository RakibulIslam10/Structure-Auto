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

# Views
mkdir -p $BASE_DIR/views/firebase
mkdir -p $BASE_DIR/views/home/controller
mkdir -p $BASE_DIR/views/home/model
mkdir -p $BASE_DIR/views/home/screens
mkdir -p $BASE_DIR/views/splash
touch $BASE_DIR/views/splash/splash_screen.dart

# Widgets
mkdir -p $BASE_DIR/widgets
touch $BASE_DIR/widgets/initial.dart

# Main entry
touch $BASE_DIR/main.dart
touch $BASE_DIR/initial.dart
echo "✅  Your Structure All File Folder Created Successfully!"

# FOLDER IN FILE
#touch $BASE_DIR/views/home/screens/navigation_screen_mobile.dart
#touch $BASE_DIR/views/home/screens/navigation_screen.dart

curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/refs/heads/main/get_dependencies.sh | bash

