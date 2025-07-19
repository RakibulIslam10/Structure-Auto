#!/usr/bin/env bash

echo "📦 Checking and adding missing dependencies to pubspec.yaml..."

# Step 1: Check if pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
    echo "❌ pubspec.yaml not found in current directory!"
    exit 1
fi

# Step 2: List of required dependencies
declare -A dependencies=(
  ["get"]=""
  ["http"]=""
  ["flutter_screenutil"]="^5.9.3"
  ["get_storage"]=""
  ["flutter_svg"]=""
  ["loading_animation_widget"]=""
  ["pin_code_fields"]=""
  ["flutter_animate"]=""
  ["intl"]=""
  ["cached_network_image"]=""
  ["google_sign_in"]="^6.3.0"
)

# Step 3: Read existing pubspec.yaml content
existing_deps=$(grep -Po '^\s{2}(\w+):' pubspec.yaml | sed 's/ //g' | sed 's/://g')

# Step 4: Create insertion block with missing dependencies only
insertion=""
for dep in "${!dependencies[@]}"; do
  if echo "$existing_deps" | grep -q "^$dep$"; then
    echo "⚠️  $dep already exists, skipping..."
  else
    version="${dependencies[$dep]}"
    if [[ -n "$version" ]]; then
      insertion+="  $dep: $version\n"
    else
      insertion+="  $dep:\n"
    fi
  fi
done

# If no new dependency, skip modification
if [[ -z "$insertion" ]]; then
  echo "✅  All dependencies already present. Nothing to add."
  exit 0
fi

# Step 5: Inject after `dependencies:` block
awk -v insertion="$insertion" '
  BEGIN { done = 0 }
  /^dependencies:/ {
    print
    if (!done) {
      printf "%s", insertion
      done = 1
    }
    next
  }
  { print }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml

# Step 6: Run flutter pub get
flutter pub get

echo "✅  Missing dependencies added successfully! >>> RUN-- flutter pub get"
