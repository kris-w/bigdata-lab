from elasticsearch import Elasticsearch
import csv
import os

# Read environment variable or default to local
ELASTIC_URL = os.getenv("ELASTIC_URL", "http://10.0.1.20:9200")
INDEX_NAME = "entities"

es = Elasticsearch([ELASTIC_URL])

# Create index if it doesn't exist
if not es.indices.exists(index=INDEX_NAME):
    es.indices.create(index=INDEX_NAME)

csv_file = os.path.join(os.path.dirname(__file__), "../../datasets/sample_entities.csv")

with open(csv_file, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        es.index(index=INDEX_NAME, document=row)

print(f"Indexed sample entities to {INDEX_NAME} at {ELASTIC_URL}")
