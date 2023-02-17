# datathon-AI-art

## Main story/question:

(written by Stef; add more details or different ideas if you want; let's try to make this concrete as quickly as possible :smile:)

**Idea 1**
- Our client has developed an algorithm to differentiate AI art from real paintings (for this, we use an already existing AI art classifier). They are not yet satisfied with the current performance and has asked us to look into where it goes wrong.
- Steps to take:
  1) Test classifier on our paintings
  2) Look at what defines whether the algorithm is able to classify correctly or not
      - on image-level (algorithm Amar, ...)
      - using the extra data
        - tabular data (identify years, techniques, art styles, ...)
        - graph data (find clusters, ...)
 - pro's:
    - clear storyline
    - different types of data used
    - no need to train a classification algorithm on thousands of images
- con's:
  - images have to be cleaned to classify
  
**Idea 2**
...

## To-do list:
- more data exploration
- **develop the main story/question further**
- image preprocessing
  - Real paintings
    - [x] remove wikipedia banner (function is ready)
    - [ ] remove wikipedia logo (e.g., df1[40])  **Stef is working on this**
  - AI generated
    - [ ] remove censorde (black) images (e.g., df2[202])
  - [ ] make all paintings same size
- [ ] classify images (AI or not?)
- in what way do misclassified images differ from classified images?
  - on the level of the images themselves
  - in terms of extra data
    - e.g., painter information, year, style, ...
    - graph databases/neo4j?




## NOTES
- There are already a few GAN detection models available. However, as these images are created by stable diffusion (diffusion model), there are no models available as of yet that are able to detect fakes produced by these models. Therefore, we use GAN detection models on the stable diffusion outputs as our second option.
- Using model based on resnet50 and code from 
