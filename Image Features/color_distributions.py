import os
import numpy as np
from PIL import Image, ImageFilter, ImageStat, ImageColor
import pandas as pd
import re

TYPE = "real" # "real" or "fake"

def col_dist(img):
    image = Image.open(img)
    rgb_image = image.convert("RGB")
    rgb = np.array(rgb_image)
    red = rgb[:, :, 0]
    green = rgb[:, :, 1]
    blue = rgb[:, :, 2]
    bands = [red, green, blue]
    image_distribution = []
    for i in bands:
        image_distribution.append(i.reshape(-1))
    return image_distribution


# Natural sorting
# _nsre = re.compile("([0-9]+)")
# def natural_sort_key(s):
#     return [int(text) if text.isdigit() else text.lower()
#             for text in re.split(_nsre, s)]



# Load all images in folder
path = "../GAN_Detection/images_" + str(TYPE) + "/"
#images = list(os.listdir(path))[0:10]
images = ['1.png', '2.png', '3.png', '4.png', '5.png']


# Select category
# cat_no = 100
# cat = list(filter(lambda x: "cat" + str(cat_no) + "_" in x, images))
# cat.sort(key=natural_sort_key)


# alphas = [-0.25, -0.2, -0.15, -0.1, -0.05, -0.015, -0.0025, 0, 0.0025, 0.015, 0.05, 0.1, 0.15, 0.2, 0.25]
#iter = 0

for i in images:
    img_id = (i[:-4])
    print(img_id)
    image = col_dist(path + i)
    col_dict = {"red": image[0], "green": image[1], "blue": image[2], "id":img_id}
    pd.DataFrame(col_dict).to_csv("output/colors/" + str(TYPE) + "img_" + img_id + ".csv", index=False)
