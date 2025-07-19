#!/bin/bash

echo "📦 Adding dependencies to pubspec.yaml..."

# Step 1: Check if pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
    echo "❌ pubspec.yaml not found in current directory!"
    exit 1
fi

# Step 2: Backup pubspec.yaml
cp pubspec.yaml pubspec_backup.yaml
echo "📝 pubspec.yaml backed up as pubspec_backup.yaml"

# Step 3: Inject dependencies directly
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
  print "  get: ^4.7.2"
  print "  http: ^0.13.5"
  print "  shared_preferences: ^2.2.2"
  print "  google_fonts: ^6.1.0"
  print "  flutter_svg: ^2.0.7"
  print "  connectivity_plus: ^5.0.2"
  print "  cached_network_image: ^3.3.1"
  print "  intl: ^0.18.1"
  copy = 1
}
{ if (copy) print }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml

# Step 4: Run flutter pub get
flutter pub get

echo "✅ Dependencies added and fetched successfully!"
