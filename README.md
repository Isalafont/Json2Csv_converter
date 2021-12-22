# Convert Json2Csv

A simple ruby lib to convert JSON into CSV.

The goal of this test is to write a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a CSV file where one line equals one object.

## Usage

### By running the lib file into terminal

```shell
$ ruby lib/convertJsonCSV_cmd.rb 'data_input/{#name_input_file}' 'data_output/{#name_output_file}
```

### By running the file in the console

Comment line 63 : ConvertJsonCSV.create_csv('./data_input/users.json', './data_output/users2.csv')

```shell
$ irb
$ load 'convertJsonCSV.rb'
$ ConvertJsonCSV.create_csv('your_file_PATH/data_input/users.json', 'your_file_PATH/data_output/users2.csv')
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

## New Instruction

- L'objectif global du test : Lorsque l'on execute la cmd "\$ruby le*programme_d'entrée.rb", tous les fichiers *.json qui sont dans /input*json_files, soient convertis (ou non) en *.csv dans /output*csv_files.
  \_Les fichiers Input peuvent ne pas être sous format JSON ET/OU formatés différement.*

### Etape possible

- Accès au dossier /input
- Récupération des fichiers
- Validation des fichiers
- Gestion d'erreur possibles

**Puis traitement pour chaque fichier que le programme puisse accepter.**

- Lecture (parsing) du fichier
- Traitement du header csv
- Création du fichier .csv
- Formatage des données pour chaque colonnes du csv
- _Gestion d'erreur possibles (si chaque entrée du tableau de json ne dispose pas des mêmes clefs ? Si pour certaines clefs tu as un second niveau de tableau avec du json imbriqué, comment "aplatir" ces données en deux dimensions pour les colonnes d'un csv ?)_

_La stratégie avec laquelle tu vas structurer ton programme est fondamentale pour cet exercice._

Si un module te permet de défiler de façon procédurale les étapes à l'entrée du programme, il pourrait être intéressant d'avoir des classes ruby, ayant des responsabilité bien définies et isolées : lecture du dossier, parsing, traitement du header, écriture...
