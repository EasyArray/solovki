% reconsult shortcut. In order to reconsult the file, simply type e.
e :-
	['/home/ae1/pro/read-file.pro'].

% read in file Edinburgh
r1 :-
	X = '/home/ae1/pro/notes.txt',
	see(X),
	repeat,
	get_char(T),
	write(T),
	T=end_of_file,!,seen.

% atom_codes(Atom, String).

% read in file ISO
r2e1 :-
	X = '/home/ae1/pro/lexicon-temp.txt',
	open(X, read, In),
	get_char(In, Char1),
	proc2(Char1, In),
	close(In).

proc2(end_of_file, _) :- !.
proc2(Char, In) :-
	print(Char),
	get_char(In, Char2),
	proc2(Char2, In).