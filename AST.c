#include "AST.h"
#include <stdlib.h>
#include <stdio.h>

ASTREE* create(int type, hash_node *symbol, struct astre_node *son0, struct astre_node *son1, struct astre_node *son2,struct astre_node *son3 )
{
	ASTREE *newnode = 0;
	newnode = (ASTREE*)calloc(1, sizeof(ASTREE));
	newnode->symbol = symbol;
	newnode->type = type;
	newnode->sons[0] = son0;
	newnode->sons[1] = son1;
	newnode->sons[2] = son2;
	newnode->sons[3] = son3;
	return newnode;
}



