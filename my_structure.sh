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


echo "<>..................................................Createting Your Code --------------------------------------------------------------------------------"

cat <<EOF> lib/constants/sizes.dart

import 'package:flutter/cupertino.dart';

class RakibVaiDone extends StatefulWidget {
  const RakibVaiDone({super.key});

  @override
  State<RakibVaiDone> createState() => _RakibVaiDoneState();
}

class _RakibVaiDoneState extends State<RakibVaiDone> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

EOF

echo "--------------------------------------------------------done--------------------------------------------------------------------









