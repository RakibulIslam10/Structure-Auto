#!/usr/bin/env bash
sed -i 's/\r$//' "$0"

BASE_DIR="lib"

echo "📁 Creating Your Custom Structure ..."

mkdir -p $BASE_DIR/bind
touch $BASE_DIR/bind/home_binding.dart
touch $BASE_DIR/bind/next_binding.dart
touch $BASE_DIR/bind/splash_bindings.dart

mkdir -p $BASE_DIR/core/api
mkdir -p $BASE_DIR/core/helpers
mkdir -p $BASE_DIR/core/languages
mkdir -p $BASE_DIR/core/themes
mkdir -p $BASE_DIR/core/utils

mkdir -p $BASE_DIR/res
touch $BASE_DIR/res/assets.dart

mkdir -p $BASE_DIR/routes
touch $BASE_DIR/routes/pages.dart
touch $BASE_DIR/routes/routes.dart

mkdir -p $BASE_DIR/views/firebase
mkdir -p $BASE_DIR/views/home/controller
mkdir -p $BASE_DIR/views/home/model
mkdir -p $BASE_DIR/views/home/screens
mkdir -p $BASE_DIR/views/splash
touch $BASE_DIR/views/splash/splash_screen.dart

mkdir -p $BASE_DIR/widgets
touch $BASE_DIR/widgets/initial.dart

echo "🔧 Adding dependencies to pubspec.yaml..."
awk '
  BEGIN {
    print "dependencies:"
    print "  flutter:"
    print "    sdk: flutter"
    print "  get: ^4.6.6"
    print "  image_picker: ^1.1.2"
    exit
  }
' > temp_deps.yaml

echo "📦 Running flutter pub get..."
flutter pub get

touch $BASE_DIR/views/home/screens/navigation_screen_mobile.dart
touch $BASE_DIR/views/home/screens/navigation_screen.dart

echo "✅ Your Structure And All File Folder Created Successfully!"
