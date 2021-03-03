# Introducción a la inferencia Bayesiana con programáción probabilístca

También llamado: *Un tutorial básico de PyMC3*

Aquí hay cuadernos interactivos (*notebooks*) para hacer modelos estocásticos.

Esto es parte de un taller-tutorial impartido por Juan Escamilla-Mólgora.
en dos seminarios de la UNAM durante 2020 y 2021.

- Sergio Hernández López el 17 de noviembre del 2020
- Elisa Dominguez Huetinger el 3 de marzo del 2021

Para instalar el tutorial se puede usar docker o anaconda.

Los temas están en la carpeta *notebooks*

## Instalación en Docker
Las librerías necesarias para poder correr los cuadernos se pueden instalar de forma sencilla en Docker. 
Para esto se debe compilar la imágen y después correr el contenedor.


### Para compilar la imagen: 
`docker build -t molgor/tutorial-pymc3:latest .`

### Para correr el contenedor:
`docker-compose up -d`

## Instalación con Anaconda
Utiliza el archivo environment.yml
Previa instalación de Anaconda o Miniconda hacer:
`conda env create -f environment.yml`
Una vez instalado el ambiente activa con:
`conda activate bayesian-tutorial`

