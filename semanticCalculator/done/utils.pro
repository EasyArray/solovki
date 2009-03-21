getToken(digits,[C|R],Rest,S,T) :-
	digit(C),
	getToken(digits,R,Rest,[C|S],T).
getToken(digits,[C|R],Rest,S,T) :-
	letter(C),
	getToken(error,R,Rest,[C|S],T).
getToken(digits,R,R,S,number(N)) :-
	reverse(S,S1),
	atom_chars(N,S1). % prints ascii codes as chars

% UTILS %%%%%%%%%%%%%%%%
% atom_codes(Atom, String).
whiteSpace(32). % space  32
newline(10). % line feed 10
digit(D) :- 46 < D, D < 59.
letter(L) :- 64 < L, L < 91.
letter(L) :- 96 < L, L < 123.
% name(N,[97,98]). % N = ab