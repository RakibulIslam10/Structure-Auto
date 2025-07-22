#!/bin/bash

echo "📁 Creating Custom API Method..."

BASE_DIR="lib"
mkdir -p "$BASE_DIR/core/api/services"
touch "$BASE_DIR/core/api/services/api_request.dart"

cat <<EOF > "$BASE_DIR/core/api/services/api_request.dart"
void main() {
  print('Hello from API file!');
}
EOF

echo "✅ File created at $BASE_DIR/core/api/services/api_request.dart"
