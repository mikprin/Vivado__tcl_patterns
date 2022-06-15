
// ------ DEFINITION FILE FOR INBYTE ------

#include "xparameters.h"
#include "xuartps_hw.h"

#ifdef __cplusplus
extern "C" {
#endif
char inbyte(void);
#ifdef __cplusplus
}
#endif 

char inbyte(void) {
	 return XUartPs_RecvByte(STDIN_BASEADDRESS);


#ifdef __cplusplus
extern "C" {
#endif
void outbyte(char c); 

#ifdef __cplusplus
}
#endif 

void outbyte(char c) {
	 XUartPs_SendByte(STDOUT_BASEADDRESS, c);
}





// USECASE

c = inbyte();
if(c == '\r')
{
    outbyte('\n');
}
printf("\n\rOption Selected : %c",c);
outbyte(c);
printf("\n\n");