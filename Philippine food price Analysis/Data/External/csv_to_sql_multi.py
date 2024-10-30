import csv
import multiprocessing as mp
import re
import time

start = time.time()
def escape_sql_value(value):
    """
    Escapes special characters in SQL values to avoid syntax errors.
    Handles single quotes, backslashes, and other characters.
    """
    if isinstance(value, str):
        # Escape single quotes by doubling them
        return re.sub(r"'", "''", value)
    return value

def process_rows(rows, columns, table_name, existing_rows_dict):
    """
    Function that processes a list of rows and generates SQL insert statements,
    while avoiding duplicates using a shared dictionary (keys act as unique rows).
    Escapes special characters in the SQL statements to avoid syntax errors.
    """
    insert_statements = []
    for row in rows:
        row_tuple = tuple(row)  # Convert the row to a tuple to check for uniqueness
        if row_tuple not in existing_rows_dict:  # Only insert unique rows
            # Escape and format each value
            values = ', '.join([f"'{escape_sql_value(value)}'" if isinstance(value, str) else str(value) for value in row])
            # Wrap table and column names in backticks to avoid conflicts with reserved keywords
            insert_statement = f"INSERT INTO `{table_name}` ({', '.join([f'`{col}`' for col in columns])}) VALUES ({values});\n"
            insert_statements.append(insert_statement)
            existing_rows_dict[row_tuple] = True  # Mark the row as processed using a dictionary key
    
    return insert_statements, len(insert_statements)

def csv_to_sql_insert(csv_file, table_name, output_sql_file, num_processes=8):
    """
    Main function that reads the CSV, splits the rows, and uses multiprocessing to generate SQL insert statements.
    It ensures no duplicate rows are processed by using a shared dictionary.
    """
    # Open the CSV file and read its contents
    with open(csv_file, newline='') as file:
        reader = csv.reader(file)
        
        # Get the column names from the first row
        columns = next(reader)
        
        # Convert the remaining rows into a list
        rows = list(reader)
    
    # Split the rows into chunks for multiprocessing
    chunk_size = len(rows) // num_processes
    chunks = [rows[i:i + chunk_size] for i in range(0, len(rows), chunk_size)]
    
    # If there are leftover rows, add them to the last chunk
    if len(rows) % num_processes != 0:
        chunks[-1].extend(rows[-(len(rows) % num_processes):])
    
    # Create a managed dictionary to track unique rows (shared among processes)
    manager = mp.Manager()
    existing_rows_dict = manager.dict()  # Dictionary to store unique rows as keys
    
    # Create a pool of workers
    with mp.Pool(processes=num_processes) as pool:
        # Distribute the chunks to different processes and collect the results (SQL statements and count)
        results = pool.starmap(process_rows, [(chunk, columns, table_name, existing_rows_dict) for chunk in chunks])
    
    # Flatten the list of results (since each process returns a list of statements)
    insert_statements = [stmt for sublist, _ in results for stmt in sublist]
    
    # Count the total number of insert statements
    total_insert_statements = sum(count for _, count in results)
    
    # Write the insert statements to the output SQL file
    with open(output_sql_file, 'w') as sql_file:
        sql_file.writelines(insert_statements)

    # Print the total number of lines written
    print(f"Total number of INSERT statements written to '{output_sql_file}': {total_insert_statements}")

# Example usage
if __name__ == "__main__":
    csv_file_path = 'PHL_RTFP_mkt_2007_2024-10-08.csv'  # Path to your CSV file
    table_name = 'Philippine_Food_Price'  # Name of the table to insert into
    output_sql_file = r'C:\Users\Navii\Desktop\Data_Analysis_Projects\Data_Analysis\SQL\Philippine food price Analysis\Data\Interim\insert_statements.sql'  # Path for the output SQL file
    
    # Use 8 processes for 8 CPU cores
    csv_to_sql_insert(csv_file_path, table_name, output_sql_file, num_processes=8)
    end = time.time()
    print(f"SQL file '{output_sql_file}' has been created without duplicates, using multiprocessing on 8 CPU cores.")
    print(f"Total Time: {(end-start)} sec")
