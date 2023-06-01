#!/usr/bin/env python3

from simple_websocket_server import WebSocketServer, WebSocket
import http.server as SimpleHTTPServer
import socketserver as SocketServer
import logging
import time
import sys
import os
from threading import Thread

from concurrent import futures

import grpc
import srv_pb2
import srv_pb2_grpc


PORT = 8000
WS_PORT = 8001
GRPC_PORT = 8082

class GetHandler(
        SimpleHTTPServer.SimpleHTTPRequestHandler
        ):

    def do_GET(self):
        logging.error(self.headers)
        logging.error(os.system("uname -a"))
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

class Greeter(srv_pb2_grpc.GreeterServicer):
   def greet(self, request, context):
      print("Got request " + str(request))
      return greeting_pb2.ServerOutput(message='{0} {1}!'.format(request.greeting, request.name))
	  
def grpc_server():
   server = grpc.server(futures.ThreadPoolExecutor(max_workers=2))
   srv_pb2_grpc.add_GreeterServicer_to_server(Greeter(), server)
   server.add_insecure_port('[::]:8082')
   print("gRPC starting on 8082")
   server.start()
   server.wait_for_termination()

Handler = GetHandler
httpd = SocketServer.TCPServer(("", PORT), Handler)
server = WebSocketServer('0.0.0.0', WS_PORT, SimpleEcho)


print("Serving HTTP on port :8000")
print("Serving Websocket on port :8001")
Thread(target=server.serve_forever).start()
Thread(target=grpc_server).start()
httpd.serve_forever()

