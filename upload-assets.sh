#!/bin/bash

BUCKET_NAME="galaxy-app-dev"  # replace with your actual bucket name
DIST_DIR="dist"

echo "Uploading files from $DIST_DIR to s3://$BUCKET_NAME"

# Upload index.html (no cache)
aws s3 cp "$DIST_DIR/index.html" "s3://$BUCKET_NAME/index.html" --recursive --acl public-read \
  --cache-control "no-cache, no-store, must-revalidate" \
  --content-type "text/html"

# Upload JS files
find "$DIST_DIR" -name "*.js" | while read file; do
  aws s3 cp "$file" "s3://$BUCKET_NAME/${file#$DIST_DIR/}" --recursive --acl public-read \
    --cache-control "public, max-age=31536000, immutable" \
    --content-type "application/javascript"
done

# Upload CSS files
find "$DIST_DIR" -name "*.css" | while read file; do
  aws s3 cp "$file" "s3://$BUCKET_NAME/${file#$DIST_DIR/}" --recursive --acl public-read \
    --cache-control "public, max-age=31536000, immutable" \
    --content-type "text/css"
done

# Upload images
find "$DIST_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.svg" \) | while read file; do
  aws s3 cp "$file" "s3://$BUCKET_NAME/${file#$DIST_DIR/}" --recursive --acl public-read \
    --cache-control "public, max-age=31536000"
done

echo "✅ Upload complete."
