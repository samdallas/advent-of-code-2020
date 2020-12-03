#!/usr/bin/python
import csv

array_in = []
with open('./input.csv') as csvfile:
  myreader = csv.reader(csvfile, delimiter=' ')
  for row in myreader:
    array_in.append(row[0])

def tree_count(x_jump, y_jump):
  n_trees = 0
  x_pos = 0
  y_pos = 0
  row_len = len(array_in[0])
  while y_pos < len(array_in):
    if array_in[y_pos][x_pos % row_len] == "#":
      n_trees += 1
    x_pos += x_jump
    y_pos += y_jump
  return n_trees


print(tree_count(3, 1))

print(tree_count(1, 1) * \
tree_count(3, 1) * \
tree_count(5, 1) * \
tree_count(7, 1) * \
tree_count(1, 2))