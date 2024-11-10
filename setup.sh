#!/bin/bash

source .env

PYTHON_SCRIPT="bkg_remove.py"

# Step 1: Check where Python is installed
echo -e "${LB}[INFO]${NC} Checking if Python3 is installed..."
PYTHON_PATH=$(which python3)

if [ -z "$PYTHON_PATH" ]; then
  echo -e "${DR}[ERROR]${NC} Python3 is not installed. Please install Python3 and try again."
  exit 1
fi

echo -e "${LB}[INFO]${NC} Python3 found at: ${LG}$PYTHON_PATH${NC}"

# Step 2: Create a virtual environment
echo -e "${LB}[INFO]${NC} Creating virtual environment..."
python3 -m venv myenv
echo -e "${LG}[SUCCESS]${NC} Virtual environment 'myenv' created."

# Activate the virtual environment
source myenv/bin/activate

# Step 3: Install dependencies from requirements.txt
if [ ! -f "requirements.txt" ]; then
  echo -e "${DR}[ERROR]${NC} requirements.txt not found! Please create a requirements.txt file."
  deactivate
  exit 1
fi

echo -e "${LB}[INFO]${NC} Installing dependencies from requirements.txt..."
pip install -r requirements.txt
echo -e "${LG}[SUCCESS]${NC} Dependencies installed."

if [ ! -f "$PYTHON_SCRIPT" ]; then
  echo -e "${DR}[ERROR]${NC} ${PYTHON_SCRIPT} not found! Please make sure the Python script is in the same directory."
  deactivate
  exit 1
fi

# Update the shebang in the Python script
echo -e "${LB}[INFO]${NC} Adding Python path to the shebang in ${PYTHON_SCRIPT}..."
sed -i.bak '1i\
#!'"$PYTHON_PATH" "$PYTHON_SCRIPT"
echo -e "${LG}[SUCCESS]${NC} Shebang updated in ${PYTHON_SCRIPT}."
chmod +x $PYTHON_SCRIPT

#Deactivate the virtual environment after setup
deactivate
echo -e "${LB}[INFO]${NC} Virtual environment deactivated."

# Completion message
echo -e "${LG}[SUCCESS]${NC} Setup complete! Use 'source myenv/bin/activate' to activate your virtual environment."
