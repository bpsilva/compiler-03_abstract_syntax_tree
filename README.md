In order to run you must have flex and yacc installed (ubuntu/debian):  
 **sudo apt-get install flex**  
 **sudo apt-get install byacc**  

After that you just need to run the Makefile:  
 **make**

This software generates an abstract syntax tree that will make possible the next stage of the compiling process (semantic analysis).
To prove correct generation of the tree, it makes the inverse path too. That is, based on the tree, generates a code file that should be equivalent to the original one.  

In order to run:  
 **./etapa3 < entry_file out_file**  

Four example entry files are provided: 'entry', 'example', 'example1' and 'example-error'.  

==================================================

To better understand the software objective please go to the work description (in portuguese):  
[Work description](https://bitbucket.org/bpsilva/compiler-02_syntactic_analysis/raw/ca77046c56d9f7fafab516dc0e3f3a504c5a924e/definition.pdf)  

See the previous stages of the project too:  
[First stage](https://bitbucket.org/bpsilva/compiler-02_syntactic_analysis/raw/ca77046c56d9f7fafab516dc0e3f3a504c5a924e/definition.pdf)  
[Second stage](https://bitbucket.org/bpsilva/compiler-02_syntactic_analysis/raw/ca77046c56d9f7fafab516dc0e3f3a504c5a924e/definition.pdf)