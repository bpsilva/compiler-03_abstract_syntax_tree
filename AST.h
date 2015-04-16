#ifndef _AST_H
#define _AST_H

#define MAX_SONS 4
typedef struct astree_node
{
	int type;
	struct hash *symbol;
	struct astree_node *sons[MAX_SONS];
}astree_node;

#define PROGRAM 0 
#define INIT 1
#define GLOBAL_VAR_DEF 2
#define FUNC_DEF 3
#define GLOBAL_VAR_DEF_INIT 4
#define GLOBAL_VAR_DEF_PTR 5
#define GLOBAL_VAR_DEF_VEC 6
#define GLOBAL_VAR_DEF_VEC_INIT 7
astree_node* astcreate(int type, struct hash *symbol, astree_node *son0, astree_node *son1, astree_node *son2, astree_node *son3);
void printast(astree_node* astree);

#endif
