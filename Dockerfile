
FROM rocker/tidyverse:4.6.1

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libsodium-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages
RUN R -e "install.packages(c('plumber', 'tidymodels', 'ranger'), repos='https://cloud.r-project.org')"

# Verify that required packages are installed
RUN R -e "library(plumber); library(tidymodels); library(ranger)"

# Set working directory
WORKDIR /app

# Copy the API and fitted model
COPY plumber.R .
COPY final_model.rds .

# Expose the API port
EXPOSE 8000

# Launch the Plumber API
CMD ["R", "-e", "r <- plumber::plumb('plumber.R'); r$run(host='0.0.0.0', port=8000)"]
