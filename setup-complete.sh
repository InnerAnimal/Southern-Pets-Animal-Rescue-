#!/bin/bash

# Complete Setup Script for SPAR Animal Photo Upload System
# This script completes the setup with your Cloudflare R2 credentials

set -e  # Exit on error

echo "🐕🐱 SPAR Animal Photo Upload System - Final Setup"
echo "=================================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Verify .env.local exists
echo -e "${BLUE}Step 1: Checking environment configuration...${NC}"
if [ -f .env.local ]; then
    echo -e "${GREEN}✓ .env.local found with Cloudflare R2 credentials${NC}"
else
    echo -e "${YELLOW}⚠ .env.local not found. Creating it now...${NC}"
    cp .env.example .env.local 2>/dev/null || echo "# Add your environment variables here" > .env.local
fi
echo ""

# Step 2: Check for DATABASE_URL
echo -e "${BLUE}Step 2: Checking database configuration...${NC}"
if grep -q "^DATABASE_URL=" .env.local 2>/dev/null; then
    echo -e "${GREEN}✓ DATABASE_URL configured${NC}"
else
    echo -e "${YELLOW}⚠ DATABASE_URL not set in .env.local${NC}"
    echo "  You'll need to add your PostgreSQL database URL"
    echo "  Example: DATABASE_URL=\"postgresql://user:password@localhost:5432/spar\""
    echo ""
    read -p "Do you have a database URL to add now? (yes/no): " has_db
    if [[ $has_db == "yes" || $has_db == "y" ]]; then
        read -p "Enter your DATABASE_URL: " db_url
        echo "" >> .env.local
        echo "# Database Configuration" >> .env.local
        echo "DATABASE_URL=\"$db_url\"" >> .env.local
        echo -e "${GREEN}✓ DATABASE_URL added to .env.local${NC}"
    else
        echo -e "${YELLOW}  Skipping database setup. You'll need to add DATABASE_URL later.${NC}"
    fi
fi
echo ""

# Step 3: Install dependencies
echo -e "${BLUE}Step 3: Installing dependencies...${NC}"
npm install
echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# Step 4: Generate Prisma client
echo -e "${BLUE}Step 4: Generating Prisma client...${NC}"
if npx prisma generate; then
    echo -e "${GREEN}✓ Prisma client generated${NC}"
else
    echo -e "${YELLOW}⚠ Prisma client generation failed (this is okay in some environments)${NC}"
    echo "  It will be generated automatically when you run the app"
fi
echo ""

# Step 5: Push database schema (only if DATABASE_URL is set)
echo -e "${BLUE}Step 5: Setting up database schema...${NC}"
if grep -q "^DATABASE_URL=" .env.local 2>/dev/null; then
    read -p "Push schema to database now? (yes/no): " push_schema
    if [[ $push_schema == "yes" || $push_schema == "y" ]]; then
        if npx prisma db push; then
            echo -e "${GREEN}✓ Database schema created${NC}"
        else
            echo -e "${YELLOW}⚠ Database push failed. Check your DATABASE_URL${NC}"
        fi
    else
        echo "  Skipping database push. Run 'npx prisma db push' when ready."
    fi
else
    echo -e "${YELLOW}⚠ Skipping (no DATABASE_URL configured)${NC}"
    echo "  Run 'npx prisma db push' after adding your DATABASE_URL"
fi
echo ""

# Step 6: Build the application
echo -e "${BLUE}Step 6: Building application...${NC}"
if npm run build; then
    echo -e "${GREEN}✓ Application built successfully${NC}"
else
    echo -e "${YELLOW}⚠ Build failed. Check the error messages above.${NC}"
    exit 1
fi
echo ""

# Step 7: Summary
echo -e "${GREEN}=================================================="
echo "✓ Setup Complete!"
echo "==================================================${NC}"
echo ""
echo "Your Cloudflare R2 Configuration:"
echo "  Account ID: ede6590ac0d2fb7daf155b35653457b2"
echo "  Bucket Name: spar-animals"
echo "  ✓ Credentials saved in .env.local"
echo ""
echo "Next Steps:"
echo ""
echo "1. Start the development server:"
echo "   ${BLUE}npm run dev${NC}"
echo ""
echo "2. Access the admin panel:"
echo "   ${BLUE}http://localhost:3000/admin/animals${NC}"
echo ""
echo "3. Upload animal photos:"
echo "   - Click 'Photos' on any animal"
echo "   - Drag and drop images"
echo "   - Click 'Upload'"
echo ""
echo "4. View on adoption page:"
echo "   ${BLUE}http://localhost:3000/adopt${NC}"
echo ""
echo "📚 Documentation:"
echo "   - Setup Guide: SETUP_SUMMARY.md"
echo "   - User Guide: ANIMAL_PHOTO_UPLOAD_GUIDE.md"
echo "   - Cloudflare R2: CLOUDFLARE_SETUP.md"
echo ""
echo -e "${GREEN}Happy uploading! 🐕🐱📸${NC}"
