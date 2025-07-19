#!/usr/bin/env bash
set -e  # Error হলে স্ক্রিপ্ট থামবে

BASE_DIR="lib"

echo "📁 Creating Your Custom Structure ..."

# Bindings
mkdir -p "$BASE_DIR/bind"
touch "$BASE_DIR/bind/splash_bindings.dart"

# Core folders একসাথে
mkdir -p "$BASE_DIR/core"/{api,helpers,languages,themes,utils}

# Resources
mkdir -p "$BASE_DIR/res"
touch "$BASE_DIR/res/assets.dart"

# Routes
mkdir -p "$BASE_DIR/routes"
touch "$BASE_DIR/routes"/{pages.dart,routes.dart}

# Widgets
mkdir -p "$BASE_DIR/widgets"

# Views: splash
mkdir -p "$BASE_DIR/views/splash"/{controller,screens,widget}
touch "$BASE_DIR/views/splash/screens"/{splash_screen_mobile.dart,splash_screen.dart}

# Views: onboard
mkdir -p "$BASE_DIR/views/onboard"/{controller,screens,widgets}
touch "$BASE_DIR/views/onboard/screens"/{onboard_screen_mobile.dart,onboard_screen.dart}

# Main entry files (brace expansion)
touch "$BASE_DIR"/{main.dart,initial.dart}

# Write part directives inside splash screen files
cat <<EOF > "$BASE_DIR/views/splash/screens/splash_screen_mobile.dart"
part of 'splash_screen.dart';

// hello rakib vai
EOF

cat <<EOF > "$BASE_DIR/views/splash/screens/splash_screen.dart"
part 'splash_screen_mobile.dart';

// hello rakib vai 2
EOF

echo "📥 Running Widgets creation script..."
curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/refs/heads/main/get_widgets.sh | bash

echo "📥 Running Dependencies installation script..."
curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/refs/heads/main/get_dependencies.sh | bash

echo "✅ Your Flutter project structure has been created successfully!"
