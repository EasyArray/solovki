rule(nn, Tree, Type, Meaning) :-
	word(Tree, Type, Meaning).

rule(fa, [A, B], Type, Meaning, G) :-
	interpret(A, [BType, Type], BMeaning^Meaning, G),
	interpret(B, BType, BMeaning, G), !.

rule(fa, [B, A], Type, Meaning, G) :-
	interpret(A, [BType, Type], BMeaning^Meaning, G),
	interpret(B, BType, BMeaning, G).

rule(pm, [A, B], Type, X^(AMeaning & BMeaning), G) :-
	interpret(A, Type, X^AMeaning, G),
	interpret(B, Type, X^BMeaning, G).

rule(tp, pron(I), e, Ref, G) :-
	number(I),
	get_assoc(I, G, Ref).

rule(pa, [I,A], [e,AType], X^AMeaning, G) :-
	number(I),
	put_assoc(I, G, X, GG),
	interpret(A, AType, AMeaning, GG).

