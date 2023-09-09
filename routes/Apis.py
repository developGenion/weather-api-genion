from flask import Blueprint
from endpoints.WeatherState import WeatherState_route

api_bp = Blueprint('api', __name__)

api_bp.register_blueprint(WeatherState_route)