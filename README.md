# Ruby Dimensions

```
PR01 HAWariten
Author: Roman Schmidt, Daniel Osterholz
```

This tool is written in Ruby on Rails to calculate from one dimension of a scale to another.

For this you will find a mapping.json that contains all mapping information.

You can choose between a single output of a conversion or a series of outputs between a start and end value choose with 
the help of a step size.

The start Class is Main in the main.rb.

This is a pure CLI tool. You can start it directly and get an ASCII menu. This will require input to convert the various
values.

### Menu Call

The first class of this script ist main.rb.

It is possible to start the program with the -h or -m parameter to get a printout of the help.

There you will find a list of all possible parameters that can lead to a direct output without further prompts and
without menu output.

### Menu Printout

```
╔══════════════════════════════════════════════════════════════════════╗
║ You can start this script without parameters to get the menu.        ║
║                                                                      ║
║ You can put one or more following parameters to skip the input:      ║
║   -h -m to get this help screen                                      ║
║   -category=[integer] e.g. 0 = metrication                           ║
║   -first_convert=[integer] e.g. 0 = metric                           ║
║   -second_convert=[integer] e.g. 0 = metric                          ║
║   -first_dimension=[integer] e.g. 0 = mm / inc                       ║
║   -second_dimension=[integer] e.g. 0 = mm / inc                      ║
║   -output_types=[integer] 0=direct, 1=table                          ║
║   -value=[float] value for single rendering                          ║
║   -start_value=[float] start value for range rendering               ║
║   -end_value=[float] end value for range rendering                   ║
║   -step_value=[float] step value for range rendering                 ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Handling / Limitation

The script uses only integers to accept the selection in the menu. It is therefore not possible to choose invalid 
dimensions or scales freely.

Please make sure that the indicated values ​​are within the valid ranges. Otherwise you will receive an error message and 
you will be asked for a new value, even if you enter it via parameters.

### Direct Output

Converts from one dimension to an other. Prints one line of result.

###### all parameters

````
-category=1 -first_convert=1 -second_convert=1 -first_dimension=1 -second_dimension=1 -output_type=1 -value=1
````

###### output

````
╔══════════════════════════════════════════════════════════════════════╗
║ single convert from 1.0 (mm) to 1.0 (mm)                             ║
╚══════════════════════════════════════════════════════════════════════╝
````

### Table Output

Category, converts, and dimensions are taken randomly from the mapping table. 
Converts each step the value + step range * (step - 1) to the equal or an other dimension.
Completely random within the possible conversions.

###### all parameters

````
-output_type=2 -start_value=1 -end_value=10 -step_value=2
````

###### output

````
╔══════════════════════════════════════════════════════════════════════╗
║ Convert table from mil to m                                          ║
║ #1: 1.0 => 1609.33                                                   ║
║ #2: 3.0 => 4827.98                                                   ║
║ #3: 5.0 => 8046.63                                                   ║
║ #4: 7.0 => 11265.29                                                  ║
║ #5: 9.0 => 14483.94                                                  ║
╚══════════════════════════════════════════════════════════════════════╝
````

### Known Issues

The console output is not working properly at ruby mine own console due to font.

The colors of the error output is not working properly in Eclipse.

There is not much of checks if the json inputs are valid.