#!/bin/bash

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

add_dependency() {
  local package="$1"
  local version="$2"

  if grep -q "$package:" pubspec.yaml; then
    echo "🔁 $package already exists. Skipping..."
  else
    if grep -q "^dependencies:" pubspec.yaml; then
      echo "➕ Adding $package: $version under dependencies"
      sed -i "/^dependencies:/a\  $package: $version" pubspec.yaml
    else
      echo "⚠️ 'dependencies:' section not found. Creating it now..."
      echo -e "\ndependencies:\n  $package: $version" >> pubspec.yaml
    fi
  fi
}

add_dependency "get" "^4.6.6"
add_dependency "flutter_svg" "^2.0.7"
add_dependency "google_fonts" "^6.1.0"

# Run flutter pub get
echo "📦 Running flutter pub get..."
flutter pub get








# FOLDER IN FILE
touch $BASE_DIR/views/home/screens/navigation_screen_mobile.dart
touch $BASE_DIR/views/home/screens/navigation_screen.dart





# CODE IN MY FILE 




echo "✅ Your Structure And All File Folder Created Successfully!"



