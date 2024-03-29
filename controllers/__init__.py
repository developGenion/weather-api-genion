from psycopg2 import connect
from psycopg2.extras import RealDictCursor
from logging import getLogger

_log = getLogger('database')

try:
    conn = connect('postgres://plataformal:*12345genion@localhost:5432/clima', cursor_factory=RealDictCursor)
    _log.info('Connection started')
except Exception as err:
    _log.error('Connection error %s', str(err))

class get_cursor:
    def __init__(self, conn):
        self.cursor = conn.cursor()
    
    def __enter__(self):
        return self.cursor
    
    def __exit__(self, *args):
        self.cursor.close()