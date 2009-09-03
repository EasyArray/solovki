e :-
  ['utils.pro'],
  ['loadLex.pro'],
  ['loadRules.pro'],
  ['interpret-rule.pro'].

self :-
	['/home/ae1/pro/go.pro'].

go(Lex,Rules,Query) :-
	e,
	rRules(Lex,Rules,Query).

run_tree(Lex, Rules, Query) :-
	e,
	loadLex(Lex),
	loadRules(Rules), writeln('~~~~~~~~~~'),
	parse_tree(Query).

parse_tree(Query) :-
	interpret(Query), false.

parse_tree([Head|[Tail]]) :-
	parse_tree(Head);
	parse_tree(Tail).

rRules(Lex,Rules,Query) :-
	loadLex(Lex), write('Loaded Lexicon'),
	loadRules(Rules),
	interpret(Query).
