% reconsult shortcut
e :-
	% self
	['/home/ae1/pro/driver-1.pro'],
	
	% lexicon
	['/home/ae1/pro/data/lexicon-1.pro'],
	
	% named entities
	['/home/ae1/pro/data/namedEntities-1.pro'],
	
	% world model
	['/home/ae1/pro/data/worldModel-1.pro'],
	
	% semx-grammar
	['/home/ae1/pro/rules-1.pro'],

	% utilities and environment
	['/home/ae1/pro/utils-1.pro'].

% execute shortcut
r :-
	Lex = '/home/ae1/pro/data/lex3.txt',
	readLex(Lex).

%%%%% main %%%%%
readLex(_) :-
	assert(word(ann, e, ann)),
	assert(word(bob, e, bob)).