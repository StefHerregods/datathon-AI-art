# Datathon 2023 Case Competition
**Host**: KU Leuven & LStat

**Team**: The Curse of Dimensionality

**Topic**: The code in this repository investigates possible factors that may help an existing GAN model discern between real and artificially generated artworks. The project was awarded *Best Modeling Datathon 2023*.

## Data information: 
The datasets, provided by KU Leuven, can be found in the FilesCSVFormat folder and include:
  - Data scraped from Wikipedia and meta-data of artists and artworks
  - Links to WikiGallery images for each artwork
  - Dataframe of AI generated images using a text-to-image model
  - Information and Entity-Relation diagram on the datasets provided

## Documentation
  - Data Processing: tabular processing and image preprocessing of scripts and dataframes 
  - GAN Detection: outputs using an existing GAN model based on resnet50
  - Image Features: outputs of feature extractions of images 
  - Data Analysis: exploratory analyses using logistic regression and XGBoost
