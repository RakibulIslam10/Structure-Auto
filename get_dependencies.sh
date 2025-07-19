#!/usr/bin/env bash

echo "📦 Adding dependencies to pubspec.yaml..."

# Step 1: Check if pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
    echo "❌ pubspec.yaml not found in current directory!"
    exit 1
fi

# Step 2: Inject dependencies under flutter section
awk '
BEGIN {
  injecting = 0
}
/^dependencies:/ {
  print
  next
}
/^  flutter:/ {
  print
  flutter_found = 1
  next
}
/^  cupertino_icons:/ {
  print
  next
}
/^[^[:space:]]/ && flutter_found && !injecting {
  # Add custom dependencies only once
  print "  get:"
  print "  http:"
  print "  flutter_screenutil: ^5.9.3"
  print "  get_storage:"
  print "  flutter_svg:"
  print "  loading_animation_widget:"
  print "  pin_code_fields:"
  print "  flutter_animate:"
  print "  intl:"
  print "  cached_network_image:"
  print "  google_sign_in: ^6.3.0"
  injecting = 1
}
{ print }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml

# Step 3: Run flutter pub get
flutter pub get

echo "✅  All Dependencies added successfully!  >>> RUN-- flutter pub get"
