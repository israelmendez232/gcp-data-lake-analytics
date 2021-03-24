from google.cloud import storage
import glob
import os

def save_files_tmp(data, file_format, file_name):
    if file_format == 'parquet':
        file_path_tmp = f'./tmp/{file_name}.parquet'
        df.to_parquet(file_path_tmp)
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
    Delete files in tmp folder to avoid unnecessary files locally.
    """
    files = glob.glob('./tmp/*')
    for f in files:
        os.remove(f)

def send_data(data, file_format: str, zone: str, file_name: str):
    file_path_tmp = save_files_tmp(data, file_format, file_name)

    # Connect to the bucket
    storage_client = storage.Client()
    bucket_name = env.bucket_name
    bucket = storage_client.bucket(bucket_name)

    # Upload the file
    path_file = f"{sample_bucket_path}/pmonth={}/pweek={}/pday={}/{file_name}"
    file_storage = bucket.blob(path_file)
    file_storage.upload_from_filename(file_path_tmp)

    delete_files_tmp()
    print(f"===> Saving the data on `{zone}` zone the file: `{file_name}`")
