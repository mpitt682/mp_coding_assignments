# Assignment was to:
    # process text from a website in chunks of a predefined number of characters
    # print the first 3000 characters
    # count the total number of characters
   

import sys
import urllib.request

# Script was tested using URL files from textfiles.com, specifically the "Adventure" category
fname = input('Enter URL of a web server text file resource: ')

try:
    web_file = urllib.request.urlopen(fname)
except:
    print('Invalid URL') 
    sys.exit(0)

# Set the number of characters to be read at a time and the max number of characters to print
CHUNK_SIZE = 512
PRINT_LIMIT = 3000

printed_char = 0
total_char = 0

# create a while loop that will process entire text file
while True:
    chunk = web_file.read(CHUNK_SIZE) 
    if len(chunk) < 1: break # if there are no more characters to read, stop
    total_char += len(chunk) # every loop adds to total character count until finished
    
    if printed_char == PRINT_LIMIT: 
        continue
    # if adding the whole character chunk is still under the print limit, print the chunk and add to character counts
    elif (printed_char + CHUNK_SIZE) <= PRINT_LIMIT: 
        print(chunk.decode(), '\n')
        printed_char += len(chunk)
    #if only part of the character chunk is less than the print limit, print the number of characters that add up to the print limit
    else: 
        partial_chunk = chunk[:(PRINT_LIMIT-printed_char)] 
        printed_char += len(partial_chunk)
        print(partial_chunk.decode(), '\n')
    
print('Total character count:', total_char)
