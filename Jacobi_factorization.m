function [G_J, c_J] = Jacobi_factorization(A, b)
	[n n] = size(A);
	G_J = A;%G_J primeste initial valoarea matricei A
	c_J = b;%c_j primeste initial valoarea vectorului b
	for i = 1 : n
		for j = 1 : n
			if ( G_J(i,j) >0 ) 
				x = G_J(i, j);%cautam singura valoare > 0
			endif
		endfor
		G_J(i, i) = 0;%punem valoarea zero pe diagonala principala
		for j = 1 : n
			G_J(i, j) = -G_J(i, j) / x;%impartim fiecare valorea la x
		endfor
	c_J(i) = c_J(i) / x;%se imparte si fiecare valoare din vectorul c_J
	endfor
endfunction
