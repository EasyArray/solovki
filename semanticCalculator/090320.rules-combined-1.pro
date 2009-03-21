e :-
	['/home/ae1/pro/090320.rules-combined.pro'].

r :-
	browse('/home/ae1/pro/data/rules-123.txt').

:- dynamic rule/4.

browse(File) :-
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
	Data=..[H1,H2,H3],
	% Head=[Name,Node,Type,Semx],
	 
	%Azz =..[Name(Node,Type,Semx),Tail],
	%write(Azz),
	
	write('H1: '), write(H1), nl,
	% write('H2: '), write(H2), nl,
	H2=..[_Rule|RuleHeadRest],
	write('H3: '),write(H3), nl,
	RuleHeadRest=[Name|Args],
	write('Name: '), write(Name), nl,
	write('Args: '), write(Args), nl,
	write('H3: '), write(H3), nl,
	Headz=..[Name|Args],
	write('Headz: '), write(Headz), nl,
	% Azz=..[Headz,H1,H3],
	%Azz = [Headz:-H3],
	%nl, write('Asserting: '), nl,
	%write('Azz: '), write(Azz), nl,
	assert(Headz:-H3),

	
	% assert(Name(Args)H3),
	%write(Name), nl,
	%write('h3: '), write(H3), nl,
	nl,nl,nl,
	fail.

/* 
r2 :-
	load_rules('/home/ae1/pro/data/rules-123.txt').

load_rules(File) :-
	retractall(rule),
	open(File, read, Stream),
	call_cleanup(load_rules(Stream),
		     close(Stream)).
load_rules(Stream) :-
	read(Stream, TO),
	load_rules(TO, Stream).
load_rules(end_of_file, _) :- !.
load_rules(Assertion, Stream) :-
	!,
	Assertion =.. [Head|Tail],
	Head=[Name,Node,Type,Meaning],
	Azz=..[Name(Node,Type,Meaning)|Tail],
	assert(Azz),
	read(Stream, T2),
	load_rules(T2,Stream).
load_rules(Term, Stream) :-
	type_error(rule, Term).
*/

% these are different from rules, they are operator definitions. For now I'll just define them here.

:- op(1000, xfy, &).  % logical and
:- op(1000, xfy, v).  % logical or

A & B :-
	A, B.

A v B :-
	A; B.