from socket import *
from select import *
from _socket import AF_INET, socket, SOCK_STREAM
import RPi.GPIO as GPIO
from time import sleep

#Socket Client Set
HOST = "192.168.25.48"
PORT = 8115
BUFSIE =1024

#GPIO Set
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
buzzer=23
GPIO.setup(buzzer, GPIO.OUT)
p = GPIO.PWM(buzzer, 1500)

#소켓생성
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((HOST,PORT))

while True:
    data = clientSocket.recv(1024).decode('utf-8')
    print(data)
    if data == 'close':
        clientSocket.close()
        break
    
    p.ChangeFrequency(1500)
    p.start(50)
    sleep(0.1)
    p.stop()
