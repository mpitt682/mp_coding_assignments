# -*- coding: utf-8 -*-
"""
Created on Sat May  4 16:37:11 2024

@author: pittm
"""

# Assignment was to parse a text file of emails and determine which address sent the most

fhand = open('mbox.txt', 'r')

# create a dictionary to store each email address and how many messages each sent
email_count = dict() 

for line in fhand:
    if line.startswith('From '): # Find the beginning of a sent message
        words = line.split()
        email = words[1] # email address is the second term in the line
        email_count[email] = email_count.get(email, 0) + 1 # add 1 for current message to current sent email count 
             
email_lst = list()

for email, count in email_count.items():
    email_lst.append((count, email)) # create a tuple to swap key/value pairs

email_lst.sort(reverse = True) # sort list max to min by sent email count

max_count, max_email = email_lst[0] 

print(f'The person with the highest number of sent messages is {max_email} with {max_count} messages.')