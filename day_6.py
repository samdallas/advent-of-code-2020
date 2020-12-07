#!/usr/bin/python
import csv
import re

# part 1
total = 0

with open('./input.csv') as csvfile:
  data = csvfile.read()
  for group in data.split("\n\n"):
    answers = set()
    for person in group.split("\n"):
      for answer in person:
        answers.add(answer)
    total += len(answers)

print(total)

# part 2
total = 0

with open('./input.csv') as csvfile:
  data = csvfile.read()
  for group in data.split("\n\n"):
    people_list = []
    answers_in_common = 0
    for person in group.split("\n"):
      people_list.append(person)
    for answer in people_list[0]:
      if all(answer in person for person in people_list):
        answers_in_common += 1

    total += answers_in_common

print(total)
