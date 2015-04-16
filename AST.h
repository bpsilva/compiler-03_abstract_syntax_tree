#ifndef _AST_H
#define _AST_H

#define MAX_SONS 4
typedef struct astree_node
{
	int type;
	struct hash *symbol;
	struct astree_node *sons[MAX_SONS];
}astree_node;

#define PROGRAM 10 
#define GLOBAL_VAR_DEF 12
#define FUNC_DEF 13
#define GLOBAL_VAR_DEF_INIT 14
#define GLOBAL_VAR_DEF_PTR 15
#define GLOBAL_VAR_DEF_VEC 16
#define GLOBAL_VAR_DEF_VEC_INIT 17
#define EXP_ADD 18
#define EXP_SUB 19
#define EXP_DIV 20
#define EXP_MUL 21
#define EXP_OR 22
#define EXP_AND 23
#define EXP_LESS 24
#define EXP_MORE 25
#define EXP_ARRAY_ACCESS 26
#define EXP_FUNC_CALL 27
#define ARG_SEQ 28

astree_node* astcreate(int type, struct hash *symbol, astree_node *son0, astree_node *son1, astree_node *son2, astree_node *son3);
void printast(astree_node* astree, int num);

#endif
