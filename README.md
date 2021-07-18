# mldeploy
An attempt to deploy machine learning models via docker.
In this docker image most common build tools and common machine learning frameworks have been included

# Docker image details
Includes following high level packages for CPU only
1. miniconda with python 3.8.8
2. Pytorch
3. Tensorflow
4. keras
5. sklearn
6. spaCy
7. spaCy en_core_web_trf package for english
8. nltk
9. Huggingface transformers
10. sentencepiece
11. sentence_transformers from SBERT
12. charting packages (plotly, matplotlib, bokeh, seaborn)


# How to use
docker run -it -v **your_persitent_location_on_disk**:/workspace/app llearnell/ubuntu-ml
Once the container is running, you will be provided with a /bin/bash prompt within /workspace/app directory
All python environment already set.


# Where are the downloaded transformer models stored
They are stored in /workspace/app/data/ folder. This is one level inside the persistent_location_on_disk you provided while running the docker container.

# Why is the image size so large ?
I wanted a system where i have to do minimal steps and not wait for dependency resolution by conda everytime i replicate the environment.

Docker container can be found here:
https://hub.docker.com/repository/docker/llearnell/ubuntu-ml
