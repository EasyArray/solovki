eLex :-
	abolish(word/3).
	% ['/home/ae1/pro/090318.pro'].
	% ['/home/ae1/pro/090320.lex-from-file.pro'].
	%nl.
	

loadLex(Addr) :-	
	% r("<lex><w><f>Ann</f><t>e</t><s>Ann</s></w><w><f>smokes</f><t>[e,t]</t><s>X^smokes(X)</s></w></lex>").
	% X = '/home/ae1/pro/data/lex-123.txt',
	X = Addr,
	open(X, read, In),
	get_char(In, Char1),
	proc2(Char1, In, Str),
	w(Str),
	write('loadLex 123'),
	close(In),
	write('something else'), nl.

w(Str) :-
	string_to_list(Str,List),
	findTag(List,_,[60,108,101,120,62],Rest1), % <lex>
	findTag(Rest1,Lex,[60,47,108,101,120,62],_), % </lex>
	findWords(Lex),
	write('w'),nl.

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
%% what the hell is this?!?!
%% what the hell is this?!?!
%% do not remove, won't work without it.
findWords([10,10]) :- !.

findWords(Lex) :-
	findTag(Lex,_,[60,119,62],Rest1), % <w>
	findTag(Rest1,Word,[60,47,119,62],Rest2), % </w>
	processWord(Word),
	name(WordName,Word),
	write(WordName), nl,
	write('Rest2: '),write(Rest2),nl,
	findWords(Rest2).

processWord([]) :-
	fail.
processWord(Input) :-
%	write(Input),
	findTag(Input,_,[60,102,62],Rest1), % <f>
	findTag(Rest1,Form,[60,47,102,62],Rest2), % </f>

	findTag(Rest2,_,[60,116,62],Rest3),	  % <t>
	findTag(Rest3,Type,[60,47,116,62],Rest4), % </t>
	
	findTag(Rest4,_,[60,115,62],Rest5),	  % <s>
	findTag(Rest5,Semx,[60,47,115,62],_Rest6), % </s>

	atom_chars(FormAtom,Form),
	atom_chars(TypeAtom,Type),
	atom_chars(SemxAtom,Semx),
%	write('asserting: '),write(FormAtom),nl,
	assert(word(FormAtom,TypeAtom,SemxAtom)),
	write('asserting: '),write(FormAtom),write(TypeAtom),write(SemxAtom),nl,
	!.