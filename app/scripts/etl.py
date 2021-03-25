import requests
import pandas as pd
import schedule 
import time 
import os
import json
from ta import add_all_ta_features

from save_storage import send_data
from coins import pairs

def raw_zone(timeframe: str = "5m", pair: str, table_name: str): 
    """
    # RAW ZONE

    Collect data from the Crypto API and send to `raw` schema/dataset.

    Parameters
    ----------
    timeframe : str
        Which is the time that the data will be collected. Such as `1m`, `6h` and others. The **default** will be `5m`.
    pair : str
        The pair to collect the pricing and data, such as `BTCUSD`, `ETHUSD` and others.
    table_name : str
        The table name that will be used to save into the storage and data warehouse.

    Returns
    -------
    response : json
        Return the json file, as response from the API request.
    """

    url = os.environ['url_api']
    limit = os.environ['url_api']

    path_historical_data = f"/candles/trade:{timeframe}:t{pair}/hist?limit={limit}" # TODO: modify the timeframe as .env variables
    response = requests.request("GET", url + path_historical_data)
    response = response.json()

    file_format = 'json'
    zone = 'raw'
    send_data(response, file_format, zone, table_name)

    return response

def trusted_zone(response: json, table_name: str):
    """
    # TRUSTED ZONE

    Transform the json data into a tabular format for the `trusted` schema/dataset.

    Parameters
    ----------
    response : json
        The response from the API request.
    table_name : str
        The table name that will be used to save into the storage and data warehouse.

    Returns
    -------
    df : pd.DataFrame
        Return the dataframe as tabular format from the json file.
    """

    df = pd.DataFrame.from_dict(response)
    df.columns = ["date", "open", "close", "high", "low", "volume"]
    df['date'] = pd.to_datetime(df['date'], unit='ms')

    file_format = 'parquet'
    zone = 'trusted'
    send_data(df, file_format, zone, table_name)
    
    return df

def analytics_zone(df: pd.DataFrame, table_name: str):
    """
    # ANALYTICS ZONE

    Collect the data from trusted and add more financial metrics to be consumed for the business users and data team. On `analytics` schema/dataset.

    Parameters
    ----------
    df : pd.DataFrame
        The tabular format transformed in `trusted_zone`.
    table_name : str
        The table name that will be used to save into the storage and data warehouse.
    """

    df['result'] = df['close'] - df['open']

    frames = [5, 10, 15, 22]

    for frame in frames:
        df[f'ma_{frame}'] = df['close'].rolling(frame).mean()
        df[f'std_{frame}'] = df['close'].rolling(frame).std(ddof = 0)

    # Add all tecnical analysis features for the data analytics team.
    df = add_all_ta_features( df, open="open", high="high", low="low", close="close", volume="volume" )

    file_format = 'parquet'
    zone = 'analytics'
    send_data(df, file_format, zone, table_name)

def main():
    """
    # MAIN

    Runs the three major steps for the ETL for each pair and timeframe.
    """

    timeframe = os.environ['timeframe']

    for pair in pairs:
        table_name = f'{pair}_{timeframe}'
        table_name = table_name.lower()

        response = raw_zone(timeframe, pair, table_name)
        df = trusted_zone(response, table_name)
        analytics_zone(df, table_name)

    print("===> Finished with all the ETL.")

# Run the ETL between 300 seconds or 5 minutes.
while True:
    main()
    time.sleep(300) 
