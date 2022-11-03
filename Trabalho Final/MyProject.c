/*
* LDC mostra a temperatura em graus
* leds piscam quando temperatura passar de 90 por cento da temperatura máxima
* botão rb5 liga o sistema, e rb4 desliga.
*/
// LCD module connections
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections

const char character[] = {0,14,17,17,14,0,0,0,0,0,0};

void CustomChar(char pos_row, char pos_char) {
  char i;
    Lcd_Cmd(80);
    for (i = 0; i<=10; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 2);
}

void main() {
     float ti, tf;
     int qtd, j;
     float temperatura;
     char saida[6];
     lcd_init();
     lcd_cmd(_lcd_cursor_off);

     ADCON1 = 0b00001100;
     trisd = 0x00;
     trisb.f5 = 1;
     trisb.f4 = 1;
     TRISC.F2 = 0;
     TRISC.f5 = 0;
     portd = 0x00;
     qtd = 0;
     TRISA = 0x00;

while(1){
       if(button(&portb,5,1,0) == 255){
          for( j = 0; j < 30; j++){
             TRISA = 0x00;
             PORTA = 0b0001000;
             PORTD = 0x3F;
             delay_ms(20);
             PORTA = 0b0010000;
             PORTD = 0x37;
             delay_ms(20);

          }
            PORTD = 0x00;
            PORTA = 0x00;
            qtd = 1;
            PORTC.f5 = 1;
       }
       if(button(&portb,4,1,0) == 255){
            qtd = 0;
            PORTC.f5 = 0;
            PORTC.F2 = 0;
            lcd_cmd(_lcd_clear);
            for( j = 0; j < 20; j++){
                 TRISA = 0x00;
                 PORTA = 0b0001000;
                 PORTD = 0x3F;
                 delay_ms(20);
                 PORTA = 0b0010000;
                 PORTD = 0x71;
                 delay_ms(20);
                 PORTA = 0b0100000;
                 PORTD = 0x71;
                 delay_ms(20);

            }
            PORTD = 0x00;
            PORTA = 0x00;
       }
       if(qtd == 1){
             TRISA = 7;
             PORTD = 0x00;
             temperatura = ADC_READ(2)/2;
             ti =  ADC_READ(0);
             ti = (ti * 100 ) /1023 ;
             tf = ADC_READ(1);
             tf = (tf*100)/1023;
             wordtostr(temperatura,saida);
             lcd_out(1,1,"Temp:");
             lcd_out_cp(saida);
             CustomChar(1,11);
             lcd_out_cp("C");
             lcd_out(2,1,"TMin:");
             wordtostr(ti,saida);
             lcd_out_cp(saida);
             CustomChar(2,11);
             lcd_out_cp("C");
             lcd_out(3,-3,"TMax:");
             wordtostr(tf,saida);
             lcd_out_cp(saida);
             CustomChar(3,7);
             lcd_out_cp("C");
             
             if(temperatura >= (tf*0.9)){
                    portd = 255;
                    delay_ms(200);
                    portd = ~portd;
                    delay_ms(200);
              }
              if(temperatura >= tf ){
                    PORTC.F2 = 1;
              }else if( temperatura <= ti){
                    PORTC.F2 = 0;
              }

       }
   }
}