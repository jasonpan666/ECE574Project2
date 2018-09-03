/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
*
*****************************************************************************/
//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: helloworld
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xiomodule.h"


void delay_ms(uint i)
{
        volatile uint a,b;
        for(a=0;a<i;a++)
                for(b=0;b<4170;b++);
}


int main()
{
    init_platform();

    XIOModule iomodule;

    XIOModule_Initialize(&iomodule, XPAR_IOMODULE_0_DEVICE_ID);
    XIOModule_Start(&iomodule);

    XIOModule_CfgInitialize(&iomodule, NULL, 1);

    u32 key_in;
    u32 num[2];
    int pointer = 0;
    u32 serial_data;
    u8 data;
    int LED = 0000000000000001;
    //int temp = 0;
    xil_printf("Zhenyu Pan\n\r");

    while(1)
    {
    	data = XIOModule_DiscreteRead(&iomodule, 1);

    	switch (data)
    	{
    	     case 1:

    	    	 xil_printf("ECE574 Project2\n\r");

    	     case 2:
	    		     XIOModule_DiscreteWrite(&iomodule, 4, LED);
	    		     delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<1);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<2);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<3);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<4);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<5);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<6);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<7);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<8);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<9);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<10);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<11);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<12);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<13);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<14);
    	    		 delay_ms(1000);

    	    		 XIOModule_DiscreteWrite(&iomodule, 4, LED<<15);
    	    		 delay_ms(1000);


    	     case 4:

    	    	 key_in = inbyte();

    	    	     	if((key_in >= 0x30)&&(key_in <= 0x39))
    	    	     	{
    	    	     		outbyte(key_in);
    	    	     		if (pointer == 0)
    	    	     		{
    	    	     			num[pointer] = key_in;
    	    	     			pointer = 1;
    	    	     		}
    	    	     		else if (pointer == 1)
    	    	     		{
    	    	     			num[pointer] = key_in;
    	    	     			pointer = 0;
    	    	     			serial_data = 10 * (num[0]&0x0f) + (num[1]&0x0f);
    	    	     			XIOModule_DiscreteWrite(&iomodule, 1, 16 * (num[0]&0x0f) + (num[1]&0x0f));
    	    	     			XIOModule_DiscreteWrite(&iomodule, 2, serial_data * 255 / 33);
    	    	     			XIOModule_DiscreteWrite(&iomodule, 3, 2);
    	    	     			outbyte('\n');
    	    	     			xil_printf("The voltage is %d\n\r", serial_data);
    	    	     			xil_printf("press A for sine wave, B for triangle wave, C for square wave, input numbers for voltage\n\r");
    	    	     		}
    	    	     	}
    	    	     	if(key_in == 'A')
    	    	     	{
    	    	     		outbyte(key_in);
    	    	     		pointer = 0;
    	    	     		serial_data = 0;
    	    	     		XIOModule_DiscreteWrite(&iomodule, 1, 0); // display set to zero
    	    	     		XIOModule_DiscreteWrite(&iomodule, 2, serial_data);
    	    	     		XIOModule_DiscreteWrite(&iomodule, 3, 1);
    	    	     		outbyte('\n');
    	    	     		xil_printf("Sine wave !\n\r");
    	    	     	}
    	    	     	if(key_in == 'B')
    	    	     	{
    	    	     		outbyte(key_in);
    	    	     		pointer = 0;
    	    	     		serial_data = 0;
    	    	     		XIOModule_DiscreteWrite(&iomodule, 1, 0);
    	    	     		XIOModule_DiscreteWrite(&iomodule, 2, serial_data);
    	    	     		XIOModule_DiscreteWrite(&iomodule, 3, 0);
    	    	     		outbyte('\n');
    	    	     		xil_printf("Triangle wave!\n\r");
    	    	     	}
						if(key_in == 'C')
    	    	     	{
    	    	     		outbyte(key_in);
    	    	     		pointer = 0;
    	    	     		serial_data = 0;
    	    	     		XIOModule_DiscreteWrite(&iomodule, 1, 0);
    	    	     		XIOModule_DiscreteWrite(&iomodule, 2, serial_data);
    	    	     		XIOModule_DiscreteWrite(&iomodule, 3, 1);
    	    	     		outbyte('\n');
    	    	     		xil_printf("Square wave !\n\r");
						};

    	    }

    }
    cleanup_platform();
    return 0;
}
