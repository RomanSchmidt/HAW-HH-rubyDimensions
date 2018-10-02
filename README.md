# Ruby Dimensions

This tool is written in Ruby on Rails to calculate from one dimension of a scale to another.

For this you will find a mapping.json that contains all mapping information.

You can choose between a single output of a conversion
or a series of outputs between a start and end value
choose with the help of a step size.

The start Class is Main in the main.rb.

This is a pure CLI tool. You can start it directly and get an ASCII menu. This will require input to convert the various
values.

#### Menu

It is possible to start the program with the -h or -m parameter to get a printout of the help.

There you will find a list of all possible parameters that can lead to a direct output without further prompts and
without menu output.

### Menu

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
║   -render_type=[integer] 0=range, 1=single                           ║
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

### Usage examples

###### all parameters for a single output example
````
-category=1 -first_convert=1 -second_convert=1 -first_dimension=1 -second_dimension=1 -render_type=1 -value=1
````

###### all parameters for a range output example
````
-category=1 -first_convert=1 -second_convert=1 -first_dimension=1 -second_dimension=1 -render_type=2 -start_value=1 -end_value=100 -step_value=2
````