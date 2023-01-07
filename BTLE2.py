import socket
import struct

msg = str.encode("Hello Client!")
# Créer une socket datagramme
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# Lier à l'adresse IP et le port
s.bind(("127.0.0.1", 9999))
print("Serveur UDP à l'écoute")
# Écoutez les datagrammes entrants
while(True):
    addr = s.recvfrom(1024)
    message = addr[0]
    address = addr[1]
    data = struct.unpack(str(len(message)) + 'B', message)
    clientMsg = "Message du client: {}".format(data)
    clientIP  = "Adresse IP du client: {}".format(address)
    print(clientMsg)
    print(clientIP)