from google.cloud import storage
from datetime import datetime
import json
import glob
import os

def save_files_tmp(data, file_format: str, file_name: str):
    """
    # SAVE FILES ON TEMPORARY

    Save files on `./tmp` to upload more easily into the storage.

    Parameters
    ----------
    data
        The information to be saved on the storage.
    file_format : str
        The type of the format that will define the process for saving and/or encoding. Such as `parquet` or `json`.
    zone : str
        The zone that will be saved the data, such as `raw`, `trusted` and `analytics`.
    """
    
    if file_format == 'parquet':
        args = {'coerce_timestamps':'ms','allow_truncated_timestamps':True}   
        file_path_tmp = f'./tmp/{file_name}.parquet'
        data.to_parquet(file_path_tmp, engine='pyarrow', index=False, **args)
    elif file_format == 'json':
        file_path_tmp = f'./tmp/{file_name}.json'
        with open(file_path_tmp, 'w') as file:
            json.dump(data, file)
    else:
        print("===> The format isn't json neither parquet to save.")
        return

    return file_path_tmp

def delete_files_tmp():
    """
    # DELETE FILES ON TEMPORARY

    Delete files in tmp folder to avoid unnecessary files locally.
    """

    files = glob.glob('./tmp/*')
    for f in files:
        os.remove(f)

def add_tables_data_warehouse(table_name: str, zone: str):
    """
    # ADD TABLES ON DATA WAREHOUSE

    Main function to save the data into the storage and create table into data warehouse.

    Parameters
    ----------
    data
        The information to be saved on the storage.
    file_format : str
        The type of the format that will define the process for saving and/or encoding. Such as `parquet` or `json`.
    zone : str
        The zone that will be saved the data, such as `raw`, `trusted` and `analytics`.
    table : str
        The table name that will be used to save into the storage and data warehouse.
    """
    return 1

def send_data(data, file_format: str, zone: str, table: str):
    """
    # SEND DATA TO STORAGE

    Main function to save the data into the storage and create table into data warehouse.

    Parameters
    ----------
    data
        The information to be saved on the storage.
    file_format : str
        The type of the format that will define the process for saving and/or encoding. Such as `parquet` or `json`.
    zone : str
        The zone that will be saved the data, such as `raw`, `trusted` and `analytics`.
    table : str
        The table name that will be used to save into the storage and data warehouse.
    """

    # Setting the partitions
    now = datetime.now()
    year = now.strftime("%Y")
    month = now.strftime("%m")
    day = now.strftime("%d")
    refdate = now.strftime("%Y%m%d")
    time = now.strftime("%H%M%S")

    file_name = f'{table}_{refdate}_{time}'
    file_name = file_name.lower()

    file_path_tmp = save_files_tmp(data, file_format, file_name)

    # Connect to the bucket
    storage_client = storage.Client()
    bucket_name = os.environ['bucket_name']
    bucket = storage_client.bucket(bucket_name)

    path_file = f"{zone}/{table}/year={year}/month={month}/day={day}/refdate={refdate}/{file_name}"
    file_storage = bucket.blob(path_file)
    file_storage.upload_from_filename(file_path_tmp)

    delete_files_tmp()
    print(f"===> Saving the data on `{zone}` zone the table `{table}` of the file `{file_name}`.")
