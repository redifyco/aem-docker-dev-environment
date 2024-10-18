#!/bin/bash

# Check if the runmode was passed as an argument
if [ -z "$1" ]; then
  echo "Error: no runmode specified. Use 'author' or 'publish'."
  exit 1
fi

RUNMODE=$1

# Set the AEM installation path
AEM_DIR=/aem

# Check if the crx-quickstart directory exists
if [ ! -d "$AEM_DIR/crx-quickstart" ]; then
  echo "No crx-quickstart directory found, creating a new AEM instance..."
  mkdir -p "$AEM_DIR/crx-quickstart"
fi

# Set the port and JAR file name based on the runmode
if [ "$RUNMODE" == "author" ]; then
  PORT=4502
  JAR_FILE="aem-author-p4502.jar"
elif [ "$RUNMODE" == "publish" ]; then
  PORT=4503
  JAR_FILE="aem-publish-p4503.jar"
else
  echo "Error: invalid runmode. Use 'author' or 'publish'."
  exit 1
fi

# Rename the JAR file based on the runmode
if [ -f "$AEM_DIR/aem-quickstart.jar" ]; then
  echo "Renaming aem-quickstart.jar to $JAR_FILE..."
  mv $AEM_DIR/aem-quickstart.jar $AEM_DIR/$JAR_FILE
fi

# Check and copy .zip files from the install folder
INSTALL_DIR="$AEM_DIR/crx-quickstart/install"
SOURCE_INSTALL_DIR="/aem/install"

# Create the install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
  echo "The install directory doesn't exist, creating it..."
  mkdir -p "$INSTALL_DIR"
fi

# Copy .zip files from the source folder to the install folder, if they don't already exist
for ZIP_FILE in "$SOURCE_INSTALL_DIR"/*.zip; do
  if [ -f "$ZIP_FILE" ]; then
    FILE_NAME=$(basename "$ZIP_FILE")
    if [ ! -f "$INSTALL_DIR/$FILE_NAME" ]; then
      echo "File $FILE_NAME does not exist, copying it from the install folder..."
      cp "$ZIP_FILE" "$INSTALL_DIR/"
    else
      echo "File $FILE_NAME already exists."
    fi
  else
    echo "No .zip files found in the source folder."
  fi
done

# Remove the configuration folder (if needed)
rm -rf "$AEM_DIR/crx-quickstart/launchpad/config/org/apache/sling/jcr/repoinit"

# Start AEM with the specified runmode and port
echo "Starting AEM in $RUNMODE mode on port $PORT..."
java -jar $AEM_DIR/$JAR_FILE -r $RUNMODE -p $PORT -nofork
