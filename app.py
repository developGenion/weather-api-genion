# Import the necessary libraries and modules
from flask import Flask, jsonify, request
from datetime import datetime, timedelta, timezone
import json
from waitress import serve
from routes.Apis import api_bp
from flask_cors import CORS

# Define the API key (can be a real key in production)
api_key = '439d4b804bc8187953eb36d2a8c26a02'

# Create an instance of the Flask application
app = Flask(__name__)

# Enable CORS to allow requests from other domains
CORS(app)

# Register the 'api_bp' blueprint with a URL prefix '/'
app.register_blueprint(api_bp, url_prefix='/')

# Function to load configuration from a JSON file
def loadFileConfig():
    with open('config.json') as f:
        data = json.load(f)
    return data

# Test route to check the server's status
@app.route("/", methods=['GET'])
def test():
    json_response = {}
    __uptime = datetime.now(timezone(-timedelta(hours=5))) - __init_time
    json_response["message"] = "Server running ..."
    json_response["uptime"] = f'{__uptime}'
    return jsonify(json_response)

# Server initialization time
__init_time = datetime.now(timezone(-timedelta(hours=5)))

if __name__ == '__main__':
    # Load configuration from a JSON file
    dataConfig = loadFileConfig()
    print(f"Server running : " + "http://" + dataConfig["url-backend"] + ":" + str(dataConfig["port"]))
    __init_time = datetime.now(timezone(-timedelta(hours=5)))
    print(f'Init time: {__init_time}')
    serve(app, host=dataConfig["url-backend"], port=dataConfig["port"])
