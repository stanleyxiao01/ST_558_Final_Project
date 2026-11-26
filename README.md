# ST_558_Final_Project - Bank Marketing Classification

## Project Overview

This project uses the Bank Marketing dataset to predict whether a customer subscribes to a term deposit. A classification tree and a random forest were tuned using five-fold cross-validation and compared on a held-out test set using ROC AUC. The random forest was selected as the final model and fitted to the entire dataset.

## Project Report

[Rendered Quarto report](https://stanleyxiao01.github.io/ST_558_Final_Project/)

## Project Files

- ST_558_Final_Project.qmd: Data preprocessing, model tuning, evaluation, and final model selection

- Dataset/: Original Bank Marketing data

- final_model.rds: Saved fitted random forest workflow

- plumber.R: API for predictions and project information 

- Dockerfile: Instructions for building the Docker image

- docs/: Rendered GitHub Pages report

## Running the API with Docker

To build the image from the project directory:

```bash
docker build --platform linux/amd64 -t bank-marketing-api .
```

Or, after downloading the submitted Docker image archive, load it using:

```bash
docker load -i bank-marketing-api.tar
```

Run the container:

```bash
docker run --platform linux/amd64 --rm -p 8000:8000 bank-marketing-api
```

Open the [Swagger interface](http://localhost:8000/__docs__/) in a browser

## API Endpoints

- /pred: Returns the predicted subscription class and probabilities for both outcomes. Default predictor values are based on the numeric means and categorical modes in the dataset

- /info: Returns the author's name and rendered project URL

Example API calls:

- http://localhost:8000/pred

- http://localhost:8000/pred?age=35&balance=2000&duration=300

- http://localhost:8000/pred?job=management&housing=no&duration=600

- http://localhost:8000/info

Use `Ctrl + C` in the terminal to stop the container.