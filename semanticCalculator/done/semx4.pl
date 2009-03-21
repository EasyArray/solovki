:- op(1000,xfy,&). % and
:- op(1000,xfy,v). % or

A & B :- A, B.
A v B :- A; B.

word(ann,e,ann).
word(beth,e,beth).
word(carl,e,carl).
word(dana,e,dana).

word(smokes,[e,t],lam(X,smokes(X))).
word(student,[e,t],lam(X,student(X))).

word(introduces,[e,[e,[e,t]]],lam(X,lam(Y,lam(Z,introduces(Z,Y,X))))).
word(likes,[e,[e,t]],lam(X,lam(Y,likes(Y,X)))).

% doesn't work
% word(every,[[e,t],[[e,t],t]],lam(X, setof(M1, lam(X,M1), _Bag))).

% this works 090127 6:30p
% word(all,[[e,t],[[e,t],t]],lam(lam(X,student(X)), setof(Y,lam(X, Y),_Bag))).

% atom
meaning(T,D,M) :-
	atom(T),
	word(T,D,M).
% funapp
meaning([T1,T2],D2r,M) :-
	meaning(T1,D1,M1),
	meaning(T2,[D1,D2r],lam(M1,M)).
meaning([T2,T1],D2r,M) :-
	meaning(T1,D1,M1),
	meaning(T2,[D1,D2r],lam(M1,M)).
% predicate modification
meaning([T1,T2],D1,lam(X, M1&M2)) :- 
	meaning(T1,D1,lam(X, M1)),
	meaning(T2,D1,lam(X, M2)).

%
%%	WORLD KNOWLEDGE
%
ann. beth. carl. dana.
smokes(ann).
student(ann).
student(beth).
introduces(ann,beth,carl).
introduces(dana,carl,beth).
likes(a,b).
likes(b,c).
likes(c,d).
