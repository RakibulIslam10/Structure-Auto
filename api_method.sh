#!/bin/bash

echo "📁 Creating Custom API Method..."

BASE_DIR="lib"
mkdir -p "$BASE_DIR/core/api/services"
touch "$BASE_DIR/core/api/services/api_request.dart"

echo "✅ Folder created. Writing Dart code..."

cat <<"EOF" > "$BASE_DIR/core/api/services/api_request.dart"
void main() {
  print('Hello from API file!');
}
EOF

echo "✅ Dart file written to: $BASE_DIR/core/api/services/api_request.dart"
