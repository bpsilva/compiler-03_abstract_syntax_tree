This is the third part of the project of building my own compiler. It is part of the the grade to the course of Compilers (INF01147) at Federal University of Rio Grande do Sul.  

==================================================  

In order to run you must have flex and yacc installed (ubuntu/debian):  
 **sudo apt-get install flex**  
 **sudo apt-get install byacc**  

After that you just need to run the Makefile:  
 **make**

This software makes a lexical and syntactic analysis and generates an abstract syntax tree that will make possible the next stage of the compiling process (semantic analysis).
As an evidence of the correct generation of the tree, it makes the inverse path too. That is, based on the tree, it generates a code file that should be equivalent to the original one.  

In order to run:  
 **./etapa3 < entry_file out_file**  

Four entry file examples are provided: 'entry', 'example', 'example1' and 'example-error'.  

==================================================

To better understand the software objective please go to the work description (in portuguese):  
[Task description](https://bitbucket.org/bpsilva/compiler-03_abstract_syntax_tree/raw/246e027fb2873b12aec9ddeac5425e4f8d27dcff/definition.pdf)  

See the previous stages of the project too (they are both included in this stage):  
[First stage: lexical analysis](https://bitbucket.org/bpsilva/compiler-01_lexical_analysis)  
[Second stage: syntactic analysis](https://bitbucket.org/bpsilva/compiler-02_syntactic_analysis)