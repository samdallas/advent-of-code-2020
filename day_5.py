#!/usr/bin/python
import csv

def find_row(row_code):
  lo = 0
  hi = 127
  for char in row_code:
    if char == "F":
      hi -= (hi - lo + 1)/2
    else:
      lo += (hi - lo + 1)/2
  return int(lo)

def find_col(col_code):
  lo = 0
  hi = 7
  for char in col_code:
    if char == "L":
      hi -= (hi - lo + 1)/2
    else:
      lo += (hi - lo + 1)/2
  return int(lo)

def find_id(r, c):
  return (r * 8) + c

def decode(boarding_pass):
  row_num = find_row(boarding_pass[0:7])
  col_num = find_col(boarding_pass[-3:])
  return find_id(row_num, col_num)

max_val = 0
full_list = []

# part 1
with open('./input.csv') as csvfile:
  myreader = csv.reader(csvfile)
  for row in myreader:
    val = decode(row[0])
    full_list.append(val)
    if val > max_val:
      max_val = val

print(max_val)


# part 2
for row in range(0,127):
  for col in range(0, 7):
    seat_id = (row * 8) + col

    if col == 0:
      n1 = find_id(row - 1, 7)
    else:
      n1 = find_id(row, col - 1)

    if col == 7:
      n2 = find_id(row + 1, 0)
    else:
      n2 = find_id(row, col + 1)

    if seat_id not in full_list and n1 in full_list and n2 in full_list:
      print( seat_id)

