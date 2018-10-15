# Ruby Dimensions

```
PR01 HAWariten
Author: Roman Schmidt, Daniel Osterholz
```

This tool is written in Ruby to calculate from one dimension of a scale to another.

For this you will find a mapping.json that contains all mapping information.

The start Class is Main in the main.rb.

This is a pure CLI tool. You can start it directly and get an ASCII menu. This will require input to convert the various
values.

### Handling / Limitation

This Script let you select the json keys of the categories down the three until it finds leaf = true.
You will need to go the three two times down before you choose a convert value.
In case the two dimensions are defined to be able to converted in the json, you will get an output or an error.

The script uses only integers to accept the selection in the menu. It is therefore not possible to choose invalid 
dimensions or scales freely.

Please make sure that the indicated values ​​are within the valid ranges. Otherwise you will receive an error message and 
you will be asked for a new value, even if you enter it via parameters.

### Known Issues

The console output is not working properly at ruby mine own console due to font.

The colors of the error output is not working properly in Eclipse.

There is not much of checks if the json inputs are valid + json is valid.

For the case of simplicity you will just get an error that you are not able to convert e.g. from mm to kelvin just after
the last input.