#!/bin/bash

# Show your Raspberry Pi OS version.
cat /etc/os-release

# Update packages on your Raspberry Pi OS.
sudo apt-get update

# Check your Python version. You should have Python 3.7 or later.
python3 --version

# Install virtualenv and upgrade pip.
python3 -m pip install --user --upgrade pip
python3 -m pip install --user virtualenv

# Create a Python virtual environment for the TFLite samples (optional but strongly recommended)
python3 -m venv ~/detect

# Run this command whenever you open a new Terminal window/tab to activate the environment.
source ~/detect/bin/activate

# Clone the TensorFlow example repository with the TFLite Raspberry Pi samples.
git clone https://github.com/Rahuldee/Edge-AI/Lab-9
cd Lab-9

# Install dependencies required by the sample
pip3 install tflite-runtime
pip3 install opencv-python

# Run the object detection sample
