from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
import papermill as pm
import subprocess

# Define default arguments
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 2, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# List of notebooks to execute
notebooks = [
    "notebooks/data_preprocessing.ipynb",
    "notebooks/data_analysis.ipynb",
    "notebooks/data_visualization.ipynb"
]

# Define function to execute notebooks
def run_notebook(notebook_path, output_path):
    pm.execute_notebook(
        notebook_path,
        output_path
    )

# Define function to render Quarto documents
def render_quarto():
    subprocess.run(["quarto", "render", "reports/"], check=True)

# Create DAG, make it run every 30 days
dag = DAG(
    'run_notebooks_and_render_quarto',
    default_args=default_args,
    description='Execute Jupyter notebooks sequentially and render Quarto reports',
    schedule_interval=timedelta(days=30),
    catchup=False,
)

# Create notebook execution tasks
previous_task = None
for notebook in notebooks:
    task = PythonOperator(
        task_id=f'run_{notebook.split("/")[-1].replace(".ipynb", "")}',
        python_callable=run_notebook,
        op_kwargs={
            'notebook_path': notebook,
            'output_path': f'output/{notebook.split("/")[-1]}'
        },
        dag=dag,
    )
    if previous_task:
        previous_task >> task
    previous_task = task

# Create Quarto rendering task
render_task = PythonOperator(
    task_id='render_quarto',
    python_callable=render_quarto,
    dag=dag,
)

# Set task dependency to ensure Quarto rendering happens after all notebooks are executed
if previous_task:
    previous_task >> render_task