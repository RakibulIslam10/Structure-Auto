#!/bin/bash

echo "🚀 Creating project structure..."

mkdir -p lib/views
mkdir -p lib/controllers
mkdir -p lib/bindings
mkdir -p lib/widgets
mkdir -p lib/models
mkdir -p lib/services
mkdir -p lib/utils
mkdir -p lib/constants

touch lib/constants/custom_colors.dart
touch lib/constants/dimensions.dart
touch lib/constants/sizes.dart

echo "✅ Structure created successfully!"

echo "<>..................................................Creating Your Code --------------------------------------------------------------------------------"

# GitHub থেকে codehere.sh নামের স্ক্রিপ্ট ডাউনলোড করে রান করানো
curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/main/codehere.sh | bash

echo "--------------------------------------------------------done--------------------------------------------------------------------"
