function [values, colind, rowptr] = matrix_to_csr(A)
	[n n] = size(A);
	val = 0;
	col = 0;
	row = 0;
	for i = 1 : n
		ok = 0;
		for j = 1 : n
			if ( A(i,j) != 0 )%verificam elementele diferite de 0
				val = val + 1;
				col = col + 1;
				if (ok == 0)
					x = val;%adaugam in x val pentru
						%primul element de pe coloana 
					ok = 1;
     				endif
				%creeam vectorul values
				values( val ) = A(i, j);
				%creeam vectorul colind
				colind( col ) = j;
			endif
		endfor
		row = row + 1;
		rowptr( row ) = x;%adaugam pe x in vector
	endfor
	row = row + 1;
	rowptr( row ) = col + 1;%ultimul element din "rowptr" este col + 1
endfunction
