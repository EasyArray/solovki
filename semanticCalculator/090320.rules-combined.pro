e :-
	['/home/ae1/pro/utils-1.pro'],
	['/home/ae1/pro/090320.lex-from-file.pro'],
	eLex,
	['/home/ae1/pro/090320.rules-combined.pro'].
	
r :-
	rRules('/home/ae1/pro/data/lex-123.txt',
	       '/home/ae1/pro/data/rules-123.txt',
	       [ann,smokes]).

rRules(Lex,Rules,Query) :-
	% write('rRules'),nl,
	browse(Rules),		% is a filename,
	% write(Rules),nl,
	loadLex(Lex),
	% browse('/home/ae1/pro/data/rules-123.txt').
	write(Query),nl,
	interpret(Query).

%%
% rules
%%

:- dynamic rule/4.

browse(File) :-
	write('browse'),nl,
	seeing(Old),
	see(File),
	repeat,
	read(Data),
	process(Data),
	seen,
	see(Old),
	!.

process(end_of_file) :- !.
process(Data) :-
	% write(Data),
	Data=..[_H1,H2,H3],
	% Head=[Name,Node,Type,Semx],
	 
	%Azz =..[Name(Node,Type,Semx),Tail],
	%write(Azz),
	
	% write('H1: '), write(H1), nl,
	% write('H2: '), write(H2), nl,
	H2=..[_Rule|RuleHeadRest],
	% write('H3: '),write(H3), nl,
	RuleHeadRest=[Name|Args],
	% write('Name: '), write(Name), nl,
	% write('Args: '), write(Args), nl,
	% write('H3: '), write(H3), nl,
	Headz=..[Name|Args],
	% write('Headz: '), write(Headz), nl,
	% Azz=..[Headz,H1,H3],
	% Azz = [Headz:-H3],
	
	% assert(Name(Args)H3),
	%write(Name), nl,
	%write('h3: '), write(H3), nl,
	% nl,nl,nl,
	% write('Asserting: '), write(Headz:-H3), nl,
	assert(:- dynamic Name),
	assert(Headz:-H3),
	fail.

:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

A & B :-
	A, B.

A v B :-
	A; B.