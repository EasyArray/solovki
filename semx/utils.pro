/* % reload
e :-
	Self = '/home/ae1/pro/utils.pro',
	write('Loading self: '), write(Self), nl,
	['/home/ae1/pro/utils.pro'].

test('file2List') :-
	write('testing file2List(Addr,Out). '), nl,
	Addr = '/home/ae1/pro/data/lex-1.xml',
	file2List(Addr,List),
	write(List), nl.
% */

%%%%%%%%%%%%%%%%%%%%%%

% define and, or

:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

A & B :-
	A, B.

A v B :-
	A; B.

%%%%%%%%%%%%%

% trash
% dir('/home/ae1/pro/').

file2List(Addr,Out) :-
	open(Addr,read,In),
	get_char(In, Char1),
	file2ListAux(Char1, In, Out),
	close(In).

file2ListAux(end_of_file,_,[]) :- !.
file2ListAux(Char, In, [Str|Tail]) :-
	Char = Str,
	get_char(In, Char2),
	file2ListAux(Char2, In, Tail).

xml2Lex(Src) :-
	phrase(tag_pair(lex), Src).

tag_pair([]) --> [l, e, x].
tag_pair(A) --> open_tag(A), tag_pair, close_tag(A).

open_tag(A) --> '<', name(A), '>'.

name(A) --> [A].

close_tag(A) --> '<', '/', name(A), '>'.

lex_tag --> tag_pair(lex).
