from psycopg2 import connect
from psycopg2.extras import RealDictCursor
from logging import getLogger

_log = getLogger('database')

try:
    conn = connect('postgres://user_base:password@localhost:5432/bd', cursor_factory=RealDictCursor)
    _log.info('Conexion iniciada')
except Exception as err:
    _log.error('Error en la conexion %s', str(err))

class get_cursor:
    def __init__(self, conn):
        self.cursor = conn.cursor()
    
    def __enter__(self):
        return self.cursor
    
    def __exit__(self, *args):
        self.cursor.close()