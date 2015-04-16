// Bruno Pinto Silva Cartão: 217446 bpsilva
#define TAM 997
#include<string.h>
#include<stdio.h>
#include<stdlib.h>

typedef struct hash
{
struct hash *prox;
char* word;
int type;
}hash_node;

hash_node *table[TAM];

void print();
struct hash* insert(char* text, int type);
void initMe();
int genAddress();


