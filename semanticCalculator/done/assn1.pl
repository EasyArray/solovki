:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

% individuals
word(ann, e, ann).
word(bob, e, bob).

% one-place predicates
word(smokes, [e,t], X^smokes(X)).
word(student, [e,t], X^student(X)).
word(female, [e,t], X^female(X)).

% two-place predicates
word(likes, [e,[e,t]], X^(Y^likes(Y, X))).

% quantifiers
word(every, [[e,t],[[e,t],t]], (X^A)^((X^B)^forall(A, B))).
word(some, [[e,t],[[e,t],t]], (X^A)^((X^B)^(A & B))).

% interpretation function
% 
% tries each interpretation rule until one works
interpret(Tree, Type, Meaning, G) :-
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
	nl, writeln(Tree),
	print('Type: '), print(Type), nl,
	print('Meaning: '), portray_clause(Meaning), nl.

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
pa([I,A] , [e,AType], X^AMeaning, G) :-
	number(I),
	put_assoc(I, G, X, GG),
	interpret(A, AType, AMeaning, GG).
	
% definitions of and and or operators
A & B :-
	A, B.

A v B :-
	A; B.

portray(A&B) :-
	print(A), print(' & '), print(B).