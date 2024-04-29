% Init
clear; 
close all;
clc;
board = arduino;     % Create an Arduino object

%% LED test
ledPin = 'D11';      % Set the LED pin
blinkInterval = 0.5; % Set the blink interval (seconds)
test_time = 60;      % LED test duration (seconds)
for i = 1:test_time
	writeDigitalPin (board, ledPin, 1);
    pause(blinkInterval);
    writeDigitalPin (board, ledPin, 0);
    pause(blinkInterval);
end