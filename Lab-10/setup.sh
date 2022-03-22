#!/bin/bash

# Show your Raspberry Pi OS version.
cat /etc/os-release

# Add TPU Debian package repository to your system:
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update packages on your Raspberry Pi OS.
sudo apt-get update

#Install the Edge TPU runtime
sudo apt-get install libedgetpu1-std

#install PyCoral as follows
sudo apt-get install python3-pycoral

# Check your Python version. You should have Python 3.7 or later.
python3 --version

# Install virtualenv and upgrade pip.
python3 -m pip install --user --upgrade pip
python3 -m pip install --user virtualenv

# Create a Python virtual environment for the TFLite samples (optional but strongly recommended)
python3 -m venv ~/accelerate

# Run this command whenever you open a new Terminal window/tab to activate the environment.
source ~/accelerate/bin/activate

# Clone the TensorFlow example repository with the TFLite Raspberry Pi samples.
git clone https://github.com/Rahuldee/Edge-AI/Lab-10
cd Lab-10

# Install dependencies required by the sample
pip3 install tflite-runtime
pip3 install Pillow

# Run the object detection sample
