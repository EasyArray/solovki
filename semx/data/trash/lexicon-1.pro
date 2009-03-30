:-
	dynamic word/3.

% individuals
word(ann, e, ann).
word(bob, e, bob).

% one-place predicates
word(smokes, [e,t], X^smokes(X)).
word(student, [e,t], X^student(X)).
word(female, [e,t], X^female(X)).

% two-place predicates
word(likes, [e,[e,t]], X^(Y^likes(Y, X))).

% quantifiers
/*
word(every, [[e,t],[[e,t],t]], (X^A)^((X^B)^forall(A, B))).
word(some, [[e,t],[[e,t],t]], (X^A)^((X^B)^(A & B))).
*/