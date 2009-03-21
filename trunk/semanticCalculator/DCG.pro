e :-
  ['/home/ae1/pro/DCG.pro'].


tag_pair([]) --> [].
tag_pair(A) --> open_tag(A), tag_pair, close_tag(A).

open_tag(A) --> left, name(A), right.

left --> ['<'].

right --> ['>'].

name(A) --> [A].

close_tag(A) --> left, slash, name(A), right.

slash --> [47].

word_tag --> tag_pair(word).

%% phrase(tag_pair, ['<', a, '>', '<', 47, 'a', '>']). %% driver