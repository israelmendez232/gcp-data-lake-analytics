import requests
import pandas as pd
import schedule 
import time 
import os

from save_storage import send_data
from coins import pairs

def raw_zone(timeframe: str, pair: str, limit: str, file_name: str):
    url = os.environ['url_api']

    path_historical_data = f"/candles/trade:{timeframe}:t{pair}/hist?limit={limit}" # TODO: modify the timeframe as .env variables
    response = requests.request("GET", url + path_historical_data)
    response = response.json()

    file_format = 'json'
    zone = 'raw'
    send_data(response, file_format, zone, file_name)

    return response

def trusted_zone(response: json, file_name: str):
    df = pd.DataFrame.from_dict(response)
    df.columns = ["date", "open", "close", "high", "low", "volume"]
    df['date'] = pd.to_datetime(df['date'], unit='ms')

    file_format = 'parquet'
    zone = 'trusted'
    send_data(df, file_format, zone, file_name)
    
    return df

def analytics_zone(pair: str, df: pd.DataFrame, file_name: str):
    df['result'] = df['close'] - df['open']

    frames = [5, 10, 15, 22]

    for frame in frames:
        df[f'ma_{frame}'] = df['close'].rolling(frame).mean()
        df[f'std_{frame}'] = df['close'].rolling(frame).std(ddof = 0)

    # Add all tecnical analysis features for the data analytics team.
    df = add_all_ta_features( df, open="open", high="high", low="low", close="close", volume="volume" )

    file_format = 'parquet'
    zone = 'analytics'
    send_data(df, file_format, zone, file_name)

def main():
    timeframe = os.environ['timeframe']

    for pair in pairs:
        pair.lower()
        file_name = f'{pair}_{timeframe}'
        file_name.lower()

        response = raw_zone(timeframe, pair, limit, file_name)
        df = trusted_zone(pair, response, file_name)
        analytics_zone(pair, df, file_name)

    print("===> Finished with all the ETL.")

# Runs the ETL each 5 minutes to collect and save the data.
schedule.every(5).minutes.do(main)
while True:
    schedule.run_pending()
    time.sleep(1)
