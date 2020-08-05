function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
	n = length(G_rowptr);%se copiaza in n lungimea vectorului G_rowptr
	n = n - 1;
	xnew = zeros(n, 1);
	x = zeros(n, 1);%prima solutie se considera 0 
			%pentru toate necunoscutele
	
	max_iteratii = 100000;%numarul maxim de iteratii
	for iteratiii = 1 : max_iteratii%se efectueaza algoritmul pana cand
					%eroare este mai mica decat tol
		ok = true;
		%se inmulteste vectorul x cu matricea A
		y = csr_multiplication(G_values, G_colind, G_rowptr, x);
		for i = 1 : n
		Sum = y(i);
		xnew(i) = 1 * (Sum +c(i));%se calculeaza o solutie
		if( abs(xnew(i) - x(i)) > tol ) %se verifica daca
						%este mai mare decat tol
		ok = false;%daca este mai mare atunci ok = false si algoritmul 
			   %se reia
		endif
	endfor
	if ( ok )%daca este mai mica decat tol atunci se incheie algoritmul
		break
	endif
	x = xnew;%copiem in x noul vecotor de solutii
	endfor
endfunction
