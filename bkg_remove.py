
import argparse
from PIL import Image
from rembg import remove
import tempfile
import os
import platform

def remove_background(input_path):
    # Open image and remove background
    inp = Image.open(input_path)
    output = remove(inp)
    return output

def preview_image(img):
    # Save the processed image temporarily for preview
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp_file:
        img.save(tmp_file.name)
        
        # Determine the command based on the OS
        if platform.system() == "Darwin":  # macOS
            os.system(f'open "{tmp_file.name}"')
        elif platform.system() == "Linux":
            os.system(f'xdg-open "{tmp_file.name}"')
        elif platform.system() == "Windows":
            os.system(f'start "{tmp_file.name}"')
        else:
            print("Preview not supported on this OS.")

def main():
    # Setup argument parser
    parser = argparse.ArgumentParser(description="Remove background from an image.")
    parser.add_argument("input", help="Path to the input image")
    parser.add_argument("-o", "--output", help="Path to save the output image (optional)", default=None)
    
    args = parser.parse_args()
    
    # Remove background
    print("Processing image...")
    processed_img = remove_background(args.input)
    
    # Preview the image
    print("Previewing the processed image. Close the preview to continue.")
    preview_image(processed_img)
    
    # Save option
    if args.output:
        processed_img.save(args.output)
        print(f"Image saved to {args.output}")
    else:
        save_path = input("Enter a path to save the processed image (or press Enter to skip saving): ")
        if save_path:
            processed_img.save(save_path)
            print(f"Image saved to {save_path}")
        else:
            print("Image not saved.")

if __name__ == "__main__":
    main()
