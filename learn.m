function [w] = learn(X, y)
	[m n] = size(X);%copiem in m, n dimensiunile matricei X
	X(1:m, n + 1) = 1;%adaugam in x inca o coloana
			  %(fiecare element din noua coloana este 1)
	%folosim algoritmul Householder pentru a calcula pe Q si R
	[Q R] = Householder(X);
	%calculam pe b(imnultind la stanga cu Q transpus)
	b = (Q')*y;
	%apelam algoritmul SST
	w = SST(R, b);
end
