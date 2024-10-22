# WAVE File Reader in MIPS Assembly

## Overview

This program is a MIPS assembly application that reads and displays metadata from a WAVE audio file. It prompts the user for a WAVE file name and its size, then opens the file, extracts key properties from the WAVE header, and displays information such as the number of channels, sample rate, byte rate, and bits per sample.

## Features

1. **File Input:** 
   - Prompts the user to enter the name and size of a WAVE file.
   
2. **WAVE Header Reading:**
   - Extracts and displays important metadata from the WAVE file's header, including:
     - Number of channels.
     - Sample rate.
     - Byte rate (calculated from sample rate, number of channels, and bits per sample).
     - Bits per sample.

3. **Error Handling:**
   - Removes any trailing newline characters from the input file name to ensure smooth file opening.

## Files

- **`main.asm`**: The MIPS assembly program file.

## Prerequisites

1. **SPIM/QtSPIM MIPS Simulator:**
   - The program is designed to run on a MIPS simulator like SPIM or QtSPIM. You can download and install QtSPIM from the [official website](https://sourceforge.net/projects/spimsimulator/).

2. **WAVE File:**
   - A `.wav` file with a standard WAVE header (44 bytes) to test the program. The file name and size in bytes will be required for input.

## How to Run

1. **Open the QtSPIM Simulator:**
   - Launch the QtSPIM or SPIM simulator on your computer.

2. **Load the Program:**
   - Open the MIPS assembly file (`main.asm`) in the QtSPIM environment.
   - Load the program into the simulator.

3. **Run the Program:**
   - Run the program by clicking the "Run" button or typing `run` in the command window.

4. **Enter the File Name and Size:**
   - When prompted, enter the name of the WAVE file (ensure it's in the same directory as the simulator or provide a full path).
   - Enter the size of the file (in bytes) when prompted.

5. **View Output:**
   - The program will display:
     - Number of channels in the WAVE file.
     - Sample rate.
     - Byte rate (calculated).
     - Bits per sample.

## Program Breakdown

1. **Data Section:**
   - `file_Name`: Prompt asking the user to enter a file name.
   - `file_Size`: Prompt asking for the file size in bytes.
   - `infoHeader`: Information header string for displaying WAVE metadata.
   - `name`: Space to store the input file name.
   - `size`: Space to store the file size.
   - Output strings for displaying the number of channels, sample rate, byte rate, and bits per sample.

2. **Text Section (Program Execution):**
   - **Input Handling:** The program prompts the user to input a file name and size.
   - **File Handling:** It opens the specified file in read-only mode.
   - **WAVE Header Parsing:** Reads the first 44 bytes of the file (WAVE header) to extract and display:
     - Number of channels (2 bytes starting at byte 22).
     - Sample rate (4 bytes starting at byte 24).
     - Byte rate (calculated based on sample rate, number of channels, and bits per sample).
     - Bits per sample (2 bytes starting at byte 34).
   - **File Closing:** Closes the file after reading and outputting the required information.

3. **Exit:**
   - The program gracefully terminates after displaying the WAVE file metadata.

## Example Output

After running the program and entering the file name and size, the output will look something like this:

```
Enter a wave file name:
audio.wav
Enter the file size (in bytes):
123456

Information about the wave file:
================================
Number of channels: 2
Sample rate: 44100
Byte rate: 176400
Bits per sample: 16
```

## Notes

- Ensure that the `.wav` file you provide follows the standard WAVE header format for accurate output.
- If the file name is too long, ensure that it's within 100 characters to avoid buffer overflow issues.


