﻿"""
Taken from
https://gist.github.com/n8henrie/08a31f02fd1282d12b75
"""
import sys
import pandas

url = input("Enter the URL: ")
tables = pandas.io.html.read_html(url)

for index, table in enumerate(tables):
    print("Table {}:".format(index + 1))
    print(table.head() + '\n')
    print('-' * 60)
    print('\n')

choice = int(input("Enter the number of the table you want: ")) - 1
filename = input("Enter a filename (.csv extension assumed): ") + '.csv'

with open(filename, 'w') as outfile:
    tables[choice].to_csv(outfile, index=False, header=False)