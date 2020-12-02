#!/usr/bin/python
import csv

array_in = []
with open('./input.csv') as csvfile:
  myreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
  for row in myreader:
    array_in.append(row)

n_valid_1 = 0

for row in array_in:
  low = row[0].split("-")[0]
  high = row[0].split("-")[1]
  char = row[1][0]
  pw = row[-1]
  char_count = pw.count(char)

  if char_count <= int(high) and char_count >= int(low):
    n_valid += 1

print(n_valid_1)

# part 2
n_valid_2 = 0

for row in array_in:
  p1 = int(row[0].split("-")[0])
  p2 = int(row[0].split("-")[1])
  char = row[1][0]
  pw = row[-1]

  c1 = pw[p1-1] == char
  c2 = pw[p2-1] == char

  if c1 and not c2:
    n_valid += 1
  elif not c1 and c2:
    n_valid += 1

print(n_valid_2)
