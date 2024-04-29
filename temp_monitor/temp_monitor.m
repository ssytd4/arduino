function temp_monitor(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin)

    % Set up temperature sensor
    V0_C = 500; % mV
    TC = 10;    % mV/°C
    
    % Set temperature range
    minTemp = 18;
    maxTemp = 24;

    % Initialize LED states
    greenLEDState = 0;
    yellowLEDState = 0;
    redLEDState = 0;
    
    % Main loop
    cnt = 0;
    while true
        % Read and plot temperature
        if cnt == 0 
            voltage = readVoltage(board, sensorPin);
            temperature = (voltage*1000 - V0_C) / TC;
            plotTemperature(temperature);
        end
        
        % Update LED states
        if temperature >= minTemp && temperature <= maxTemp
            greenLEDState = 1;
            yellowLEDState = 0;
            redLEDState = 0;
        elseif temperature < minTemp && (cnt == 0 || cnt == 2)
            greenLEDState = 0;
            yellowLEDState = ~yellowLEDState;
            redLEDState = 0;
        elseif temperature > maxTemp
            greenLEDState = 0;
            yellowLEDState = 0;
            redLEDState = ~redLEDState;
        end
        
        % Control LEDs
        writeDigitalPin(board, greenLEDPin, greenLEDState);
        writeDigitalPin(board, yellowLEDPin, yellowLEDState);
        writeDigitalPin(board, redLEDPin, redLEDState);
        
        % Wait for a certain period
        pause(0.25);
        if cnt == 3
            cnt = 0;
        else
            cnt = cnt + 1;
        end
    end
end

function plotTemperature(temperature)
    persistent timeData temperatureData;
    
    % Initialize data on first call
    if isempty(timeData) || isempty(temperatureData)
        timeData = 0;
        temperatureData = temperature;
    else
        % Update data
        timeData = [timeData, timeData(end) + 1];
        temperatureData = [temperatureData, temperature];
    end
    
    % Plot live graph
    plot(timeData, temperatureData);
    xlabel('Time (s)');
    ylabel('Temperature (°C)');
    title('Live Temperature Monitoring');
    drawnow;
end