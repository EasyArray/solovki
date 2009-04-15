e :-
	% dir(Dir),
	Dir = '/home/ae1/pro/',
	string_concat(Dir,'utils.pro',Utils),
	[Utils],

	string_concat(Dir,'loadLex.pro',LoadLex),
	[LoadLex],

	string_concat(Dir,'loadRules.pro',LoadRules),
	[LoadRules],

	string_concat(Dir,'interpret-rule.pro',InterpretRule),
	[InterpretRule].

/**** testing
  
self :-
	['/home/ae1/pro/go.pro'].

t :-
	go('/home/ae1/pro/data/lex-1.xml',
	   '/home/ae1/pro/data/rules-1.pro',
	   [ann,smokes]).
*/

go(Lex,Rules,Query) :-
	e,
	rRules(Lex,Rules,Query).

rRules(Lex,Rules,Query) :-
	loadLex(Lex),
	loadRules(Rules),
	interpret(Query).


