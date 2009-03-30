go(Args) :-
	Args = [One, Two, Three, Four],
	% 1 is lexicon.
	% 2 is WM (currently blank)
	% 3 is Rules
	% 4 is the query
	[One], [Two], [Three],
	interpret(Four).
	
% reconsult shortcut
e :-
	% self-ref
	['/home/ae1/pro/driver-1.pro'],
	['/home/ae1/pro/utils-1.pro'].

% execute shortcut
r :-
	r('/home/ae1/pro/data/lexicon-1.pro',
	  '/home/ae1/pro/data/WM-123.txt',
	  '/home/ae1/pro/data/rules-1.pro',
	  [ann,smokes]).
r(Query) :-
	r('/home/ae1/pro/lexicon-1.pro',
	  '/home/ae1/pro/worldModel-1.pro',
	  '/home/ae1/pro/rules-1.pro',
	  Query).

r(Lex,WM,Rules,Query) :-
	% load environment
	e,
	
	% load lexicon
	% Lex = '/home/ae1/pro/lexicon-1.pro',
	[Lex],
	
	% load WM
	% WM = '/home/ae1/pro/worldModel-1.pro',
	[WM],
	
	% load semx rules
	% Rules = '/home/ae1/pro/rules-1.pro',
	[Rules],

	% execute query
	interpret(Query).