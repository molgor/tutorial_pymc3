#Docker File for Biospytial 3
#This file is intented tof build a Docker container image with the necessary
#dependencies to run Biospytial under a Python3 environment.  
#As such the project is a continuous integration given the complexity 
#in dependencies required by Biospytial.
#
#Maintainer:  Juan Escamilla Molgora <j.escamillamolgora@lancaster.ac.uk> (@juan_escamolgor)
#GitRepo: https://git.holobio.me/juan/biospytial3
#
## Date: 07/11/2017
ARG VERSION=latest
FROM continuumio/miniconda3
#FROM debian:$VERSION
LABEL maintainer="j.escamillamolgora@lancaster.ac.uk"

RUN echo "Initialising container assembly..." 

RUN echo "Creating user biospytial"
#RUN adduser biospytial

# Set the working directory.
WORKDIR /app

# Copy the file from your host to your current location.
ADD requirements/ requirements/
#COPY requirements/requirements.yml requirements/
## Update and install stuff
## Always run apt-update and install in the same
## line for consistency

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
#    pip \
 && rm -rf /var/lib/apt/lists/*



RUN groupadd -r biospytial && useradd --no-log-init -r -g biospytial biospytial

RUN echo "Installing python packages"
#USER biospytial
#RUN conda create --yes --name biospytial3 --file requirements/requirements.txt

RUN conda update -n base -c defaults conda \
&&  conda create --yes --name biospytial3 \
  -c conda-forge \
  descartes \
  jupyter \
  jupyterlab \
  geoviews \
  dash \
  pystan \
  nodejs \
  hvplot \
  ipdb \
  ;
# Second round for installing things in conda
RUN conda init bash \
&& conda activate biospytial3 \
#&& conda install -c conda-forge  \
#  hvplot \
#  ipdb \
&& echo "conda activate biospytial3" >> ~/.bashrc \
;
## Include here new packages to install, this to
## avoid resinstalling everything from scratch.
## E.g RUN conda install -c conda-forge nodejs;

RUN echo "Done"

#ADD app/ .

RUN mkdir -p /root/.jupyter
RUN ln -s /config/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py


## Install jupyter extension for holoviews
RUN jupyter labextension install @pyviz/jupyterlab_pyviz


RUN pip install tensorflow \
    tensorflow-probability \
    scikit-learn \
    seaborn;

RUN pip install sympy \
    pymc3 \
    pyvis \
    arviz;

#RUN conda install -c conda-forge --yes seaborn 

## Install here more packages, latter make it more
#efficient because the jupyter lab takes a lot of
#time to install.
## Include here new packages to install, this to
## avoid resinstalling everything from scratch.
## E.g RUN conda install -c conda-forge nodejs;
ENTRYPOINT ["/bin/bash","startApp.sh"]
#RUN conda env create -f environment.yml
# Run the command inside your image filesystem.
#RUN npm install

# Add metadata to the image to describe which port the container is listening on at runtime.
#EXPOSE 8080

# Run the specified command within the container.
#CMD [ "tail", "-f", "/dev/null" ]

# Copy the rest of your app's source code from your host to your image filesystem.
#COPY . .

