# Test Cases for verilog-mic1

## [????]
- Grant data cycle is finished before posedge clock event

## Shifter
### Description
- Receives the signals from controller and the ULA's output in order to deliver the arithmetic right shift or logical left shift. The default behavior is be a bypass.

### Test cases
1. Right shitf: enter with aleatory data and command a right shift. Check if the data was shifted at right by 1 digit with signal extension.
2. Left shitf: enter with aleatory  data and command a left shift. Check if the data was shifted at left by 8 digits with 8 zeros at right.
3. Bypass: enter with aleatory data and not command anything (default case). Check if the data is kept unchanged.