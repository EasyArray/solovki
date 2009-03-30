:- dynamic rule/4.

loadRules(File) :-
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
	Data=..[_H1,H2,H3],
	H2=..[_Rule|RuleHeadRest],
	RuleHeadRest=[Name|Args],
	Headz=..[Name|Args],
	assert(:- dynamic Name),
	assert(Headz:-H3),
	fail.