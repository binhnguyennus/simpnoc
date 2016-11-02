#!/bin/python

# this is a script to apply basic formatting to certain keywords

from termcolor import colored, cprint
import sys

styles = {
	'Router': ('blue', []),
	'Source': ('green', []),
	'FIFO': ('yellow', []),
	'read_ptr|write_ptr|full|empty': ('magenta', []),
	'TX_LOGIC|RX_LOGIC': ('cyan',[]),
	'Sink': ('red', []),
	'sending|pushing|fetching|acknowledging': (None, ['bold']),
	'received|pushed|popped|found': (None, ['bold']),
	'!!': ('red', ['bold']),
};

def main():
	while True:
		line = sys.stdin.readline()
		if line:
			for words, style in styles.iteritems():
				for word in words.split('|'):
					color, attrs = style
					styledWord = colored(word, color, attrs=attrs)
					line = line.replace(word, styledWord)
			sys.stdout.write(line)
		else:
			break

main()