function temp_prediction(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin)
    % Set up temperature sensor
    V0_C = 500; % mV
    TC = 10;    % mV/°C
    
    % Initialize temperature variables
    currentTemp = 0;
    temperatureHistory = zeros(1, 120); % Store last 2 minutes (120 samples)

    % Main loop
    cnt = 0;
    while true
        % Read temperature
        voltage = readVoltage(board, sensorPin);
        prevTemp = currentTemp;
        currentTemp = (voltage*1000 - V0_C) / TC;
        
        % Update temperature history
        temperatureHistory = [temperatureHistory(2:end), currentTemp];
        if cnt == 120
            cnt = 120;
        else
            cnt = cnt + 1;
        end
        
        if cnt == 120
            % Calculate temperature change rate in °C/s
            tempChangeRateSec = currentTemp - prevTemp;
            
            % Calculate temperature change rate in °C/min
            tempChangeRateMin = mean(temperatureHistory(61:120)) - mean(temperatureHistory(1:60));
            
            % Calculate predicted temperature in 5 minutes
            predictedTemp = currentTemp + (tempChangeRateMin * 5);
        
            % Update LED states based on temperature change rate
            if tempChangeRateMin > 4
                greenLEDState = 0;
                yellowLEDState = 0;
                redLEDState = 1;
            elseif tempChangeRateMin < -4
                greenLEDState = 0;
                yellowLEDState = 1;
                redLEDState = 0;
            else
                greenLEDState = 1;
                yellowLEDState = 0;
                redLEDState = 0;
            end
        
            % Control LEDs
            writeDigitalPin(board, greenLEDPin, greenLEDState);
            writeDigitalPin(board, yellowLEDPin, yellowLEDState);
            writeDigitalPin(board, redLEDPin, redLEDState);
        
            % Print current temperature and predicted temperature
            fprintf('Current Temperature: %.2f°C\n', currentTemp);
            fprintf('Temperature Change Rate: %.2f°C/s\n', tempChangeRateSec);
            fprintf('Temperature Change Rate: %.2f°C/min\n', tempChangeRateMin);
            fprintf('Predicted Temperature in 5 Minutes: %.2f°C\n', predictedTemp);
            fprintf('\n');
        end
        
        % Wait for 1 seconds
        pause(1);
    end
end