e :-
	% self-ref
	['/home/ae1/pro/driver-2.pro'],
	['/home/ae1/pro/utils.pro'],
	['/home/ae1/pro/interpret-rule.pro'].

% execute shortcut
r :-
	r('/home/ae1/pro/data/lexicon-1.pro',
	  '/home/ae1/pro/data/WM-123.txt',
	  '/home/ae1/pro/data/data/rules-1.pro',
	  [ann,smokes]).
r(Query) :-
	r('/home/ae1/pro/lexicon-1.pro',
	  '/home/ae1/pro/worldModel-1.pro',
	  '/home/ae1/pro/rules-1.pro',
	  Query).

r(_,_,Rules,_) :-
	% load environment
	e,
	
	% load lexicon
	% Lex = '/home/ae1/pro/lexicon-1.pro',
	[Lex],
	
	% load WM
	% WM = '/home/ae1/pro/worldModel-1.pro',
	% [WM],
	
	% load semx rules
	% Rules = '/home/ae1/pro/rules-1.pro',
	[Rules],

	% execute query
	interpret(Query).