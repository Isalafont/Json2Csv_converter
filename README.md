# Convert Json2Csv

A simple ruby lib to convert JSON into CSV.

The goal of this test is to write a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a CSV file where one line equals one object.

## Usage

### By running the lib file into terminal

```shell
$ ruby lib/convertJsonCSV.rb
...
```

### By running the file in the console

Comment line 63 : ConvertJsonCSV.create_csv('./data_input/users.json', './data_output/users2.csv')

```shell
$ irb
$ load 'convertJsonCSV.rb'
$ ConvertJsonCSV.create_csv('your_input_file/data_input/users.json', 'your_input_file/data_output/users2.csv')
```

Some sample files are located in `./input_json_files` and `./output_csv_files`

### Test criteria

- clean
- extensible
- robust (don't overlook edge cases, use exceptions where needed, ...)
- tested

## TODO Left

- Test
- Fix bug
- Robust
