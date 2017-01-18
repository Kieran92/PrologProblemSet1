/*----------------------------------------------------------------------------------------------
*  Name:Kieran Boyle
*  Student Number: 1265888
*  Course: CMPUT 325
*  Lecture Section: B1
*  Lab Section: HO1
*  Assignment Number: 3
-----------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------
*Question 1
*xreverse(+L,-R) 
*
*takes in a list of atoms and reverses the order of the values which occur in the list.
*
*Examples:
*
*  xreverse([7,3,4],[4,3,7]). 
*    true. 
*
*  xreverse([7,3,4],[4,3,5]).
*    false.
*
*  xreverse([7,3,4], R).
*    R = [4,3,7].
------------------------------------------------------------------------------------------------*/


xreverse([],[]).
xreverse([A|B], Reversed):- xreverse(B, ReversedB), appender(ReversedB, [A], Reversed).


/*----------------------------------------------------------------------------------------------
* appender(?List1, ?List2, ?List1AndList2) 
*
*appender is a helper fucntion that concatanates List1AndList2
*together to make a single concatanated list.
*
*Examples: 
*
*  appender([a,b,c],[d,e,f],[a,b,c,d,e]).
*    true.
*
*  appender([a,b,c],[d,e,f],[a,b,c,d]).
*    false.
*
*  appender([a,b,c],[d,e,f],L).
*    L=[a,b,c,d]
-----------------------------------------------------------------------------------------------*/


appender([], X, X).
appender([A|L1], L2, [A|L3]):- appender(L1, L2, L3).



/*----------------------------------------------------------------------------------------------
*Question 2
*xunique(+L, -Lu) 
*
*This predicate takes in a list and determines if the elements are unique if given 
*Lu. If not given Lu the predicate outputs a list with al duplicate elemnets removed. It relies on \
*the helper function remover. 
*
*Examples:
*
*  xunique([a,c,a,d], L)
*    L = [a,c,d].
*
*  xunique([a,c,a,d], [a,c,d]) 
*    true.
*
*  xunique([a,c,a,d], [c,a,d]) 
*    false.
*
*  xunique([a,a,a,a,a,b,b,b,b,b,c,c,c,c,b,a], L).
*    L = [a,b,c]. 
*
*  xunique([], L).
*    L = [].
-----------------------------------------------------------------------------------------------*/


xunique([], []).
xunique([H|T1], [H|T2]):-remover(H, T1, T3), xunique(T3, T2).


/*----------------------------------------------------------------------------------------------
*remover(+Atom, +L1, -L2) 
*
*This predicate takes in a list and atom and removes duplicate occurrences
*of a single atom. If L2 is a list it checcks to make sure that no duplicate elements are contained
*within that list. Also The teaching assistant said the use of /== was permissible. 
*
*Examples:
*   remover(a, [a,a,a,a,a], [a]).
*     true.
*
*   remover(a, [a,a,a,a,a], [a,a]).
*     false.
*
*   remover(a, [a,a,a,a,a], [a,a]).
*     false.
*
* remover(a, [a,a,b,c], L).
*   L = (a,b,c).
*
-----------------------------------------------------------------------------------------------*/


remover(_, [], []).
remover(X, [H|T1], T2):- X = H, remover(X, T1, T2).
remover(X, [H|T1], [H|T2]):- X \== H, remover(X, T1, T2). 


/*----------------------------------------------------------------------------------------------
*Question 3
*xunion(+L1, +L2, -L)
*
*This predicate takes in two lists and combines them together findign the union of the two 
*sets. THere is no redundancy in the final set. THis function uses append and xunique which have
*have been defined in other places in this assignment. 
*Examples:
*
*  xunion([a,c,a,d], [b,a,c], L).
*    L = [a,c,d,b]. 
*  xunion([a,c,d], [b,a,c], [a,c,d,b]).
*    true. 
*  xunion([a,c,d], [b,a,c], [a,c,d,b,a]). 
*    false.
-----------------------------------------------------------------------------------------------*/
 

xunion([], [], []).
xunion([], L2, Lfinal):-xunique(L2,Lfinal).
xunion(L1, [], Lfinal):-xunique(L1,Lfinal).
xunion(L1, L2, Lfinal):-append(L1, L2, Lappended), xunique(Lappended,Lfinal).


/*----------------------------------------------------------------------------------------------
*Question 4
*removeLast(+L, -L1, -Last) 
*
*This predicate  takes in a list and outputs the list with the last element removed and returns
*the last element in the variable last. L1 and Last can be either variables, or given values.
*
*Examples:
*
*  removeLast([a,c,a,d], L1, Last).
*   L1 = [a,c,a], 
*    Last = d.
*
* removeLast([a,c,a,d], L1, d).
*    L1 = [a,c,a].
*
*  removeLast([a,c,a,d], L1, [d]). 
*    false.
*
*  removeLast([a], L1, Last).
*    L1 = [], 
*    Last = a.
*
*  removeLast([[a,b,c]], L1, Last).
*    L1 = [], 
*    Last = [a,b,c].
*
-----------------------------------------------------------------------------------------------*/


removeLast(L, Lreduced, FinalElm):- lastElm(L, FinalElm), listCut(L, Lreduced).


/*----------------------------------------------------------------------------------------------

*lastElm(+L,-Last) 
*
*lastElm takes in a list and and returns the last element of the list. If Last is instantiated
*then it returns true or false.
*
*Examples:
*
*  lastElm([a,b,c], Last).
*    Last = c.
*
*  lastElm([a,b,c], c).
*    true.
*
*  lastElm([a,b,c], c).
*    false.
-----------------------------------------------------------------------------------------------*/

lastElm([Last], Last).
lastElm([_|VeryLast], Last):- lastElm(VeryLast, Last).

/*----------------------------------------------------------------------------------------------

*listCut(+L ,-L1) 
*
*This predicate returns a list without its final element.
*
*Examples:
*
*  listCut([a,b,c], L).
*    Last = [a,b].
*
*  listCut([a,b,c], [a,b]).
*    true.
*
*  listCut([a,b,c], [b,c]).
*    false.
-----------------------------------------------------------------------------------------------*/

listCut([_], []).
listCut([H|T], [H|T1]):- listCut(T, T1).


/*----------------------------------------------------------------------------------------------
*Question 5.1
*allConnected(+L).
*
*This function works in conjunction with clique to determine if members of a clique are all connected
*or not. It allows clique to find all of those nodes which find a clique.
*to each other.  
*
*connected(+A,+L)
*
*connected is a helper function that I call within allConnected wheher or not there is an edge connection
*between 2 nodes.
*
*Example:
*
*node(a).
*node(b).
*node(c).
*node(d).
*node(e).
*
*edge(a,b).
*edge(b,c).
*edge(c,a).
*edge(d,a).
*edge(a,e).
*
*clique(X).
* X = []
* X = [a]
* X = [a,b]
* X = [a,b,c]
* X = [a,c]
* X = [a,d]
* X = [a,e]
* X = [b]
* X = [b,c]
* X = [c]
* X = [d]
* X = [e].
*
-----------------------------------------------------------------------------------------------*/



clique(L) :- findall(X,node(X),Nodes),
             xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :- append(_, [X|Set1], Set), xsubset(Xs, Set1).

append([], L, L).
append([H|T], L, [H|R]) :-append(T, L, R).


allConnected([]).
allConnected([A|L]):-connected(A,L),allConnected(L).



/*----------------------------------------------------------------------------------------------
*connected(+A,+L) is described above
-----------------------------------------------------------------------------------------------*/

connected(_,[]).
connected(A,[B|L]):- edge(A,B); edge(B,A), connected(A,L).


/*----------------------------------------------------------------------------------------------
*Question 5.2
*maxclique(+Num, -L)
*
*maxclique finds the maximal clique takes in a number that determines the maxcliques of size N
*if a list is given the predicate checks if the list of given cliques is maximal. I use pAll
*and kAll to help me solve this problem. pall gets all possile cliques of size n and kAll gets
*all possible cliques that are subsets of larger maxcliques. Once i have the subsets and the \
*cliques I subtract and return the difference. 
*
*Example:
*  maxclique(2,Cliques).
*    Cliques = [[a,d],[a,e]]. 
*
*  maxclique(3,Cliques).
*    Cliques = [[a,b,c]].
*  
*  maxclique(1,Cliques). 
*    returns Cliques = []. 
* 
*  maxclique(0,Cliques).
*    Cliques = [].
-----------------------------------------------------------------------------------------------*/

maxclique(Num, L):-pAll(Num, All), findall(X, kAll(Num, X), Subsets), subtract(All,Subsets,L).



/*----------------------------------------------------------------------------------------------
*p(+N, -L)
*
*q takes in a number and returns a list of cliques of size N
*
*Example:
*   p(2, X);
*     X = [a, b] ;
*     X = [a, c] ;
*     X = [a, d] ;
*     X = [a, e] ;
*     X = [b, c] ;
*
*
-----------------------------------------------------------------------------------------------*/

p(N,L) :- clique(L),length(L,N).
pAll(N,L) :- findall(X,p(N,X),L).


/*----------------------------------------------------------------------------------------------
*k(+N, -L)
*
*k takes in a number and returns the subsets of all the maxcliques that are longer than size N
*
*Example:
*   k(2, X);
*     X = [a, b] ;
*     X = [a, c] ;
*     X = [b, c] ;
*
*
-----------------------------------------------------------------------------------------------*/

k(N,L):- clique(L1), length(L1,K), K > N, subset(L, L1).
kAll(N, L):- p(N,L), k(N,L).







%Resources:
%http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse25
%http://stackoverflow.com/questions/20256667/prolog-removing-duplicates
%http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse24
%http://stackoverflow.com/questions/9615002/intersection-and-union-of-2-lists
%http://stackoverflow.com/questions/16174681/how-to-delete-the-last-element-from-a-list-in-prolog
%http://stackoverflow.com/questions/21694499/prolog-checking-if-something-is-the-last-item-in-the-list
%http://stackoverflow.com/questions/14451794/how-to-check-whether-two-vertices-are-connected-or-not-in-prolog	
%http://www.swi-prolog.org/pldoc/man?section=builtinlist
%http://swish.swi-prolog.org/
%http://www.swi-prolog.org/pldoc/man?predicate=subset/2

