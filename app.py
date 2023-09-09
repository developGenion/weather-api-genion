from flask import Flask, jsonify, request
from datetime import datetime, timedelta, timezone
import json
from waitress import serve
from routes.Apis import api_bp
from flask_cors import CORS

api_key = '439d4b804bc8187953eb36d2a8c26a02'
app= Flask(__name__) 
CORS(app)
app.register_blueprint(api_bp, url_prefix='/')


def loadFileConfig():    
    with open('config.json') as f: 
        data = json.load(f)
    return data


@app.route("/",methods=['GET']) 
def test(): 
    json = {}
    __uptime = datetime.now(timezone(-timedelta(hours=5))) -__init_time 
    json["message"]="Server running ..."
    json["uptime"] = f'{__uptime}'
    return jsonify(json)


#__init_time = None
__init_time = datetime.now(timezone(-timedelta(hours=5)))
if __name__=='__main__': 
    dataConfig = loadFileConfig()
    print(f"Server running : "+"http://"+dataConfig["url-backend"]+":" + str(dataConfig["port"]))
    __init_time = datetime.now(timezone(-timedelta(hours=5))) 
    print(f'Init time: {__init_time}')
    serve(app,host=dataConfig["url-backend"],port=dataConfig["port"])
