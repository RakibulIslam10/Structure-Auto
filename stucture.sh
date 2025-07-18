#!/bin/bash
# Fix Windows line endings if present (run once on this script file)
sed -i 's/\r$//' "$

#START SHEL SCRIPT>>

BASE_DIR="lib"

echo "📁 Creating Your Custom Stucture ..."

# Bindings
mkdir -p $BASE_DIR/bind
touch $BASE_DIR/bind/home_binding.dart
touch $BASE_DIR/bind/next_binding.dart
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


### ✅ Dependencies Section (SAFE)

echo "🔧 Adding dependencies safely to pubspec.yaml..."
flutter pub add cached_network_image
flutter pub add image_picker



# Run flutter pub get
echo "📦 Running flutter pub get..."
flutter pub get








# FOLDER IN FILE
touch $BASE_DIR/views/home/screens/navigation_screen_mobile.dart
touch $BASE_DIR/views/home/screens/navigation_screen.dart





# CODE IN MY FILE 




echo "✅ Your Structure And All File Folder Created Successfully!"



