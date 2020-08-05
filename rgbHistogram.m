function [sol] = rgbHistogram(path_to_image, count_bins)
	img = imread (path_to_image);%se citeste imaginea
	[r c d] = size(img);%se copiaza in r,c si d dimensiunile imaginii
	R = img(:,:,1) + 1;%R este matricea pentru culoarea rosu
	G = img(:,:,2) + 1;%R este matricea pentru culoarea verde
	B = img(:,:,3) + 1;%R este matricea pentru culoarea albastru
	sol = zeros(1, 3 * count_bins);%se face zero vectorul "sol"
	for p = 0 : (count_bins - 1)
		%se creeaza capetele intervalului in care se face cautarea
		a = ((p * 256) / count_bins) + 1;
		b = a + (256 / count_bins);
		%se cauta in R
		nr1 = accumarray(R(R>=a & R<b),1);
		nr1 = sum(nr1);
		%se cauta in G
		nr2 = accumarray(G(G>=a & G<b),1);
		nr2 = sum(nr2);
		%se cauta in B
		nr3 = accumarray(B(B>=a & B<b),1);
		nr3 = sum(nr3);
		%adugam numerele gasite in vectorul "sol"
		sol(p + 1) = nr1;
     		sol(p + 1 + count_bins) = nr2;
		sol(p + 1 + 2 * count_bins) = nr3;
	endfor
endfunction
