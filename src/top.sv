// created by Andrew Schlabach 6/20/25

// plan for the project
// 8 switch keyboard which maps to 8 bit ascii
// 2 main areas, a usb controller and a keyboard controller
// keyboard controller
// - scan each of the keys into a history byte to check for bouncing
//   - set the corresponding pin high
//   - wait a reasonable period of time ~ (5ms / 64) 8 for history * 8 for switches
//   - read the pin and write it into the history byte
// - check if it is a new keypress
//   - save the current keypress in a byte
//   - if all the history bytes have no bounce, and meassured keypress != current keypress
//     - then set current keypress = measured keypress and send it to usb controller
// usb controller
//   - if the key to send is ctrl, it should wait until it gets another key before releasing
//     - that requires saving if the previous key was ctrl
//     - do the same for other modifier keys
//     - if the next key is a modifier key that has already been pressed, send the packet
