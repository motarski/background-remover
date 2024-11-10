pip install -r requrements.txt
# Background Remover CLI

A simple Python CLI tool to remove backgrounds from images.

## Requirements

- Python 3
- `pip` package manager
- Install dependencies in `requirements.txt`

## Setup

1. Clone the repository and navigate into the project directory.
2. Run the environment setup script:

```bash
   ./setup.sh
```
### This script will:

- Check for Python 3.
- Set up a virtual environment (myenv).
- Install dependencies listed in requirements.txt.
- Update the Python script with a shebang for direct execution.

Activate the virtual environment
```bash
   source myenv/bin/activate
```

## Usage
To run the background remover

```bash
python bkg_remove.py <path/to/input/image> [-o <path/to/output/image>]
```

Example:
```bash
python bkg_remove.py background.jpg -o removed_background.png
```

This command will process background.jpg, preview the output, and save it as result.png

I added platform detection to the script to handle different operating systems when outputting the result.

## Before and After
In the `images` directory you can find the before and after images example.