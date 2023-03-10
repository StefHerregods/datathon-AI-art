import os
import numpy as np
from PIL import Image, ImageFilter, ImageStat, ImageColor
import pandas as pd

RUN = True

#### Functions
# Edge detection scoring
def edge_score(img):
    image = Image.open(img)
    image = image.convert("L")
    edges = image.filter(ImageFilter.FIND_EDGES) # 3x3 Laplacian filter
    return np.mean(edges)

# Saturation score
def sat_score(img):
    image = Image.open(img)
    hsv_image = image.convert("HSV")
    hsv = np.array(hsv_image)
    saturations = hsv[:, :, 1]
    return np.mean(saturations)

# Blur scoring
#def blur_score(img):

## Low-level features
# Contrast scoring
def contrast_score(img):
    image = Image.open(img)
    image = image.convert("L")
    stats = ImageStat.Stat(image)
    return stats.stddev[0]

# Brightness scoring
def bright_score(img):
    image = Image.open(img)
    image = image.convert("L")
    stats = ImageStat.Stat(image)
    return stats.mean[0]


# Remove first n characters from string
def remove_chars(a_string, number_to_remove):
    return a_string[number_to_remove:]



# Load all images in folder
path = "../GAN_Detection/GANimageDetection-main/images_real/"
images = list(os.listdir(path))

# Create rows for dataframe
rows = []


# Edge scores for all images
if RUN:

    # Loop over all images and extract features
    for i in images:

        # Store image id
        id = i[:-4]
        print(id)

        # Calculate all score
        edge = edge_score(path + i)
        contrast = contrast_score(path + i)
        brightness = bright_score(path + i)
        saturation = sat_score(path + i)

        # Calculate
        rows.append([id, edge, contrast, brightness, saturation])
        # print("cat_" + str(id) + " img_" + str(img) +
        #       " Edge: " + str(edge) +
        #       " Contrast: " + str(contrast) +
        #       " Brightness: " + str(brightness) +
        #       " Saturation: " + str(saturation))

    # Export dataframe
    df = pd.DataFrame(rows, columns=["id", "edge_score", "contrast_score", "brightness_score", "saturation_score"])
    df.to_csv("output/image_features_real.csv", index=False)

