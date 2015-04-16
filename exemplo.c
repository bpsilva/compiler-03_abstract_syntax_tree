// UFRGS - Compiladores - Marcelo Johann - 2015/1

word a:0;
word v[10]:0 0 0 0 0 0 0 0 0 0; 
word mat[1000];
word $pt:0;

word main()
word i:0;
word j:1;
  {
  output "Digite um numero: ";
  loop (i=0; i<10; ++i)
    {
    a = incn(a,1);
    };
  output "Incrementado algumas vezes fica ",a,"\n";
  }

word incn (word x, word n)
  {
  return x+n;
  }
  
word outra (word x, word n) 
  {
  if (x < n) then return x+n else return x;
  }

word maisuma ()
  {
  if (x < n) then return x+n else { return x; };
  }

