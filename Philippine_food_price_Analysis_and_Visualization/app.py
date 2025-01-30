import streamlit as st
from nbclient import NotebookClient
from nbformat import read

# Path to your Jupyter notebook
notebook_path = 'Reports/full_report.ipynb'

# Read and execute the notebook
with open(notebook_path) as f:
    nb = read(f, as_version=4)
    client = NotebookClient(nb)
    client.execute()

# Now you can display output from the notebook in Streamlit
st.write("Notebook executed successfully")
