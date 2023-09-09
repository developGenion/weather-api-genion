import psycopg2
from controllers import conn, get_cursor

class User:
    @staticmethod
    def session_id(ssesion):
        with get_cursor(conn) as curd:
            curd.execute('''
                SELECT
                    id
                FROM users
                WHERE ssesion = %(ssesion)s
            ''', ({'ssesion': ssesion}))
            existing_user = curd.fetchone()
            if existing_user:
                return True, existing_user['id']
            try:
                curd.execute('''
                    INSERT INTO users(ssesion)
                    VALUES (
                        %(ssesion)s
                    )
                    RETURNING id
                ''', {
                    'ssesion': ssesion
                })
                conn.commit()
                return True, curd.fetchone()['id']
            except psycopg2.errors.UniqueViolation:
                conn.rollback()
                return False, 'Error creating session'
    
    @staticmethod
    def get_one(session_id):
        with get_cursor(conn) as curd:
            curd.execute('''
                SELECT
                   *
                FROM users
                WHERE ssesion = %s
            ''', (session_id,))
            if curd.rowcount == 0:
                return None
            return curd.fetchone()
        

        