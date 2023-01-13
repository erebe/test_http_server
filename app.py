#!/usr/bin/env python3

from simple_websocket_server import WebSocketServer, WebSocket
import http.server as SimpleHTTPServer
import socketserver as SocketServer
import logging
import time
import sys
from threading import Thread


PORT = 8000
WS_PORT = 8001

class GetHandler(
        SimpleHTTPServer.SimpleHTTPRequestHandler
        ):

    def do_GET(self):
        logging.error(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        logging.error(self.headers)
    
    def do_PUT(self):
        logging.error(self.headers)
        i=0
        while i <= 10:
            i * 50
        
    def do_HEAD(self):
        sys.exit(1)


class SimpleEcho(WebSocket):
    def handle(self):
        # echo message back to client
        self.send_message(self.data)

    def connected(self):
        print(self.address, 'connected')

    def handle_close(self):
        print(self.address, 'closed')


Handler = GetHandler
httpd = SocketServer.TCPServer(("", PORT), Handler)
server = WebSocketServer('0.0.0.0', WS_PORT, SimpleEcho)

print("Serving HTTP on port :8000")
print("Serving Websocket on port :8001")
Thread(target=server.serve_forever).start()
httpd.serve_forever()
