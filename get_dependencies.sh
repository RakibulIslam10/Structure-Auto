#!/usr/bin/env bash
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
  print "  get_storage"
  print "  flutter_svg"
  print "  loading_animation_widget"
  print "  pin_code_fields"
  print "  flutter_animate"
  print "  intl: ^0.18.1"
  print "  cached_network_image"
  copy = 1
}
{ if (copy) print }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml

# Step 4: Run flutter pub get
flutter pub get

echo "✅ Dependencies added and fetched successfully!"
