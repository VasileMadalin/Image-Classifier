function [Q, R] = Householder(A)
	%se aplica algoritmul Householder
	[m n] = size(A);
	Q = eye(m);
	for i = 1 : min(m-1,n)
		sigma = -norm(A(i:m, i));
		if A(i, i) < 0
			sigma = -sigma;
		endif
		mat(1:m, 1) = 0;
		mat(i) = A(i, i) + sigma;
		mat(i + 1:m) = A(i + 1:m, i);
    		beta = sigma * mat(i);
		if beta ~= 0
     			A(i, i) = -sigma;
			A(i + 1:m, i) = 0;
			for j = i + 1 : n
				t = mat(i:m)' * A(i:m, j) / beta;
				A(i:m, j) = A(i:m, j) - t * mat(i:m);
		  	endfor
			for j = 1:m
		    		t = mat(i:m)' * Q(i:m, j) / beta;
		    		Q(i:m, j) = Q(i:m, j) - t * mat(i:m);
		  	endfor
     		endif
	endfor
  	R = A;
	Q = Q'; 
endfunction
