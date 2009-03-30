e :-
	['/home/ae1/pro/utils.pro'],
	['/home/ae1/pro/loadLex.pro'],
	['/home/ae1/pro/loadRules.pro'],
	['/home/ae1/pro/interpret-rule.pro'].

self :-
	['/home/ae1/pro/go.pro'].

go(Lex,Rules,Query) :-
	e,
	rRules(Lex,Rules,Query).

rRules(Lex,Rules,Query) :-
	loadLex(Lex),
	loadRules(Rules),
	interpret(Query).

:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

A & B :-
	A, B.

A v B :-
	A; B.

