#!/usr/bin/env python3

import http.server as SimpleHTTPServer
import socketserver as SocketServer
import logging
import time


PORT = 8000

class GetHandler(
        SimpleHTTPServer.SimpleHTTPRequestHandler
        ):

    def do_GET(self):
        logging.error(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        logging.error(self.headers)


Handler = GetHandler
httpd = SocketServer.TCPServer(("", PORT), Handler)

print("Serving on port :8000")
time.sleep(30)
#httpd.serve_forever()
