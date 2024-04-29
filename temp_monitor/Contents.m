% Temperature Monitoring Function
%   temp_monitor   - This function continuously monitors the temperature using
%                    a temperature sensor connected to an Arduino board. It
%                    controls the states of three LEDs based on the temperature
%                    readings:
%                    - Green LED: Constant light when temperature is within
%                      the range 18-24 °C.
%                    - Yellow LED: Blinks intermittently at 0.5 s intervals
%                      when temperature is below the range.
%                    - Red LED: Blinks intermittently at 0.25 s intervals
%                      when temperature is above the range.
%                    The function also displays the recorded temperature values
%                    in a live graph that updates approximately every 1 second.
%
% Syntax
%
%   temp_monitor(board, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin)
%
% Input Arguments
%
%   board         - Arduino board object created using the arduino function.
%   sensorPin     - Pin connected to the temperature sensor.
%   greenLEDPin   - Pin connected to the green LED.
%   yellowLEDPin  - Pin connected to the yellow LED.
%   redLEDPin     - Pin connected to the red LED.
%
% Description
%
%   temp_monitor continuously monitors the temperature using the specified
%   temperature sensor connected to the Arduino board. It controls the states
%   of three LEDs based on the temperature readings:
%
%   - Green LED: Constant light when temperature is within the range 18-24 °C.
%   - Yellow LED: Blinks intermittently at 0.5 s intervals when temperature
%     is below the range.
%   - Red LED: Blinks intermittently at 0.25 s intervals when temperature
%     is above the range.
%
%   The function also displays the recorded temperature values in a live graph
%   that updates approximately every 1 second.
%
% Example
%
%   arduinoObj = arduino;
%   temp_prediction(arduinoObj, 'A0', 'D11', 'D10', 'D9');
%
%   In this example, temp_monitor is called with the specified Arduino object,
%   sensor pin, and LED pins.