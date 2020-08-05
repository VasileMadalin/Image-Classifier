function [x] = SST(A, b)
	%copiem in n, m dimensiunile matricei X
	[n m] = size(A);
	%se aplica algoritmul SST
	minn = min(n, m);
	x = zeros(m, 1);
	for i = minn:-1:1
		s = 0;
		for j=(i+1):m
			s+=(A(i,j)*x(j));
		endfor
		x(i) = (b(i)-s)/A(i,i);
	endfor
endfunction
    
