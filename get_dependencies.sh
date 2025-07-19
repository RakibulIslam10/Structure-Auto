#!/usr/bin/env bash

echo "📦 Adding dependencies to pubspec.yaml..."

# Step 1: Check if pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
    echo "❌ pubspec.yaml not found in current directory!"
    exit 1
fi

# Step 2: Inject dependencies directly into pubspec.yaml
awk '
BEGIN {
  copy = 1
}
/^dependencies:/ {
  print
  copy = 0
  next
}
/^[a-zA-Z]/ && !copy {
  print "  get:"
  print "  http:"
  print "  flutter_screenutil: ^5.9.3"
  print "  get_storage"
  print "  flutter_svg:"
  print "  loading_animation_widget:"
  print "  pin_code_fields:"
  print "  flutter_animate:"
  print "  intl:"
  print "  cached_network_image:"
  print "  google_sign_in: ^6.3.0"
 
  copy = 1
}
{ if (copy) print }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml

# Step 3: Run flutter pub get
flutter pub get

echo "✅ Dependencies added and fetched successfully!"
