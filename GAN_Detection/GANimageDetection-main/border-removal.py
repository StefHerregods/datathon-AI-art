import PIL.ImageChops as ImageChops
from PIL import Image
import numpy as np

# Steps:
# 1 - create copy of image
# 2 - make all white/gray pixels of copy black (white_to_black)
# 3 - identify black banners in copy (trim)
# 4 - remove black banners from original image

# Loading data
image = Image.open("images_real/0.png")

# Trim function
def trim(image, image_copy):
    background = Image.new(image_copy.mode, image_copy.size,
                           (0, 0, 0))  # Create black square with same size as original painting
    diff = ImageChops.difference(image_copy, background)  # Find difference between black square and painting
    diff = ImageChops.add(diff, diff, 2.0, -100)  #
    bbox = diff.getbbox()
    if bbox:
        return image.crop(bbox)


# Make white letters in banner black
def white_to_black(image):
    width, height = image.size
    print(image.size)
    # Loop through every pixel and change white pixels to black
    for x in range(width):
        for y in range(height):
            # Get pixel value
            pixel = image.getpixel((x, y))
            # Check if pixel is white/gray (includes white text)
            if pixel == (255, 255, 255) or pixel == 255 or (pixel[0] == pixel[1] == pixel[2]):
                # Set pixel to black
                image.putpixel((x, y), (0, 0, 0))
    image.show()


image_copy = image.copy()
white_to_black(image_copy)
image_new = trim(image, image_copy)
print('Before:')
image.show()
print('After:')
image_new.show()