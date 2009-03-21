% reconsult shortcut - MODIFY ACCORDINGLY!
e :- ['/home/ae1/pro/xml-parse.pro'].

% execute shortcut - MODIFY ACCORDINGLY!
r :- Src = '/home/ae1/pro/lex3.txt', exec(Src).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exec(Src) :-
	X = Src,
	open(X, read, In),
	get_char(In, Ch),
	ch2Str(Ch,In,Str),
	proc(Str),
	close(In).
	% Ch=end_of_file, !, close(In).

ch2Str(end_of_file,_,[]) :- !.
ch2Str(Ch, In, [Ch|Str]) :-
	get_char(In,Ch2),
	ch2Str(Ch2, In, Str).

proc(CharList) :-
	% Str=[60,119,62|R], % <w>
	name(Name,CharList), %works
	atom_codes(Name,NumList), % works
	% write(Name),
	tok(NumList).
	% write(CharList).

tok([]) :- !.
tok(In) :-
	findWord(In,Word,Out), !,
	processWord(Word),
	%name(R,Word),
	%write(R), nl,
	tok(Out).

findWordAux([60,47,119,62|Rest],[],Rest). % </w>
findWordAux([Hin|Tin],[Hin|Token],Rest) :-
	findWordAux(Tin,Token,Rest).

findWord([60,119,62|R],Word,Rest) :- % <w>
	findWordAux(R,Word,Rest).
findWord([_|Tin],Word,Rest) :-
	findWord(Tin,Word,Rest).

processWord(Word) :-
	tokenize(Word).
	
tokenize(NumList) :-
	NumList = [60,102,62|Mid1], % <f>
	form(Mid1,Form,R1),
	R1 = [60,116,62|R2], % <t>
	type(R2,Type,R3),
	R3 = [60,115,62|R4], % <s>
	semx(R4,Semx,_),

	name(Formm,Form),
	name(Semxx,Semx),
	write('wordform: '), write(Formm), nl,
	write('type: '), writeType(Type), nl,
	write('meaning: '), write(Semxx), nl,
	nl, nl.

writeType([78]) :- % N
	write('<e>').
writeType([79,78]) :- % N
	write('<e,t>').

form([60,47,102,62|Out],[],Out). % </f>
form([Hin|Tin],[Hin|Token],Out) :-
	form(Tin,Token,Out).

type([60,47,116,62|Out],[],Out). % </t>
type([Hin|Tin],[Hin|Token],Out) :-
	type(Tin,Token,Out).

semx([60,47,115,62|Out],[],Out). % </s>
semx([Hin|Tin],[Hin|Token],Out) :-
	semx(Tin,Token,Out).