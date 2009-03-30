% reconsult shortcut
e :-
	['/home/ae1/pro/1.pro'].

% read in file Edinburgh
r1 :-
	X = '/home/ae1/pro/lexicon.txt',
	see(X),
	repeat,
	get_char(T),
	proc1(T),
	T=end_of_file,!,seen.

proc1(Ch) :-
	write(Ch).

% UTILS %%%%%%%%%%%%%%%%
% atom_codes(Atom, String).
whiteSpace(32). % space  32
newline(10). % line feed 10
digit(D) :- 46 < D, D < 59.
letter(L) :- 64 < L, L < 91.
letter(L) :- 96 < L, L < 123.
% name(N,[97,98]). % N = ab

% read in file ISO
r4 :-
	X = '/home/ae1/pro/lex-2.txt',
	open(X, read, In),
	get_char(In, Char1),
	proc2(Char1, In),
	close(In).

proc2(end_of_file, _) :- !.
proc2(Char, In) :-
	write(Char),
	get_char(In, Char2),
	proc2(Char2, In).

% read in file ISO - words
r2 :-
	X = '/home/ae1/pro/lexicon-temp.txt',
	open(X, read, In),
	get_char(In, Ch),
	proc3(Ch, In, [], Out2),
	write(Out2),
	close(In).

proc3(end_of_file, _, Out, Out) :- !.
proc3(Ch, In, Out, [Ch|Out2]) :-
	get_char(In,Ch2),
	proc3(Ch2, In, Out, Out2).

% tokenize
t :-
	X = '/home/ae1/pro/lexicon.txt',
	see(X),
	repeat,
	get_char(T),token1(T),T=end_of_file,!,seen.

getToken(digits,[C|R],Rest,S,T) :-
	digit(C),
	getToken(digits,R,Rest,[C|S],T).
getToken(digits,[C|R],Rest,S,T) :-
	letter(C),
	getToken(error,R,Rest,[C|S],T).
getToken(digits,R,R,S,number(N)) :-
	reverse(S,S1),
	atom_chars(N,S1). % prints ascii codes as chars

% read and compose
r3 :-
	X = '/home/ae1/pro/lexicon-temp.txt',
	open(X, read, In),
	get_char(In, Ch),
	compose3(In, Ch, R), % R is whole file as string
	%write(R),
	process(R),
	close(In).

compose3(_, end_of_file, []) :- !.
compose3(In, Ch, [Ch|R]) :-
	get_char(In, Ch2),
	compose3(In, Ch2, R).

process(X) :-
	name(Code,X),
	atom_codes(Code,F),
	proc4(F).
	%write('\n\n'), write(Code).

proc4([]) :- !.
proc4(F) :-
	F = [60,108,101,120,62|R], % <lex>
	% atom_codes(C,R),
	write(Token),
	proc5(R,Token,Rest),
	proc4(Rest).
proc5(InList,Token,Rest) :-
	InList = [60,119,62|R], % <w>
	wordToken(R,Token,Rest).
wordToken([60,47,119,62|RestList],[],RestList).
wordToken([Hin|Tin],Result,Tin) :-
	wordToken(Tin,[Hin|Result],Tin).