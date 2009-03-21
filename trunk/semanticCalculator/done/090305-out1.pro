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

?- r3.
[<, l, e, x, >, 
, <, w, >,      , f, o, r, m, :,        , A, n, n, 
,       , t, y, p, e, :,  ,     , N, 
,       , s, e, m, x, :,        , A, n, n, 
, <, /, w, >, 
, <, w, >,      , f, o, r, m, :,        , B, o, b, 
,       , t, y, p, e, :,        , N, 
,       , s, e, m, x, :,        , B, o, b, 
, <, /, w, >, 
, <, /, l, e, x, >, 
]
true.
