//
// Copyright 2015 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// FirebaseDemo_ESP8266 is a sample that demo the different functions
// of the FirebaseArduino API.

#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

// Set these to run example.
#define FIREBASE_HOST "shutapp-cewit.firebaseio.com"
#define FIREBASE_AUTH "01lNHToW8YnilieFhscYOX8L2TwigvlOGmmnPBcB"
#define WIFI_SSID "HACK@CEWIT"
#define WIFI_PASSWORD "cewit@1500!"

#define LED 2
int sensorPin = A0; // select the input pin for the potentiometer
int sensorValue = 0; // variable to store the value coming from the sensor

void setup() {

//  /////////////////////////////////////////////////////////////////////////////////////
  pinMode(LED, OUTPUT);
  pinMode(sensorPin, INPUT);
  Serial.begin(115200);
//  /////////////////////////////////////////////////////////////////////////////////////

  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

//int n = 0;

void loop() {
  sensorValue = analogRead(sensorPin); //Was analogRead
  analogWrite (LED, sensorValue);
  Serial.println(sensorValue, DEC);
  delay(100);
  
  // set value
  //int t = 20;

//  /////////////////////////////////////////////////////////////////////////////
//  sensorValue = analogRead(sensorPin);
//  analogWrite(LED, sensorValue);
//  Serial.println(1023 - sensorValue);
//  delay(100);
//  /////////////////////////////////////////////////////////////////////////////
   
  Serial.print(sensorValue);
  // handle error
  if (Firebase.failed()) {
      Serial.print("setting /sound failed:");
      Serial.println(Firebase.error());  
      return;
  }
  delay(10);
  
  // update value
  Firebase.setFloat("Sound", sensorValue);
  // handle error
  if (Firebase.failed()) {
      Serial.print("setting /sound failed:");
      Serial.println(Firebase.error());  
      return;
  }
  delay(100);

  // get value 
  Serial.print("Sound: ");
  //Serial.println(Firebase.getFloat("Sound"));
  delay(100);

  // remove value
  //Firebase.remove("Sound");
  //delay(10);

  // set string value
  //Firebase.setString("message", "hello world");
  // handle error
  if (Firebase.failed()) {
      Serial.print("setting /message failed:");
      Serial.println(Firebase.error());  
      return;
  }
  delay(10);
  
  // set bool value
  //Firebase.setBool("truth", false);
  // handle error
  //if (Firebase.failed()) {
  //    Serial.print("setting /truth failed:");
  //    Serial.println(Firebase.error());  
  //    return;
  //}
  //delay(1000);

  //Serial.print(Firebase.getString("LED").toInt() + "\n");

  //......analogWrite(LED,Firebase.getString("Sound").toInt());
  delay(10);


  // append a new value to /logs
  //String name = Firebase.pushInt("Sound", sensorValue);
  // handle error
  if (Firebase.failed()) {
      Serial.print("pushing /logs failed:");
      Serial.println(Firebase.error());  
      return;
  }
  Serial.print("pushed: /logs/");
  //Serial.println(name);
  delay(1000);
}
