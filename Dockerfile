FROM ubuntu:20.04

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2

RUN rm -rf /var/lib/apt/lists/*

# Create a working directory
RUN mkdir -p /workspace/app
WORKDIR /workspace/app

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user && \
 chown -R user:user /app
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
USER user

# All users can use /home/user as their home directory
ENV HOME=/home/user
RUN chmod 777 /home/user

# Install Miniconda and Python 3.8
ENV CONDA_AUTO_UPDATE_CONDA=false
ENV PATH=/home/user/miniconda/bin:$PATH
RUN curl -sLo ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
 chmod +x ~/miniconda.sh && \
 ~/miniconda.sh -b -p ~/miniconda && \
 rm ~/miniconda.sh && \
 conda install -y python==3.8.8 && \
 conda clean -ya

# No CUDA-specific steps
ENV NO_CUDA=1
RUN conda install pytorch torchvision torchaudio cpuonly -c pytorch \
 && conda install -y pandas \
 && conda install -y scikit-learn \ 
 && conda install -y matplotlib \
 && conda install -y -c conda-forge tensorflow \
 && conda install -y -c conda-forge keras \
 && conda install -y -c huggingface transformers \
 && conda install -y -c anaconda nltk \
 && conda install -y -c anaconda seaborn \
 && conda install -y -c conda-forge bokeh \
 && conda install -y -c plotly plotly \
 && conda install -y -c conda-forge sentencepiece \
 && pip install -U datasets \
 && pip install -U pip setuptools wheel \
 && pip install -U spacy \
 && pip install -U docx2python \
 && conda clean -ya

# Give back control
USER root
# Set the default command to python3
CMD ["python3"]

