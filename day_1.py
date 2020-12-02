#!/usr/bin/python
import csv

num_list = []
with open('/Users/sam/Desktop/input.csv') as csvfile:
  myreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
  for row in myreader:
    num_list.append(int(row[0]))

# part 1
for i in range(len(num_list)):
  for j in range(i+1, len(num_list)):
    if num_list[i] + num_list[j] == 2020:
      print(num_list[i]*num_list[j])


# part 2
for i in range(len(num_list)):
  for j in range(i+1, len(num_list)):
    for k in range(j+1, len(num_list)):
      if num_list[i] + num_list[j] + num_list[k] == 2020:
        print(num_list[i]*num_list[j]*num_list[k])
