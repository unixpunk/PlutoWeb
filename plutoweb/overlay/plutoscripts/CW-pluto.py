#!/usr/bin/python
#
## Python CW beacon for ADALM-Pluto
# 
# Original morse processing made by Bertrand FG8OJ (https://github.com/fg8oj/cwkeyer)
# Adapted to Pluto : LamaBleu - 01/2019
# Using a smooth mix of iio-python, bash-iio, and iio_attr...

import os
import iio
import time
import sys, getopt
import signal
def main(argv):
	wpm=10
	frequency=433750000
	text=''
	try:
	        text=argv[len(argv)-1]
		opts, args = getopt.getopt(sys.argv[1:],"f:w:",["frequency=","wpm="])
	except getopt.GetoptError:
		print "test.py -f frequency -w wpm TEXTTOSEND"
		usage()
		sys.exit(2)
	for opt, arg in opts:
		if opt in ("-f", "--frequency"):
			frequency=int(arg)-250000
		elif opt in ("-w","--wpm"):
			wpm=int(arg)
		else:
			text=arg
			
	send(wpm,text,frequency)
	os.system("echo 0 440 0 0  > /sys/kernel/debug/iio/iio:\device1/bist_tone")
	sys.exit(2)


class SIGINT_handler():
    def __init__(self):
        self.SIGINT = False

    def signal_handler(self, signal, frame):
        print('\nYou pressed Ctrl+C!\n\n')
        self.SIGINT = True


handler = SIGINT_handler()
signal.signal(signal.SIGINT, handler.signal_handler)


def send(wpm,text,frequency):
	ctx = iio.Context('local:')
	ctrl = ctx.find_device("ad9361-phy")
	txLO = ctrl.find_channel("altvoltage1", True)
        Fs = int(str(txLO.attrs["frequency"].value))
	os.system("iio_attr -q -c  ad9361-phy voltage0 sampling_frequency 2000000 >/dev/null 2>&1")
        os.system("iio_attr -q -c ad9361-phy altvoltage1 frequency " + str(frequency) + " >/dev/null 2>&1")
        print "\n\n\n\n     !! Pluto TX freq is 250kHz below CW carrier !!"
        print "TX LO : actual freq: " , Fs , "   -    new freq: " , frequency
        print "\nCW frequency :   " , frequency+250000 , " (= TX_LO + 250000) \n"
	
	coef=10
	CODE = {'A': '.-',     'B': '-...',   'C': '-.-.', 
        'D': '-..',    'E': '.',      'F': '..-.',
        'G': '--.',    'H': '....',   'I': '..',
        'J': '.---',   'K': '-.-',    'L': '.-..',
        'M': '--',     'N': '-.',     'O': '---',
        'P': '.--.',   'Q': '--.-',   'R': '.-.',
        'S': '...',    'T': '-',      'U': '..-',
        'V': '...-',   'W': '.--',    'X': '-..-',
        'Y': '-.--',   'Z': '--..',

        '0': '-----',  '1': '.----',  '2': '..---',
        '3': '...--',  '4': '....-',  '5': '.....',
        '6': '-....',  '7': '--...',  '8': '---..',
        '9': '----.',' ':'*' 
        }
	print "speed=",wpm
	print "text=",text, "\n\n\n"
	for letter in text:
		letter=letter.upper()
		for sign in CODE[letter]:
			if sign=="*":
				time.sleep(0.3/wpm*coef)
			else:
				os.system("echo 1 440 0 0  > /sys/kernel/debug/iio/iio\:device1/bist_tone")
				time.sleep(0.1/wpm*coef)
				if sign=="-":
					time.sleep(0.2/wpm*coef)
				os.system("echo 0 440 0 0  > /sys/kernel/debug/iio/iio\:device1/bist_tone")
				time.sleep(0.1/wpm*coef)
		time.sleep(0.3/wpm*coef)
		if handler.SIGINT:
                    break
	return

if __name__ == "__main__":
	main(sys.argv)

