// Bruno Pinto Silva Cartão: 217446 bpsilva


#include "hash.h"


void initMe()
{
	int i;
		for(i = 0 ; i < TAM ; i++)
		{
			table[i] = 0;
		}
	}

void print()
{
hash_node* pointer;
int i = 0;
	for(i = 0 ; i < TAM ; i++)
	{
		printf("%i: ", i);
		for(pointer = table[i]; pointer !=0 ; pointer = (struct hash*)pointer->prox)
		{
			printf("%s ", pointer->word);
		}
		printf("\n");
	}



}

struct hash* insert(char* text, int type){
	int address = genAddress(text);
	struct hash *pointer = table[address], *aux = table[address];
	int achou = 0;

	
	for(;pointer!=0; aux = pointer,	pointer= (struct hash*)pointer->prox)
	{
		if(!strcmp(text, pointer->word))
			return pointer;
	}
	
	struct hash *node = (struct hash*)malloc(sizeof(struct hash));
	node->word = (char *)calloc(1, sizeof(text));
	strcpy(node->word, text);
	node->prox = 0;
	node->type = type;
	
	if(aux!=0)
	{
		aux->prox = node;			
	}
	else{
		table[address] = node;
		}
	
return node;
}

int genAddress(char* word)
{
int i = 0;
int position = 0;
	for(i = 0; i< strlen(word);i++)
	{
	position += word[i];
	}
	position = position % TAM;

return position;
}
