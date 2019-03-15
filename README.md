# C/C++ Code Coverage 

## Pre-conditions

```
pip install --upgrade gcovr
g++-5 installed
```

## Instructions for all tools
```
clean         # Clears up completely
make          # Executes the code analysis with all tools (lcov, gcovr (variant I), gcovr (variant II) and gcov.
make firefoxy # Calls all generated code coverage reports
```

Calls all generated code coverage reports `firefox lcov/html/index.html gcovr/html/index.html gcovr-varII/html/index.html`


## Determination of the code coverage with the tool `lcov`

```
lcov-action 
lcov-clean 
```


## Determination of the code coverage with the tool `gcovr (variant I)` 

With this variant, the required gcov files are created in the background.

```
gcovr-action 
gcovr-clean 
```


## Determination of the code coverage with the tool `gcovr (variant II)`

With this variant, the GCOV files were created in preliminary stage.

```
gcovr-action2 
gcovr-clean2 
```

## Code Coverage nur mit gcov ermitteln

```
gcov-action
gcov-clean 
```

## Links

* https://wiki.documentfoundation.org/Development/Lcov
 
