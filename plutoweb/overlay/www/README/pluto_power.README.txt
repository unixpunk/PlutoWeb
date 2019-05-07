MiniSNA for pluto, using pow tool and gnuplot
=============================================


pow is a simple tool to get signal level from pluto at a specific frequency.  
It returns frequency (Hz), signal level (dB), RSSI gathered through IIO (dB)  

Large part of the code is coming from [power.c by ADI](https://github.com/analogdevicesinc/plutosdr_scripts/blob/master/power.c)


Build pow tool : 
================

      gcc -std=gnu99 -g -o pow pow.c -liio -lm -Wall -Wextra
      
   Test : 
      ./pow -l 430600000 -g 40 -f 3   
 
 result : 430600000 2.49 95.75   
 units  : freq (Hz), signal (dB), RSSI (dB)   
            
 
Test a filter :
===============

 - pre-requisite: gnuplot gnuplot-qt packages  
 - use mini_sna.sh  
 - launch mini_sna.sh. --> parameters : fstart fend step RXgain (freq in kHz)  
                           example : ./mini_sna.sh 410000 470000 500 50  
 - result file is test.csv  
 - launch plot.sh to draw plot.  
   
   
You can also edit mini-sna.sh to change samplerate (-f) for pow tool.  
Bandwidth is set to 200kHz.  


![image](https://user-images.githubusercontent.com/26578895/57102867-b1c15b00-6d24-11e9-85f3-18c58e0aae65.png)
