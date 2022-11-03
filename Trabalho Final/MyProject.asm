
_CustomChar:

;MyProject.c,24 :: 		void CustomChar(char pos_row, char pos_char) {
;MyProject.c,26 :: 		Lcd_Cmd(80);
	MOVLW       80
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,27 :: 		for (i = 0; i<=10; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar0:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       10
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar1
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      TBLPTR+1, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar0
L_CustomChar1:
;MyProject.c,28 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,29 :: 		Lcd_Chr(pos_row, pos_char, 2);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MyProject.c,30 :: 		}
L_end_CustomChar:
	RETURN      0
; end of _CustomChar

_main:

;MyProject.c,32 :: 		void main() {
;MyProject.c,37 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;MyProject.c,38 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,40 :: 		ADCON1 = 0b00001100;
	MOVLW       12
	MOVWF       ADCON1+0 
;MyProject.c,41 :: 		trisd = 0x00;
	CLRF        TRISD+0 
;MyProject.c,42 :: 		trisb.f5 = 1;
	BSF         TRISB+0, 5 
;MyProject.c,43 :: 		trisb.f4 = 1;
	BSF         TRISB+0, 4 
;MyProject.c,44 :: 		TRISC.F2 = 0;
	BCF         TRISC+0, 2 
;MyProject.c,45 :: 		TRISC.f5 = 0;
	BCF         TRISC+0, 5 
;MyProject.c,46 :: 		portd = 0x00;
	CLRF        PORTD+0 
;MyProject.c,47 :: 		qtd = 0;
	CLRF        main_qtd_L0+0 
	CLRF        main_qtd_L0+1 
;MyProject.c,48 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;MyProject.c,50 :: 		while(1){
L_main3:
;MyProject.c,51 :: 		if(button(&portb,5,1,0) == 255){
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       5
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;MyProject.c,52 :: 		for( j = 0; j < 30; j++){
	CLRF        main_j_L0+0 
	CLRF        main_j_L0+1 
L_main6:
	MOVLW       128
	XORWF       main_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVLW       30
	SUBWF       main_j_L0+0, 0 
L__main27:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;MyProject.c,53 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;MyProject.c,54 :: 		PORTA = 0b0001000;
	MOVLW       8
	MOVWF       PORTA+0 
;MyProject.c,55 :: 		PORTD = 0x3F;
	MOVLW       63
	MOVWF       PORTD+0 
;MyProject.c,56 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;MyProject.c,57 :: 		PORTA = 0b0010000;
	MOVLW       16
	MOVWF       PORTA+0 
;MyProject.c,58 :: 		PORTD = 0x37;
	MOVLW       55
	MOVWF       PORTD+0 
;MyProject.c,59 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	NOP
	NOP
;MyProject.c,52 :: 		for( j = 0; j < 30; j++){
	INFSNZ      main_j_L0+0, 1 
	INCF        main_j_L0+1, 1 
;MyProject.c,61 :: 		}
	GOTO        L_main6
L_main7:
;MyProject.c,62 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,63 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;MyProject.c,64 :: 		qtd = 1;
	MOVLW       1
	MOVWF       main_qtd_L0+0 
	MOVLW       0
	MOVWF       main_qtd_L0+1 
;MyProject.c,65 :: 		PORTC.f5 = 1;
	BSF         PORTC+0, 5 
;MyProject.c,66 :: 		}
L_main5:
;MyProject.c,67 :: 		if(button(&portb,4,1,0) == 255){
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       4
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;MyProject.c,68 :: 		qtd = 0;
	CLRF        main_qtd_L0+0 
	CLRF        main_qtd_L0+1 
;MyProject.c,69 :: 		PORTC.f5 = 0;
	BCF         PORTC+0, 5 
;MyProject.c,70 :: 		PORTC.F2 = 0;
	BCF         PORTC+0, 2 
;MyProject.c,71 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,72 :: 		for( j = 0; j < 20; j++){
	CLRF        main_j_L0+0 
	CLRF        main_j_L0+1 
L_main12:
	MOVLW       128
	XORWF       main_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       20
	SUBWF       main_j_L0+0, 0 
L__main28:
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
;MyProject.c,73 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;MyProject.c,74 :: 		PORTA = 0b0001000;
	MOVLW       8
	MOVWF       PORTA+0 
;MyProject.c,75 :: 		PORTD = 0x3F;
	MOVLW       63
	MOVWF       PORTD+0 
;MyProject.c,76 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	NOP
	NOP
;MyProject.c,77 :: 		PORTA = 0b0010000;
	MOVLW       16
	MOVWF       PORTA+0 
;MyProject.c,78 :: 		PORTD = 0x71;
	MOVLW       113
	MOVWF       PORTD+0 
;MyProject.c,79 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
	NOP
	NOP
;MyProject.c,80 :: 		PORTA = 0b0100000;
	MOVLW       32
	MOVWF       PORTA+0 
;MyProject.c,81 :: 		PORTD = 0x71;
	MOVLW       113
	MOVWF       PORTD+0 
;MyProject.c,82 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
	NOP
;MyProject.c,72 :: 		for( j = 0; j < 20; j++){
	INFSNZ      main_j_L0+0, 1 
	INCF        main_j_L0+1, 1 
;MyProject.c,84 :: 		}
	GOTO        L_main12
L_main13:
;MyProject.c,85 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,86 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;MyProject.c,87 :: 		}
L_main11:
;MyProject.c,88 :: 		if(qtd == 1){
	MOVLW       0
	XORWF       main_qtd_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       1
	XORWF       main_qtd_L0+0, 0 
L__main29:
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;MyProject.c,89 :: 		TRISA = 7;
	MOVLW       7
	MOVWF       TRISA+0 
;MyProject.c,90 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,91 :: 		temperatura = ADC_READ(2)/2;
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R5, 7 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       main_temperatura_L0+0 
	MOVF        R1, 0 
	MOVWF       main_temperatura_L0+1 
	MOVF        R2, 0 
	MOVWF       main_temperatura_L0+2 
	MOVF        R3, 0 
	MOVWF       main_temperatura_L0+3 
;MyProject.c,92 :: 		ti =  ADC_READ(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       main_ti_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ti_L0+1 
	MOVF        R2, 0 
	MOVWF       main_ti_L0+2 
	MOVF        R3, 0 
	MOVWF       main_ti_L0+3 
;MyProject.c,93 :: 		ti = (ti * 100 ) /1023 ;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_ti_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ti_L0+1 
	MOVF        R2, 0 
	MOVWF       main_ti_L0+2 
	MOVF        R3, 0 
	MOVWF       main_ti_L0+3 
;MyProject.c,94 :: 		tf = ADC_READ(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       main_tf_L0+0 
	MOVF        R1, 0 
	MOVWF       main_tf_L0+1 
	MOVF        R2, 0 
	MOVWF       main_tf_L0+2 
	MOVF        R3, 0 
	MOVWF       main_tf_L0+3 
;MyProject.c,95 :: 		tf = (tf*100)/1023;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_tf_L0+0 
	MOVF        R1, 0 
	MOVWF       main_tf_L0+1 
	MOVF        R2, 0 
	MOVWF       main_tf_L0+2 
	MOVF        R3, 0 
	MOVWF       main_tf_L0+3 
;MyProject.c,96 :: 		wordtostr(temperatura,saida);
	MOVF        main_temperatura_L0+0, 0 
	MOVWF       R0 
	MOVF        main_temperatura_L0+1, 0 
	MOVWF       R1 
	MOVF        main_temperatura_L0+2, 0 
	MOVWF       R2 
	MOVF        main_temperatura_L0+3, 0 
	MOVWF       R3 
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_saida_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;MyProject.c,97 :: 		lcd_out(1,1,"Temp:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,98 :: 		lcd_out_cp(saida);
	MOVLW       main_saida_L0+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,99 :: 		CustomChar(1,11);
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       11
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;MyProject.c,100 :: 		lcd_out_cp("C");
	MOVLW       ?lstr2_MyProject+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_MyProject+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,101 :: 		lcd_out(2,1,"TMin:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,102 :: 		wordtostr(ti,saida);
	MOVF        main_ti_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ti_L0+1, 0 
	MOVWF       R1 
	MOVF        main_ti_L0+2, 0 
	MOVWF       R2 
	MOVF        main_ti_L0+3, 0 
	MOVWF       R3 
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_saida_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;MyProject.c,103 :: 		lcd_out_cp(saida);
	MOVLW       main_saida_L0+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,104 :: 		CustomChar(2,11);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       11
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;MyProject.c,105 :: 		lcd_out_cp("C");
	MOVLW       ?lstr4_MyProject+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr4_MyProject+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,106 :: 		lcd_out(3,-3,"TMax:");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       253
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,107 :: 		wordtostr(tf,saida);
	MOVF        main_tf_L0+0, 0 
	MOVWF       R0 
	MOVF        main_tf_L0+1, 0 
	MOVWF       R1 
	MOVF        main_tf_L0+2, 0 
	MOVWF       R2 
	MOVF        main_tf_L0+3, 0 
	MOVWF       R3 
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_saida_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;MyProject.c,108 :: 		lcd_out_cp(saida);
	MOVLW       main_saida_L0+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(main_saida_L0+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,109 :: 		CustomChar(3,7);
	MOVLW       3
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       7
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;MyProject.c,110 :: 		lcd_out_cp("C");
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;MyProject.c,112 :: 		if(temperatura >= (tf*0.9)){
	MOVF        main_tf_L0+0, 0 
	MOVWF       R0 
	MOVF        main_tf_L0+1, 0 
	MOVWF       R1 
	MOVF        main_tf_L0+2, 0 
	MOVWF       R2 
	MOVF        main_tf_L0+3, 0 
	MOVWF       R3 
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       102
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        main_temperatura_L0+0, 0 
	MOVWF       R0 
	MOVF        main_temperatura_L0+1, 0 
	MOVWF       R1 
	MOVF        main_temperatura_L0+2, 0 
	MOVWF       R2 
	MOVF        main_temperatura_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
;MyProject.c,113 :: 		portd = 255;
	MOVLW       255
	MOVWF       PORTD+0 
;MyProject.c,114 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main20:
	DECFSZ      R13, 1, 1
	BRA         L_main20
	DECFSZ      R12, 1, 1
	BRA         L_main20
	DECFSZ      R11, 1, 1
	BRA         L_main20
;MyProject.c,115 :: 		portd = ~portd;
	COMF        PORTD+0, 1 
;MyProject.c,116 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main21:
	DECFSZ      R13, 1, 1
	BRA         L_main21
	DECFSZ      R12, 1, 1
	BRA         L_main21
	DECFSZ      R11, 1, 1
	BRA         L_main21
;MyProject.c,117 :: 		}
L_main19:
;MyProject.c,118 :: 		if(temperatura >= tf ){
	MOVF        main_tf_L0+0, 0 
	MOVWF       R4 
	MOVF        main_tf_L0+1, 0 
	MOVWF       R5 
	MOVF        main_tf_L0+2, 0 
	MOVWF       R6 
	MOVF        main_tf_L0+3, 0 
	MOVWF       R7 
	MOVF        main_temperatura_L0+0, 0 
	MOVWF       R0 
	MOVF        main_temperatura_L0+1, 0 
	MOVWF       R1 
	MOVF        main_temperatura_L0+2, 0 
	MOVWF       R2 
	MOVF        main_temperatura_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
;MyProject.c,119 :: 		PORTC.F2 = 1;
	BSF         PORTC+0, 2 
;MyProject.c,120 :: 		}else if( temperatura <= ti){
	GOTO        L_main23
L_main22:
	MOVF        main_temperatura_L0+0, 0 
	MOVWF       R4 
	MOVF        main_temperatura_L0+1, 0 
	MOVWF       R5 
	MOVF        main_temperatura_L0+2, 0 
	MOVWF       R6 
	MOVF        main_temperatura_L0+3, 0 
	MOVWF       R7 
	MOVF        main_ti_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ti_L0+1, 0 
	MOVWF       R1 
	MOVF        main_ti_L0+2, 0 
	MOVWF       R2 
	MOVF        main_ti_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;MyProject.c,121 :: 		PORTC.F2 = 0;
	BCF         PORTC+0, 2 
;MyProject.c,122 :: 		}
L_main24:
L_main23:
;MyProject.c,124 :: 		}
L_main18:
;MyProject.c,125 :: 		}
	GOTO        L_main3
;MyProject.c,126 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
