% Init
clear; 
close all;
clc;
board = arduino;     % Create an Arduino object

%% Task3
addpath './temp_prediction';
sensorPin = 'A0';
greenLEDPin = 'D11';
yellowLEDPin = 'D10';
redLEDPin = 'D9';
temp_prediction(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin);