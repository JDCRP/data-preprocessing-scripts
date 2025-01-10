#Install Conda
brew install miniconda

# Create virtual environment
conda create -c conda-forge -n resolve-geonames-venv python pandas requests openpyxl

# Activate virtual environment
conda activate resolve-geonames-venv

# Run
python3 resolve-geonames.py

