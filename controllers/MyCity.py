import psycopg2
from controllers import conn, get_cursor


class MyCitys:
    @staticmethod
    def create(city, lon, lat):
        with get_cursor(conn) as cur:
            # Check if a city with the same lon and lat already exists
            cur.execute('''
                SELECT
                    id
                FROM my_city
                WHERE lon = %(lon)s
                    AND lat = %(lat)s;
            ''', ({'lon': lon, 'lat': lat}))
            existing_city = cur.fetchone()
            if existing_city:
                return True, existing_city['id']
            
            # If the city does not exist, insert it into the database
            try:
                cur.execute('''
                    INSERT INTO my_city( 
                        city,
                        lon,
                        lat)
                    VALUES (
                        %(city)s,
                        %(lon)s,
                        %(lat)s
                    )
                    RETURNING id
                ''', {
                    'city': city, 
                    'lon': lon, 
                    'lat': lat
                })
                conn.commit()
                return True, cur.fetchone()['id']
            except psycopg2.errors.UniqueViolation:
                conn.rollback()
                return False, 'Error creating city'
    
    # Method to manage the relationship between users and cities
    @staticmethod
    def RelationUseCity(users_id, my_city_id):
        with get_cursor(conn) as cur:
            cur.execute('''
                SELECT
                    id
                FROM user_city
                WHERE users_id = %(users_id)s;
            ''',{'users_id': users_id})
            existing_relation = cur.fetchone()
            if existing_relation:
                # Update the existing relationship
                try:
                    cur.execute('''
                        UPDATE user_city
                        SET users_id = %(users_id)s,
                            my_city_id = %(my_city_id)s
                            WHERE id = %(id)s;
                    ''', {'users_id': users_id, 'my_city_id': my_city_id, 'id': existing_relation['id']})
                    conn.commit()
                    return True, 'Updated relationship'
                except Exception:
                    conn.rollback()
                    return False, 'Error updating relationship'
            else:
                # Create a new relationship if it doesn't exist
                try:
                    cur.execute('''
                        INSERT INTO user_city(
                            users_id, 
                            my_city_id
                        )
                        VALUES (
                            %(users_id)s, 
                            %(my_city_id)s
                        )
                        RETURNING id;
                    ''', {
                        "users_id": users_id, 
                        "my_city_id": my_city_id
                    })
                    conn.commit()
                    return True, cur.fetchone()['id']
                except Exception as e:
                    conn.rollback()
                    return False, f'Error creating relationship: {str(e)}'
                
    # Method to retrieve user's favorite cities
    @staticmethod
    def ShowMyUserCity(users_id):
        with get_cursor(conn) as curd:
            curd.execute('''
                SELECT 
                    uc.id,
                    c.id,
                    c.lon,
                    c.lat,
                    c.city
                FROM user_city uc
                JOIN my_city c ON uc.my_city_id = c.id
                WHERE uc.users_id = %(users_id)s;
            ''', {'users_id': users_id})
            if curd.rowcount == 0:
                return False
            user_cities = []
            for row in curd.fetchall():
                city_info = {
                    "id": row['id'],
                    "my_city": {
                        "city": row['city'],
                        "lat": row['lat'],
                        "lon": row['lon']
                    }
                }
                user_cities.append(city_info)
            
            return user_cities
            