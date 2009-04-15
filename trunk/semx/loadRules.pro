/**** testing
  
t :-
	loadRules('/home/ae1/pro/data/rules-1.pro').
e :-
	['/usr/home/ae1/pro/loadRules.pro'],
	['/usr/home/ae1/pro/utils.pro'].
*/

:- dynamic rule/4.
:- dynamic rule/5.

loadRules(File) :-
	seeing(Old),
	see(File),
	repeat,
	read(Data),
	process1(Data),
	seen,
	see(Old),
	!.

process1(end_of_file) :- !.
process1(end-of-file) :- !.
process1(Data) :-
	assert(Data),
	fail.

process(end_of_file) :- !.
process(Data) :-
	Data=..[_H1,H2,H3],
	H2=..[_Rule|RuleHeadRest],
	RuleHeadRest=[Name|Args],
	Headz=..[Name|Args],
	assert(:- dynamic Name),
	assert(Headz:-H3),
	fail.