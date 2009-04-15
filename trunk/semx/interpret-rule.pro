% interpretation function
% 
% tries each interpretation rule until one works
interpret(Tree, Type, Meaning, G) :-
%	pa(Tree, Type, Meaning, G), !;
%	tp(Tree, Type, Meaning, G), !;
%	nn(Tree, Type, Meaning), !;
%	fa(Tree, Type, Meaning, G), !;
%	pm(Tree, Type, Meaning, G).
%	write('interpreting '),write(Tree),write(' '),write(Meaning),nl,
	rule(_,Tree,Type,Meaning,G), !;
	rule(_,Tree,Type,Meaning), !.

% version without type or assignment function
interpret(Tree, Meaning) :-
	interpret(Tree, _, Meaning, _).

% output version
interpret(Tree) :-
	writeln(Tree),
	interpret(Tree, Type, Meaning, _),
	print('Type: '), print(Type), nl,
	print('Meaning: '), portray_clause(Meaning), nl.

% Ezra, what is this predicate for? vp_
/*
portray(A&B) :-
	print(A), print(' & '), print(B).
*/