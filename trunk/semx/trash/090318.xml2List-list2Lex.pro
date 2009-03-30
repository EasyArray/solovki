e :-
	abolish(word/3),
	['/home/ae1/pro/090318.pro'].
	
r :-
	r("<lex><w><f>Ann</f><t>e</t><s>Ann</s></w><w><f>smokes</f><t>[e,t]</t>
	    <s>X^smokes(X)</s></w></lex>").

r(Str) :-
	string_to_list(Str,List),
	findTag(List,_,[60,108,101,120,62],Rest1), % <lex>
	findTag(Rest1,Lex,[60,47,108,101,120,62],Rest2), % </lex>
	findWords(Lex),
	nl.

findTag(Input,[],Container,Rest):-
	append(Container,Rest,Input).
findTag([Hin|Tin],[Hin|Token],Container,Rest) :-
	findTag(Tin,Token,Container,Rest).

findWords([]) :- !.
findWords(Lex) :-
	findTag(Lex,_,[60,119,62],Rest1), % <w>
	findTag(Rest1,Word,[60,47,119,62],Rest2), % </w>
	processWord(Word),
%	name(WordName,Word),
%	write(WordName), nl,
	findWords(Rest2),
	nl.

processWord([]) :- !.
processWord(Input) :-
%	write(Input).
	findTag(Input,_,[60,102,62],Rest1), % <f>
	findTag(Rest1,Form,[60,47,102,62],Rest2), % </f>

	findTag(Rest2,_,[60,116,62],Rest3),	  % <t>
	findTag(Rest3,Type,[60,47,116,62],Rest4), % </t>
	
	findTag(Rest4,_,[60,115,62],Rest5),	  % <s>
	findTag(Rest5,Semx,[60,47,115,62],Rest6), % </s>

	atom_chars(FormAtom,Form),
	atom_chars(TypeAtom,Type),
	atom_chars(SemxAtom,Semx),
	assert(word(FormAtom,TypeAtom,SemxAtom)),
	write(FormAtom),write(TypeAtom),write(SemxAtom),
	!.