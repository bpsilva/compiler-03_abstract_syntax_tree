
 #ifndef HASH_H_
  #define HASH_H_
  #include "hash.h"
  #endif

#define MAX_SONS 4

typedef struct astree_node
{
	int type;
	hash_node *symbol;
	struct astre_node *sons[MAX_SONS];
}ASTREE;

ASTREE* astree;

ASTREE* create(int type, hash_node *symbol,struct astre_node *son0, struct astre_node *son1, struct astre_node *son2,struct astre_node *son3 );
void print(ASTREE* node);
