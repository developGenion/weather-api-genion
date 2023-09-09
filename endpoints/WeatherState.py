from flask import jsonify, request, Blueprint
import requests
import json
from controllers.MyCity import MyCitys
from controllers.Users import User
from controllers.QueryHistory import QueryHistoryWeather

# Create an instance of Blueprint
WeatherState_route = Blueprint('WeatherState', __name__)
api_key = '439d4b804bc8187953eb36d2a8c26a02'

# Define the routes
@WeatherState_route.route('/city', methods=['GET'])
def get_city():
    if 'city' in request.args:
        city = request.args.get('city')
        url_info_cords = f'https://openweathermap.org/data/2.5/find?q={city}&appid={api_key}&units=Celsius'
        response = requests.get(url_info_cords)
        if response.status_code == 200:
            info = response.json()
            return jsonify(info), 200
        else:
            return jsonify({'error': 'error'}), 400
    else:
        return jsonify({'error': 'la ciudad es requerido'}), 400


@WeatherState_route.route('/weather', methods=['POST'])
def get_Weather_city():
    data = request.get_json()
    lon = data['lon']
    lat = data['lat']
    url_info_cords = f'https://openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&units=metric&appid={api_key}&lang=es'
    response = requests.get(url_info_cords)
    if response.status_code == 200:
        info = response.json()
        return jsonify(info), 200
    else:
        return jsonify({'error': 'la ciudad es requerido'}), 400
    


@WeatherState_route.route('/my_favorite', methods=['POST'])
def save_MyCity():
    data = request.get_json()
    result, id_city = MyCitys.create(
        city=data['name'],
        lon=data['in_lon'],
        lat=data['in_lat'],
    )
    session = data['session'] 
    
    if (user := User.get_one(session)) == None:
        return jsonify({'error': 'No existe'}), 404
    else:
        relation, id_relation = MyCitys.RelationUseCity(
            users_id=user['id'],
            my_city_id=id_city,
        )

        if not relation:
            return jsonify({
                "error": id_relation
            }), 500
            
        return jsonify({
            "id": id_relation,
            "message": "Ciudad favorita add"
        }), 200
    
    
@WeatherState_route.route('/user', methods=['POST'])
def User_session():
    data = request.get_json()
    result, id_user = User.session_id(
        ssesion=data['ssesion_id'],
    )
    if not result:
        if not id_user:
            return jsonify({
                "error": "Error al crear session user"
            }), 500
        else:
            return jsonify({
                "user_id": id_user,
                "user_city": []
            }), 200
    else:
        info_city = MyCitys.ShowMyUserCity(
            users_id=id_user,
        )

        if not info_city:
            return jsonify({
                "user_id": id_user,
                "user_city": []
            }), 200
        else:
            return jsonify({
                "user_id": id_user,
                "user_city": info_city
            }), 200



@WeatherState_route.route('/history', methods=['POST'])
def Save_History():
    data = request.get_json()
    result, id_query = QueryHistoryWeather.create(
        date_time=data['date_time'],
        temp=data['temp'],
        city=data['city'],
        description=data['description'],
        icon=data['icon'],
        ssesion=data['ssesion']
    )
    
    if not result:
        return jsonify({
            "error": "error"
        }), 500
            
    return jsonify({
        "id": id_query,
        "message": "Ciudad favorita add"
    }), 200

@WeatherState_route.route('/history', methods=['GET'])
def list_history():
    session = request.args.get('session')
    ok, result = QueryHistoryWeather.list(str(session))
    if not ok:
        return jsonify({'error': "error"}), 404
    return jsonify(result), 200
    
