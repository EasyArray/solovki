e :-
	% self
	['/home/ae1/pro/DCG-1.pro'],
	['/home/ae1/pro/utils.pro'].

r :-
	% lexicon
	% write('Loading lexicon: '),
	Lex = '/home/ae1/pro/data/lex-1.xml',
	rLex(Lex).

rLex(Src) :-
	file2List(Src,List),
	xml2Lex(List).

semx(A) --> '<','s','>',{A},'<','/','s','>'.

tag_pair([]) --> [].
tag_pair(A) --> open_tag(A), tag_pair, close_tag(A).

open_tag(A) --> left, name(A), right.

left --> ['<'].

right --> ['>'].

name(A) --> [A].

close_tag(A) --> left, slash, name(A), right.

slash --> [47].

word_tag --> tag_pair(word).