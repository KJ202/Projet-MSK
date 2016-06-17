%% Paramètres initiaux
nbSymbols= 20  ; % NB de symboles à transmettre

symbols = randi([0 1],nbSymbols,1); %g�n�rations des symboles al�atoires

fe = 2457600000;      % Fréquence des �chantillons. Calcul� pour avoir 2048 �chantillons par symboles

%% Modulation
% Génération d'un sinus et ajout d'un bruit blanc Gaussien

%Param�tres de la modulation
fc = 433000000;% fréquence centrale 
fd = 600000; %fr�quence de d�viation
dfc = fd/100; %frequency offset

%Param�tres de calculs
fm = 2*fd;       % nombre de bit par secondes par channel
N = (nbSymbols)*(fix(fe/fm/2));       % Nombre d'�chantillons dans chaque voie

% Axe des temps
t = (1:N)/fe;

% G�n�ration des cosinus et sinus surr�lev�s
rootRaised = mskmod(symbols,fix(fe/fm/2),[],pi/2);

% Génération du sinus pour les coeffs
sinPorteuse1 = sin(2*pi* fc .*t);
cosPorteuse1 = cos(2*pi* fc .*t);

partI = sinPorteuse1 .* imag(rootRaised)' ;   % multiplication element par element
partQ = cosPorteuse1 .* real(rootRaised)' ;

s = partI + partQ ;
signal=awgn(s,1); %Ajout d'un bruit gaussien


%% Démodulation
k = ((1:N)*(0.5/N)) + (ones(1,N)*0.5)

sinPorteuse2 = sin(2*pi* (fc+k*dfc) .*t); %d�calage en fr�quence introduit dans la d�modulation
cosPorteuse2 = cos(2*pi* (fc+k*dfc) .*t); %d�calage en fr�quence introduit dans la d�modulation

demodI = signal .* sinPorteuse2 ;
demodQ = signal .* cosPorteuse2 ;

b = ones(1,150)*(1/100);
%b = [1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10];
resI = filter(b,1,demodI);
resQ = filter(b,1,demodQ);

resSum = resQ + j*resI ;

%% Premiere �tape de la d�modulation

resQAbs=abs(vec2mat(resQ,2048));
resIAbs=abs(vec2mat(resI,2048));
resAbs=resQAbs+j*resIAbs;
res=filter(b,1,resAbs);
maxI=max(resIAbs);
maxQ=max(resQAbs);

%% Plot

subplot(421);
plot(symbols,'bs');
title('Generated symbols')

subplot(422);
plot(t, signal);
title('Signal modul�')

subplot(423);
plot(t, real(rootRaised));
title('Partie r�elle (Q)')

subplot(424);
plot(t, imag(rootRaised));
title('Partie imaginaire (I)')

subplot(425);
plot(t, cosPorteuse1);
title('cosPorteuse')

subplot(426);
plot(t, sinPorteuse1);
title('sinPorteuse')

subplot(427);
plot(t, partQ);
title('partie Q modul�e par un cosinus')

subplot(428);
plot(t, partI);
title('partie I modul�e par un cosinus')

figure
subplot(222);
plot(t, demodI);
title('Signal recu * sinPorteuse');

subplot(221);
plot(t, demodQ);
title('Signal recu * cosPorteuse');

subplot(224);
plot(resI);
title('Channel I en reception apr�s filtrage');

subplot(223);
plot(resQ);
title('Channel Q en reception apr�s filtrage');

% Pour tracer la FFT

% Y = fft(partQ);
% P2 = abs(Y/N);
% P1 = P2(1:N/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = fe*(0:(N/2))/N;
% figure
% subplot(211);
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of partQ(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% 
% 
% Y = fft(signal);
% P2 = abs(Y/N);
% P1 = P2(1:N/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = fe*(0:(N/2))/N;
% subplot(212);
% plot(f,P1)
% title('Single-Sided Amplitude Spectrum of signal(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')


