:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

% non-branching node
% 
% look up in lexicon
nn(Tree, Type, Meaning) :-
%	atom(Tree),
	word(Tree, Type, Meaning).

% functional application
% 
% plug an argument into a function
fa([A, B], Type, Meaning, G) :-
	interpret(A, [BType, Type], BMeaning^Meaning, G),
	interpret(B, BType, BMeaning, G), !.

% [[fa([A,B],Type,Meaning,G),interpret(A,[BType,Type],BMeaning^Meaning,G),interpret(B,BType,BMeaning,G),!],[nn(Tree,Type,Meaning),atom(Tree),word(Tree,Type,Meaning)],[fa([B,A],Type,Meaning,G),interpret(A,[BType,Type],BMeaning^Meaning,G),interpret(B,BType,BMeaning,G)]]

% try the other order
fa([B, A], Type, Meaning, G) :-
	interpret(A, [BType, Type], BMeaning^Meaning, G),
	interpret(B, BType, BMeaning, G).


% predicate modification
% 
% return the conjunction of the meanings
pm([A, B], Type, X^(AMeaning & BMeaning), G) :-
	interpret(A, Type, X^AMeaning, G),
	interpret(B, Type, X^BMeaning, G).

% traces and pronouns
% 
%  set up a variable
tp(pron(I), e, Ref, G) :-
	number(I),
	get_assoc(I, G, Ref).

% predicate abstraction
% 
% associates a variable with the index provided
pa([I,A], [e,AType], X^AMeaning, G) :-
	number(I),
	put_assoc(I, G, X, GG),
	interpret(A, AType, AMeaning, GG).
	
% definitions of and and or operators
A & B :-
	A, B.

A v B :-
	A; B.