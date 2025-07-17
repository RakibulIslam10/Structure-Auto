#!/bin/bash

echo "🚀 Creating Flutter project structure with GetX architecture..."

# Define folder list
folders=(
  views
  controllers
  bindings
  widgets
  models
  services
  utils
  constants
)

# Create each folder and add placeholder .dart file
for folder in "${folders[@]}"; do
  mkdir -p "lib/$folder"
  echo "// Placeholder for $folder" > "lib/$folder/temp.dart"
done

# Create actual constant files
touch lib/constants/custom_colors.dart
touch lib/constants/dimensions.dart
touch lib/constants/sizes.dart

echo "✅ Structure created successfully!"

echo
echo "🔗 Downloading and running remote code from GitHub..."
echo "<>........................................................................Creating Your Code.............................................................."

# # Download and run codehere.sh from GitHub
# curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/main/codehere.sh | bash

echo "----------------------------------------------------------------- ✅ Done ----------------------------------------------------------------------"
