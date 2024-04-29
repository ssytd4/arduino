function temp_prediction(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin)
    % Set up temperature sensor
    V0_C = 500; % mV
    TC = 10;    % mV/°C
    
    % Initialize temperature variables
    temperatureHistory = zeros(1, 240); % Store last 60 seconds (240 samples)

    % Main loop
    cnt = 0;
    while true
        % Read temperature
        voltage = readVoltage(board, sensorPin);
        currentTemp = (voltage*1000 - V0_C) / TC;
        
        % Update temperature history
        temperatureHistory = [temperatureHistory(2:end), currentTemp];
        if cnt == 240
            cnt = 240;
        else
            cnt = cnt + 1;
        end
        
        if cnt == 240
            % Calculate temperature change rate in °C/min
            tempChangeRateMin = mean(diff(temperatureHistory)) * 60;
        
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
            fprintf('Predicted Temperature in 5 Minutes: %.2f°C\n', predictedTemp);
            fprintf('Temperature ChangeRate: %.2f°C/min\n', tempChangeRateMin);
        end
        
        % Wait for 0.25 seconds
        pause(0.25);
    end
end