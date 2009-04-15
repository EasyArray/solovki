%self :-
%	['/home/ae1/pro/loadLex.pro'].

loadLex(Addr) :-
	abolish(word/3),
	% X = '/home/ae1/pro/data/lex-123.txt',
	X = Addr,
	open(X, read, In),
	get_char(In, Char1),
	proc2(Char1, In, Str),
	w(Str),
	close(In).

w(Str) :-
	string_to_list(Str,List),
	findTag(List,_,[60,108,101,120,62],Rest1), % <lex>
	findTag(Rest1,Lex,[60,47,108,101,120,62],_), % </lex>
	findWords(Lex).

proc2(end_of_file,_,[]) :- !.
proc2(Char, In, [Str|Tail]) :-
	Char=Str,
	get_char(In, Char2),
	proc2(Char2, In, Tail).

findTag(Input,[],Container,Rest):-
	append(Container,Rest,Input), !.
findTag([Hin|Tin],[Hin|Token],Container,Rest) :-
	findTag(Tin,Token,Container,Rest).

findWords([]) :- !.
findWords([13|Rest]) :- !, findWords(Rest).
findWords([10|Rest]) :- !, findWords(Rest).
findWords(Lex) :-
	findTag(Lex,_,[60,119,62],Rest1), % <w>
	findTag(Rest1,Word,[60,47,119,62],Rest2), % </w>
	processWord(Word),
%	name(WordName,Word),
%	write(WordName), nl,
	findWords(Rest2).

processWord([]) :- fail.
processWord(Input) :-
%	write(Input),
	findTag(Input,_,[60,102,62],Rest1), % <f>
	findTag(Rest1,Form,[60,47,102,62],Rest2), % </f>

	findTag(Rest2,_,[60,116,62],Rest3),	  % <t>
	findTag(Rest3,Type,[60,47,116,62],Rest4), % </t>
	
	findTag(Rest4,_,[60,115,62],Rest5),	  % <s>
	findTag(Rest5,Semx,[60,47,115,62],_Rest6), % </s>

	atom_chars(FormAtom,Form),
	term_to_atom(FormTerm,FormAtom),
	atom_chars(TypeAtom,Type),
	term_to_atom(TypeTerm,TypeAtom),
	atom_chars(SemxAtom,Semx),
	term_to_atom(SemxTerm,SemxAtom),
	
	assert(word(FormTerm,TypeTerm,SemxTerm)),
	!.