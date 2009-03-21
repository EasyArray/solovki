% SPLIT
% usage: split("list, of, words", ",", List).
split(String, "", Result) :- !,
	characters_to_strings(String,Result).
split(String,Delimiters,Result) :-
	real_split(String,Delimiters,Result).

characters_to_strings([],[]).
characters_to_strings([C|Cs],[[C]|Ss]) :-
	characters_to_strings(Cs,Ss).

real_split(String,Delimiters,Result) :-
	(append(Substring,[Delimiter|Rest],String), memberchk(Delimiter,Delimiters) -> Result = [Substring|Substrings],
	real_split(Rest, Delimiters, Substrings); Result = [String]).

check1 :-
	split("echo1, echo2, echo3", ", ", R),
	member(S,R), format('|~s~n|',[S]), fail.