% interpretation function
% 
% tries each interpretation rule until one works
interpret(Tree, Type, Meaning, G) :-
%	write(Tree),nl,
	pa(Tree, Type, Meaning, G), !;
	tp(Tree, Type, Meaning, G), !;
	nn(Tree, Type, Meaning), !;
	fa(Tree, Type, Meaning, G), !;
	pm(Tree, Type, Meaning, G).

% version without type or assignment function
interpret(Tree, Meaning) :-
	interpret(Tree, _, Meaning, _).

% output version
interpret(Tree) :-
	interpret(Tree, Type, Meaning, _),
%	nl, writeln(Tree),
	print('Type: '), print(Type), nl,
	print('Meaning: '), portray_clause(Meaning), nl.

% Ezra, what is this predicate for? vp_
/*
portray(A&B) :-
	print(A), print(' & '), print(B).
*/