e :-
	abolish(word/3),
	['/home/ae1/pro/xml-parse-2.pro'],
	['/home/ae1/pro/utils.pro'].

% arithmetic
expr --> term, addterm.
addterm --> [].
addterm --> [+], expr.
term --> factor, multifactor.
multifactor --> [].
multifactor --> [*], term.
factor --> [I], {integer(I)}.
factor --> ['('], expr, [')'].

% english grammar
/*
s(S0,S) :- np(S0,S1), vp(S1,S).
np(S0,S) :- det(S0,S1), n(S1,S).
vp(S0,S) :- tv(S0,S1), np(S1,S).
vp(S0,S) :- v(S0,S).
det(S0,S) :- S0=[the|S].
det(S0,S) :- S0=[a|S].
det(S0,S) :- S0=[every|S].
n(S0,S) :- S0=[man|S].
n(S0,S) :- S0=[woman|S].
n(S0,S) :- S0=[park|S].
tv(S0,S) :- S0=[loves|S].
tv(S0,S) :- S0=[likes|S].
v(S0,S) :- S0=[walks|S].
% */

% alternative of above
s --> np, vp.
np --> det, n.
vp --> tv, np.
vp --> v.
det --> [the].
det --> [a].
det --> [every].
n --> [man].
n --> [woman].
n --> [park].
tv --> [loves].
tv --> [likes].
v --> [walks].

% lexicon
lex --> [].
lex --> word, lex.
word(X,Y,Z) --> form(X), type(Y), semx(Z).
form(X) --> tag_open('f'),meat(X),tag_close('f').
type(X) --> tag_open('t'),meat(X),tag_close('t').
semx(X) --> tag_open('s'),meat(X),tag_close('s').
tag_open(X) --> ['<',X,'>'].
tag_close(X) --> ['<','/',X,'>'].
meat(X) --> [X].

r :-
	LexAddr = '/home/ae1/pro/data/lex-1.xml',
	file2List(LexAddr,LexList),
	r2(LexList).

r(Lex) :-
	% string_to_list(Str,List),
	file2List('/home/ae1/pro/data/lex-1.xml',List),
	findTag(List,_,[60,108,101,120,62],Rest1), % <lex>
	findTag(Rest1,Lex,[60,47,108,101,120,62],_Rest2), % </lex>
	findWords(Lex),
	nl.

r2(List) :-
	findTag(List,_,[60,108,101,120,62],Rest1), % <lex>
	findTag(Rest1,Lex,[60,47,108,101,120,62],_Rest2), % </lex>
	% findWords(Lex).
	write(Lex), nl.

r3 :-
	Form = ['<','f','>','f','o','r','m','<','/','f','>'],
	% form(form(X),Form,[]),
	% form(A,Form,[]),
	write(Form),
	form(A,C,B),
	write(A),
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
	findTag(Rest5,Semx,[60,47,115,62],_Rest6), % </s>

	atom_chars(FormAtom,Form),
	atom_chars(TypeAtom,Type),
	atom_chars(SemxAtom,Semx),
	assert(word(FormAtom,TypeAtom,SemxAtom)),
	write(FormAtom),write(TypeAtom),write(SemxAtom),
	!.