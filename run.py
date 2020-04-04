from os import environ
from src.server import TroopServer

try:
    server = TroopServer(
        debug=environ.get('DEBUG') is not None,
        log=environ.get('LOG') is not None,
        password=environ.get('PASSWORD', ''),
        port=int(environ.get('PORT', 57890)),
    )
    server.start()
except KeyboardInterrupt:
    pass
