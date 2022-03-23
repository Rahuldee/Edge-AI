#!/bin/bash

# Show your Raspberry Pi OS version.
cat /etc/os-release

# Update packages on your Raspberry Pi OS.
sudo apt-get update
sudo apt-get install python3-venv

# Check your Python version. You should have Python 3.7 or later.
python3 --version

# Install virtualenv and upgrade pip.
python3 -m pip install --user --upgrade pip
#python3 -m pip install --user virtualenv

# Create a Python virtual environment for the TFLite samples (optional but strongly recommended)
python3 -m venv ~/tflite

# Run this command whenever you open a new Terminal window/tab to activate the environment.
source ~/tflite/bin/activate

# Clone the TensorFlow example repository with the TFLite Raspberry Pi samples.

# Install dependencies required by the sample
python3 -m pip install tflite-runtime

# Run the object detection sample
