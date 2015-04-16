#ifndef _AST_H
#define _AST_H

#define MAX_SONS 4
typedef struct astree_node
{
	int type;
	struct hash *symbol;
	struct astree_node *sons[MAX_SONS];
}astree_node;

astree_node* astree;

#define GLOBAL_VAR_DEF 1
#define FUNC_DEF 2

astree_node* astcreate(int type, struct hash *symbol, astree_node *son0, astree_node *son1, astree_node *son2, astree_node *son3);
void printast(astree_node* astree);

#endif
