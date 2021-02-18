#include <Arduino.h>
#include <WiFi.h>
#include <ESPmDNS.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>
#include <Firebase_ESP_Client.h>

#define FIREBASE_PROJECT_ID "sprinkler-70b61"

#define USER_EMAIL "masonhorder@gmail.com"
#define USER_PASSWORD "Code4life"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;



const int relayPins[] = {34,35,32,33,25,26,27,14,12,13,2};
int currentRelay = 0;
int delayAmount = 10000;
bool running = false;
int startTime;
int stopTime;

unsigned long dataMillis = 0;
int count = 0;


// ! WIFI INFO
const char* ssid = "Horder";
const char* password = "Skmadley";

// next run
int nextRun[] = {};



void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
      Serial.print(".");
      delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  String content;
  FirebaseJson js;
}

void loop(){
  if (millis() - dataMillis > 60000 || dataMillis == 0){
    dataMillis = millis();

    get_collection();
  }
}


void get_collection(void)
{
  char *pcCollection;
  uint32_t u32CollectionLen;

  if(FIRESTORE_OK == firestore_get_collection("devices", &pcCollection, &u32CollectionLen))
  {
    ESP_LOGI(TAG, "Collection length: %d", u32CollectionLen);
    ESP_LOGI(TAG, "Collection content:\r\n%.*s", u32CollectionLen, pcCollection);
  }
  else
  {
    ESP_LOGE(TAG, "Couldn't get collection");
  }
}