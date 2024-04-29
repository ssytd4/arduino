% Temperature Prediction Function
%   temp_prediction   - This function continuously monitors the temperature using
%                       a temperature sensor connected to an Arduino board. It
%                       calculates the temperature change rate in °C/min and predicts
%                       the temperature in 5 minutes based on the current rate of
%                       change. LED lights indicate if the temperature is stable within
%                       the comfort range, increasing rapidly, or decreasing rapidly.
%
% Syntax
%
%   temp_prediction(arduinoObj, sensorPin, greenLEDPin, yellowLEDPin, redLEDPin)
%
% Input Arguments
%
%   arduinoObj    - Arduino board object created using the arduino function.
%   sensorPin     - Pin connected to the temperature sensor.
%   greenLEDPin   - Pin connected to the green LED.
%   yellowLEDPin  - Pin connected to the yellow LED.
%   redLEDPin     - Pin connected to the red LED.
%
% Description
%
%   temp_prediction continuously monitors the temperature using the specified
%   temperature sensor connected to the Arduino board. It calculates the rate of
%   change of temperature and predicts the temperature in 5 minutes based on the
%   current rate of change. The function controls the states of three LEDs to
%   indicate the temperature status:
%
%   - Green LED: Constant light indicates stable temperature within the comfort range.
%   - Yellow LED: Indicates rapid decrease in temperature.
%   - Red LED: Indicates rapid increase in temperature.
%
% Example
%
%   arduinoObj = arduino;
%   temp_prediction(arduinoObj, 'A0', 'D11', 'D10', 'D9');
%
%   In this example, temp_prediction is called with the specified Arduino object,
%   sensor pin, and LED pins.