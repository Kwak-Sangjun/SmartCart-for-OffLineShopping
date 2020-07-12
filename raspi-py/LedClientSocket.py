from socket import *
from select import *
import RPi.GPIO as GPIO
from time import sleep

#Socket Client Set
HOST = '192.168.25.48'
PORT = 8112
BUFSIZE = 1024

#GPIO Set
GPIO.setmode(GPIO.BCM)
RUNNING = True

green = 27
red = 17
blue = 22

GPIO.setup(red, GPIO.OUT)
GPIO.setup(green, GPIO.OUT)
GPIO.setup(blue, GPIO.OUT)

Freq = 100

RED = GPIO.PWM(red, Freq)
GREEN = GPIO.PWM(green, Freq)
BLUE = GPIO.PWM(blue, Freq)

RED.start(0)
GREEN.start(0)
BLUE.start(0)

#소켓생성
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((HOST,PORT))

while True:
    data = clientSocket.recv(1024).decode('utf-8')
    print(data)
    if data == 'close':
        clientSocket.close()
        RUNNING = False
        GPIO.cleanup()
        break
    
    if data =='off':
        RED.ChangeDutyCycle(0)
        GREEN.ChangeDutyCycle(0)
        BLUE.ChangeDutyCycle(0)
    elif data == 'green':
        RED.ChangeDutyCycle(0)
        GREEN.ChangeDutyCycle(100)
        BLUE.ChangeDutyCycle(0)
    elif data == 'violet':
        RED.ChangeDutyCycle(100)
        GREEN.ChangeDutyCycle(0)
        BLUE.ChangeDutyCycle(100)
    else:
        RED.ChangeDutyCycle(100)
        GREEN.ChangeDutyCycle(0)
        BLUE.ChangeDutyCycle(0)
        
    






