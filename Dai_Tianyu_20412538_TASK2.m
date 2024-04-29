% Init
clear; 
close all;
clc;
board = arduino;     % Create an Arduino object

%% Task2
addpath './temp_monitor';
sensorPin = 'A0';
greenLEDPin = 'D11';
yellowLEDPin = 'D10';
redLEDPin = 'D9';
temp_monitor(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin);