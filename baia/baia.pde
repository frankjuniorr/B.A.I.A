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

#define BUTTON1_PIN                3    // pino (PWM) do botao 1
#define BUTTON2_PIN                4    // pino (PWM) do botao 2
#define BUTTON3_PIN                5    // pino (PWM) do botao 2
#define TEMPERATURE_SENSOR_PIN    15    // pino (analog in) do sensor de temperatura

LiquidCrystal_I2C lcd(LCD_ADDR, EN, RW, RS, D4, D5, D6, D7, BACKLIGHT_PIN, BACKLIGHT_POL);

int temperatura = 0;

void setup() {

  Serial.begin(9600);
  lcd.begin(COLUNAS,LINHAS);

  pinMode(BUTTON1_PIN, INPUT); 
  pinMode(BUTTON2_PIN, INPUT); 
  pinMode(BUTTON3_PIN, INPUT); 

}

void loop(){
  int click_button1 = digitalRead(BUTTON1_PIN);
  int click_button2 = digitalRead(BUTTON2_PIN);
  int click_button3 = digitalRead(BUTTON3_PIN);
  
  lcd.setCursor(0,0);  
  lcd.print("Baia de:");
  lcd.setCursor(0,1);
  lcd.print("Frank Junior");

  // click do botao 1
  if (click_button1 == HIGH){
    int valor_temperatura_sensor = analogRead(TEMPERATURE_SENSOR_PIN);
    temperatura = valor_temperatura_sensor * 0.48828125;
    lcd.setCursor(0,0);  
    lcd.clear();
    lcd.print("Temperatura");    
    lcd.setCursor(0,1);
    
    lcd.print(temperatura);    
    lcd.setCursor(4,1);    
    lcd.print("C");    
    delay(5000);
    lcd.clear();
  }

  // click do botao 2  
  if (click_button2 == HIGH){
    lcd.setCursor(0,0);  
    lcd.clear();
    lcd.print("Localizacao");    
    lcd.setCursor(0,1);
    lcd.print("TIR-EMBAR");    
    delay(5000);
    lcd.clear();
  }
  
    // click do botao 3  
  if (click_button3 == HIGH){
    lcd.setCursor(0,0);  
    lcd.clear();
    lcd.print("TODO:");    
    lcd.setCursor(0,1);
    lcd.print("TODO:");    
    delay(5000);
    lcd.clear();
  }

}



