
#ifndef _DECOMPILER_H
#define _DECOMPILER_H
#include "AST.h"
#include <string.h>
void asttofile(astree_node* node);
void filewrite(char* text);
void writechar(char c);
#endif
