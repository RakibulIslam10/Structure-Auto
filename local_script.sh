#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

read -p "Enter Your Project Name: " project_name

echo -e "${GREEN}Flutter Project Crating Start...${NC}"
flutter create $project_name
cd $project_name

echo -e "${GREEN}Custom structure Add Your Custom Structure...${NC}"
curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/main/my_structure.sh | bash

echo -e "${GREEN}Android Studio Android Studio Opeing...${NC}"
"/c/Program Files/Android/Android Studio1/bin/studio64.exe" .
echo -e "${GREEN}All Is Okay Now You are Ready ...!${NC}"
