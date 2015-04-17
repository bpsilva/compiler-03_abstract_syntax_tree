#include "decompiler.h"
#include "hash.h"
#include "y.tab.h"
void asttofile(astree_node* node)
{
	if(node!=0)
	switch(node->type)
	{
		
		case GLOBAL_VAR_DEF: 
			asttofile(node->sons[0]);
			asttofile(node->sons[1]);
			writechar('\n');
			asttofile(node->sons[2]);
			break;
		case FUNC_DEF:			
			asttofile(node->sons[0]);
			asttofile(node->sons[1]);
			writechar('\n');
			asttofile(node->sons[2]);
			break;
		case GLOBAL_VAR_DEF_INIT: 
			writechar(' ');	
			asttofile(node->sons[0]);
			writechar(':');
			asttofile(node->sons[1]);
			writechar(';');
			break;
		case GLOBAL_VAR_DEF_PTR:
			writechar(' ');	
			filewrite("$");	
			asttofile(node->sons[0]);
			writechar(':');
			asttofile(node->sons[1]);
			writechar(';');
			break;
		case GLOBAL_VAR_DEF_VEC : 
			writechar(' ');	
			asttofile(node->sons[0]);
			writechar('[');
			asttofile(node->sons[1]);
			writechar(']');

			writechar(';');
			break;
		case GLOBAL_VAR_DEF_VEC_INIT: 
			writechar(' ');	
			asttofile(node->sons[0]);
			writechar('[');
			asttofile(node->sons[1]);
			writechar(']');
			asttofile(node->sons[2]);
			writechar(';');
			break;
		case EXP_ADD: break;
		case EXP_SUB : break;
		case EXP_DIV: break;
		case EXP_MUL: break;
		case EXP_OR : break;
		case EXP_AND: break;
		case EXP_LESS: break;
		case EXP_MORE : break;
		case EXP_ARRAY_ACCESS: break;
		case EXP_FUNC_CALL: break;
		case ARG_SEQ : break;
		case OUT_REST: break;
		case SYMBOL_LIT_SEQ : 
			asttofile(node->sons[0]);
			writechar(' ');
			asttofile(node->sons[1]);
		break;
		case PARAM : break;
		case PARAM_SEQ : break;
		case LOCAL_VAR_DEF : break;
		case LOCAL_VAR_DEF_LIST : break;
		case LOCAL_VAR_DEF_PTR: break;
		case CMD: break;
		case CMD_LIST : break;
		case CMDS : break;
		case PRE_INC : break;
		case POST_INC: break;
		case SIMPLE_ATRIB : break;
		case INDEX_ATRIB : break;
		case EXP_ADDR : break;
		case EXP_PTR: break;
		case SYMBOL_LIT_INTEGER:
			filewrite(node->symbol->word);
			break;
		case SYMBOL_LIT_FALSE:			
			filewrite("false");
			break;
		case SYMBOL_LIT_TRUE:
			filewrite("true");
			break;
		case SYMBOL_LIT_CHAR:
			filewrite(node->symbol->word);
			break;
		case SYMBOL_LIT_STRING:
			filewrite(node->symbol->word);
			break;
		case SYMBOL_IDENTIFIER: 
			filewrite(node->symbol->word);
			break;
		case KW_WORD: 
			filewrite("word");
			break;

	}

}
void filewrite(char* text)
{
	fprintf(file, "%s", text);
	
}

void writechar(char c)
{
	fprintf(file, "%c", c);
}


