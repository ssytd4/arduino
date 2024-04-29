% Init
clear; 
close all;
clc;
board = arduino;     % Create an Arduino object

%% Task 1
sensorPin = 'A1';                 % Set the sensor pin
duration = 600;                   % Set the acquisition time (seconds)
time = zeros(1, duration);        % Initialize arrays to store data
voltage = zeros(1, duration);
temperature = zeros(1, duration);
V0_C = 500;   % mV
TC = 10;      % mV/℃

% Read data from the sensor every second
for i = 1:duration 
    time(i) = i;
    voltage(i) = readVoltage(board, sensorPin);
    temperature(i) = (voltage(i)*1000 - V0_C) / TC;
    pause(1);
end

% Calculate statistical quantities
minTemp = min(temperature);
maxTemp = max(temperature);
avgTemp = mean(temperature);

% Plot temperature vs time
figure;
plot(time, temperature);
xlabel('Time (s)');
ylabel('Temperature (°C)');

% Print formatted data to screen
fprintf('Data logging initiated - %s\n', datestr(now, 'dd/mm/yyyy'));
fprintf('Location - Nottingham\n\n');
for i = 1:duration
    fprintf('Minute %d\n\tTemperature %.2f C\n', floor((i-1)/60), temperature(i));
end
fprintf('\nMax temp %.2f C\nMin temp %.2f C\nAverage temp %.2f C\n', maxTemp, minTemp, avgTemp);
fprintf('\nData logging terminated\n');

% Write formatted data to file
fileID = fopen('cabin_temperature.txt', 'w');
fprintf(fileID, 'Data logging initiated - %s\n', datestr(now, 'dd/mm/yyyy')); 
fprintf(fileID, 'Location - Nottingham\n\n');
for i = 1:duration
    fprintf(fileID, 'Minute %d\n\tTemperature %.2f C\n', floor((i-1)/60), temperature(i));
end
fprintf(fileID, '\nMax temp %.2f C\nMin temp %.2f C\nAverage temp %.2f C\n', maxTemp, minTemp, avgTemp);
fprintf(fileID, '\nData logging terminated\n');
fclose(fileID);