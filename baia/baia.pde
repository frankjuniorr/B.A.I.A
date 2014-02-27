#include <Wire.h>
#include <LiquidCrystal_I2C.h>

#define LCD_ADDR  0x27    // I2C address
#define EN  2             // LCD En (Enable)
#define RW  1             // LCD Rw (Read/write)
#define RS  0             // LCD Rs (Reset)
#define D4  4             // LCD data 0
#define D5  5             // LCD data 1
#define D6  6             // LCD data 2
#define D7  7             // LCD data 3
#define BACKLIGHT_PIN  3
#define BACKLIGHT_POL  POSITIVE  //ligar ou nao o backlight (luz de fundo). Valor pode ser POSITIVE ou NEGATIVE

#define COLUNAS  16  // quantidade de colunas do LCD
#define LINHAS  2    // quantidade de linhas do LCD

#define MOTION_SENSOR_PIN  2    // pino do sensor de presenca

LiquidCrystal_I2C lcd(LCD_ADDR, EN, RW, RS, D4, D5, D6, D7, BACKLIGHT_PIN, BACKLIGHT_POL);

void setup() {
  
  Serial.begin(9600);
  lcd.begin(COLUNAS,LINHAS);
  
  pinMode (MOTION_SENSOR_PIN,INPUT);

  lcd.setCursor(0,0);
  lcd.print("C.E.S.A.R");
  delay(5000);
  lcd.clear();
  lcd.print("Baia de:");
  lcd.setCursor(0,1);
  lcd.print("Frank Junior");
  delay(3000);
  lcd.noBacklight();

}

void loop(){
  //Lendo o valor do sensor PIR. Este sensor pode assumir 2 valores
  //1 quando detecta algum movimento e 0 quando não detecta.
  int valor_sensor = digitalRead(MOTION_SENSOR_PIN);
  
  if (valor_sensor == HIGH){
    lcd.backlight();
  }else{
    lcd.noBacklight();
  }
    
  //escrever_na_serial();
  
}

void escrever_na_serial(){
// when characters arrive over the serial port...
    if (Serial.available()) {
      // wait a bit for the entire message to arrive
      delay(100);
      // clear the screen
      lcd.clear();
      // read all the available characters
      while (Serial.available() > 0) {
        // display each character to the LCD
        lcd.write(Serial.read());
      }
    }
}


