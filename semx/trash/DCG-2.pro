e :-
	['/home/ae1/pro/DCG-2.pro'].

r :-
	Src = ['<','l','e','x','>','f','o','o','<','/','l','e','x','>'],
	phrase(lex(A),Src),
	write('Contents for lex: '), write(A), nl.


lex(A) --> [A].
% lex --> word, lex.
lex(A) -->
	open_tag(['l','e','x']), lex(A), close_tag(['l','e','x']).

% word --> form, type, semx.
word(Word) -->
	form(F),type(T),semx(S).

form(X) --> '<','f','>',X,'<','/','f','>'.

type(X) --> '<','t','>',X,'<','/','t','>'.

semx(X) --> '<','s','>',X,'<','/','s','>'.