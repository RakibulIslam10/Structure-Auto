#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

read -p "প্রজেক্টের নাম দিন: " project_name

echo -e "${GREEN}Flutter প্রজেক্ট তৈরি করা হচ্ছে...${NC}"
flutter create $project_name
cd $project_name

echo -e "${GREEN}Custom structure বসানো হচ্ছে...${NC}"
curl -sSL https://raw.githubusercontent.com/RakibulIslam10/Structure-Auto/main/my_structure.sh | bash

echo -e "${GREEN}Android Studio ওপেন করা হচ্ছে...${NC}"
"/c/Program Files/Android/Android Studio1/bin/studio64.exe" .
echo -e "${GREEN}সকল কাজ সম্পন্ন হয়েছে!${NC}"
