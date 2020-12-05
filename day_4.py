#!/usr/bin/python
import csv
import re

n_valid = 0

# could do with one horrifying regex instead

# part 1
with open('./input.csv') as csvfile:
  data = csvfile.read()
  for cred_set in data.split("\n\n"):
    req_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    credentials = re.split('\n| ', cred_set)
    d = dict(x.split(":") for x in credentials)
    if all(item in d.keys() for item in req_keys):
      n_valid += 1


# part 2

def year_check(year_str, min_year, max_year):
  year = int(year_str)
  if re.match(r"^\d\d\d\d$", year_str) and year >= min_year and year <= max_year:
    return True
  return False

def height_check(height_str):
  if not re.match(r"^\d+cm$|^\d+in$", height_str): return False

  height = int(height_str[0:-2])
  unit = height_str[-2:]
  if unit == "cm" and height >= 150 and height <= 193:
    return True
  elif unit == "in" and height >= 59 and height <= 76:
    return True
  return False

with open('./input.csv') as csvfile:
  data = csvfile.read()
  for cred_set in data.split("\n\n"):
    req_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    credentials = re.split('\n| ', cred_set)
    d = dict(x.split(":") for x in credentials)
    if all(item in d.keys() for item in req_keys):
      if not year_check(d["byr"], 1920, 2002): continue
      if not year_check(d["iyr"], 2010, 2020): continue
      if not year_check(d["eyr"], 2020, 2030): continue
      if not height_check(d["hgt"]): continue
      if not re.match(r"^#\w{6}$", d["hcl"]): continue
      if not d["ecl"] in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]: continue
      if not re.match(r"^\d{9}$", d["pid"]): continue
      n_valid += 1

print(n_valid)


