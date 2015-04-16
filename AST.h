#include"hash.h"
#define MAX_SONS 4

typedef struct astree_node
{
	int type;
	hash_node *symbol;
	struct astre_node *sons[MAX_SONS];
}ASTREE;

ASTREE* root;

ASTREE* create(int type, hash_node *symbol,struct astre_node *son0, struct astre_node *son1, struct astre_node *son2,struct astre_node *son3 );
void print(ASTREE* node);
