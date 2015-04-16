
#include "AST.h"
#include "hash.h"
#include <stdlib.h>
#include <stdio.h>


astree_node* astcreate(int type, struct hash *symbol,  astree_node *son0,  astree_node *son1,  astree_node *son2, astree_node *son3)
{
	astree_node *newnode = 0;
	newnode = (astree_node*)calloc(1, sizeof(astree_node));
	newnode->symbol = symbol;
	newnode->type = type;
	newnode->sons[0] = son0;
	newnode->sons[1] = son1;
	newnode->sons[2] = son2;
	newnode->sons[3] = son3;
	return newnode;
}

void printast(astree_node* node)
{




}


