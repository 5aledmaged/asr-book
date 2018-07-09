#include<avr/io.h>
#define	F_CPU	8000000
#include<util/delay.h>
#include <avr/interrupt.h>
unsigned char re_char = 's';
volatile unsigned char state = 0x0A;
void usart_init();
void usart_data_transmit(unsigned char data );
void forward (void);
void backward (void);
void left (unsigned char x);
void right (unsigned char x);
void stop (void);
ISR(USART_RXC_vect)
{
	re_char = UDR; // Fetch the received byte value into the variable "ByteReceived"
	//usart_data_transmit(re_char);// Echo back the received byte back to the computer
	switch (re_char){
		case 'f' :{
			forward ();
			break;
		}
		case 'l' :{
			left(state);
			break;	
		}
		case 'r':{
			right(state);
			break;
		}
		case 'b' :{
			backward ();
			break;
		}
		case 's':{
			stop ();
			break;
		}
		default:{
			PORTB = state;
		}
		
	}
}
int main(void)
{
	DDRB=0x0f;
	usart_init();
	sei();
	while(1)
	{
				
	}
}
void usart_init()
{
	UBRRH = 0;
	UBRRL =51;
	UCSRB|= (1<<RXEN)|(1<<TXEN)|(1<<RXCIE);
	UCSRC |= (1 << URSEL)|(3<<UCSZ0);
	
}
void usart_data_transmit(unsigned char data )
{
	while ( !( UCSRA & (1<<UDRE)) ) ;
	UDR = data;
}
void stop (void){
	PORTB=0x0f;
	state = 0x0f;
	
	
}
void forward (void){
	PORTB=0x0A;
	state = 0x0A;
	
}
void backward (void){
	PORTB=0x05;
	state = 0x05;
	
}
void left (unsigned char x){
	if (x == 0x0A || x==0x0f )PORTB=0x02;
	else PORTB=0x04;
	_delay_ms(500);
	_delay_ms(500);
	PORTB=state;
}
void right (unsigned char x){
	if (x == 0x0A || x==0x0f )PORTB=0x08;
	else PORTB=0x01;
	_delay_ms(500);
	_delay_ms(500);
	PORTB=state;
}
