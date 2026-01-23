#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🚀 Frontend Template Initialization${NC}"
echo "========================================"

# Check project name
if [ -z "${1:-}" ]; then
    echo -e "${RED}❌ Error: Project name is required${NC}"
    echo "Usage: ./init-project.sh <project-name>"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_NAME_UNDERSCORE="${PROJECT_NAME//-/_}"

echo -e "${YELLOW}📦 Project name: ${PROJECT_NAME}${NC}"

# Check prerequisites
echo -e "\n${YELLOW}🔍 Checking prerequisites...${NC}"

if ! command -v pre-commit &> /dev/null; then
    echo -e "${RED}❌ pre-commit is required but not installed.${NC}"
    echo "Install with: pip install pre-commit"
    exit 1
fi
echo -e "${GREEN}✓ pre-commit found${NC}"

if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is required but not installed.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Node.js found${NC}"

# Replace placeholders
echo -e "\n${YELLOW}📝 Replacing placeholders...${NC}"

# package.json
if [ -f "package.json" ]; then
    sed -i.bak "s/\"name\": \"frontend-template\"/\"name\": \"${PROJECT_NAME}\"/" package.json
    sed -i.bak "s/\"name\": \"{{project_name}}\"/\"name\": \"${PROJECT_NAME}\"/" package.json
    rm -f package.json.bak
    echo "  ✓ package.json"
fi

# index.html
if [ -f "index.html" ]; then
    sed -i.bak "s/<title>Frontend Template<\/title>/<title>${PROJECT_NAME}<\/title>/" index.html
    sed -i.bak "s/<title>{{project_name}}<\/title>/<title>${PROJECT_NAME}<\/title>/" index.html
    rm -f index.html.bak
    echo "  ✓ index.html"
fi

# docker-build.yml
if [ -f ".github/workflows/docker-build.yml" ]; then
    sed -i.bak "s/{{project_name}}/${PROJECT_NAME_UNDERSCORE}/" .github/workflows/docker-build.yml
    rm -f .github/workflows/docker-build.yml.bak
    echo "  ✓ docker-build.yml"
fi

# Reinitialize git
echo -e "\n${YELLOW}🔄 Reinitializing git repository...${NC}"
rm -rf .git
git init
echo -e "${GREEN}✓ Fresh git repository created${NC}"

# Install pre-commit hooks
echo -e "\n${YELLOW}🪝 Installing pre-commit hooks...${NC}"
pre-commit install
echo -e "${GREEN}✓ Pre-commit hooks installed${NC}"

# Install dependencies
echo -e "\n${YELLOW}📦 Installing dependencies...${NC}"
npm install
echo -e "${GREEN}✓ Dependencies installed${NC}"

# Success
echo ""
echo -e "${GREEN}✅ Project '${PROJECT_NAME}' initialized successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. Start the development server:"
echo "     npm run dev"
echo ""
echo "  2. Make your first commit:"
echo "     git add ."
echo "     git commit -m \"Initial commit\""
echo ""
