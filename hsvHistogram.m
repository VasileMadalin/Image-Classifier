function [sol] = hsvHistogram(path_to_image, count_bins)
	img = imread (path_to_image);%se citeste imaginea
	[r c d] = size(img);%se copiaza in r,c si d dimensiunile imaginii
	%se initializeaza cu 0 matricele pentru convsersia hsv
	H = zeros(r,c);
	S = zeros(r,c);
	V = zeros(r,c);
	%se aplica algoritmul de conversie
	R = cast(img(:,:,1),"double")/255;
	G = cast(img(:,:,2),"double")/255;
	B = cast(img(:,:,3),"double")/255;
	CMAX = max(max(R, G), B);
	CMIN = min(min(R, G), B);
	delta = CMAX - CMIN;
	t=delta==0;
	H(t)=0;
	t1= CMAX==R & delta!=0;
	H(t1) = 60*mod((G(t1)-B(t1))./delta(t1),6);
	t2 = CMAX==G & delta!=0;
	H(t2) = 60*(((B(t2)-R(t2))./delta(t2)) +2);
	t3 = CMAX==B & delta!=0;
	H(t3) = 60*(((R(t3)-G(t3))./delta(t3)) +4);
	H = H/360;
       	t4 = CMAX==0;
	S(t4) = 0;
	t5 = delta!=0;
	S(t5) = delta(t5)./CMAX(t5);
	V = CMAX;
	%se inmulteste fiecare componenta cu 10000 si se ia 
	%partea intreaga pentru a se putea apela functia accumarray
	H(:,:) = floor(H(:,:)*10000)+1;
	S(:,:) = floor(S(:,:)*10000)+1;
	V(:,:) = floor(V(:,:)*10000)+1;
	%se face zero vectorul "sol"
	sol = zeros(1,3*count_bins);       
	for p = 1:(count_bins)
		%se creeaza capetele intervalului in care se face cautarea
		d = 1.01 / count_bins;
		a = (((p-1)*d)*10000) + 1;
		b = ((p*d)*10000) + 1;
		nr1 = accumarray(H(H>=a & H<b),1);
		nr1 = sum(nr1);
		nr2 = accumarray(S(S>=a & S<b),1);
		nr2 = sum(nr2);
		nr3 = accumarray(V(V>=a & V<b),1);
		nr3 = sum(nr3);
		%adugam numerele gasite in vectorul "sol"
		sol(p) = nr1;
		sol(p+count_bins) = nr2;
		sol(p+2*count_bins) = nr3;
	endfor
endfunction
