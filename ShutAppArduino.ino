//#include <FirebaseArduino.h>

// Set these to run example.
//#define FIREBASE_HOST "shutapp-cewit.firebaseio.com"
//#define FIREBASE_AUTH "01lNHToW8YnilieFhscYOX8L2TwigvlOGmmnPBcB"
//#define WIFI_SSID "HACK@CEWIT"
//#define WIFI_PASSWORD "cewit@1500!"

#define LED 2
int sensorPin = A0; // select the input pin for the potentiometer
int sensorValue = 0; // variable to store the value coming from the sensor

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(sensorPin, INPUT);
  Serial.begin(115200);
}

void loop() {
  sensorValue = analogRead(sensorPin);
  analogWrite(LED, sensorValue);
  Serial.println(1023 - sensorValue);
  delay(100);
}
