shell: 	
	flex -l calc.l
	bison -dv calc.y
	gcc -o calc calc.tab.c lex.yy.c -lfl

clean:
	rm calc calc.tab.c lex.yy.c calc.tab.h calc.output
