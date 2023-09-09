import psycopg2
from controllers import conn, get_cursor


class QueryHistoryWeather:
    @staticmethod
    def list(ssesion):
        with get_cursor(conn) as curd:
            curd.execute('''
                SELECT
                   wqh.id,
                   wqh.temp,
                   wqh.date_time,
                   wqh.users_id,
                   wqh.city,
                   wqh.description,
                   wqh.icon
                FROM weather_query_history AS wqh
                JOIN users AS u ON wqh.users_id = u.id
                WHERE u.ssesion = %(ssesion)s
                ORDER BY wqh.id DESC;
            ''', {'ssesion': ssesion})
            if curd.rowcount == 0:
                return False, "error"
            return True, curd.fetchall()
    
    @staticmethod
    def create(date_time, temp, city, description, icon, ssesion):
        with get_cursor(conn) as cur:
            cur.execute('''
                SELECT
                    id
                FROM users
                WHERE ssesion = %(ssesion)s
            ''', ({'ssesion': ssesion}))
            existing_user = cur.fetchone()
            if existing_user:
                try:
                    cur.execute('''
                        INSERT INTO weather_query_history( 
                            date_time,
                            users_id,
                            temp,
                            city,
                            description,
                            icon)
                        VALUES (
                            %(date_time)s,
                            %(users_id)s,
                            %(temp)s,
                            %(city)s,
                            %(description)s,
                            %(icon)s
                        )
                        RETURNING id
                    ''', {
                        'date_time': date_time, 
                        'users_id': existing_user['id'], 
                        'temp': temp,
                        'city': city, 
                        'description': description,
                        'icon': icon, 
                    })
                    conn.commit()
                    return True, cur.fetchone()['id']
                except Exception as e:
                    conn.rollback()
                    return False, 'Error al crear la ciudad'
           