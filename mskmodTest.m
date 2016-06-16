%% Paramètres initiaux
nbSymbols= 10  ; % NB de symboles à transmettre

symbols = randi([0 1],nbSymbols,1); %g�n�rations des symboles al�atoires

fe = 2457600000;      % Fréquence des �chantillons: On a 1000 echantillons par secondes

%% Modulation
% Génération d'un sinus et ajout d'un bruit blanc Gaussien

%Param�tres de la modulation
fc = 433000000;% fréquence centrale 
fd = 600000; %fr�quence de d�viation
dfc = fc/100; %frequency offset

%Param�tres de calculs
fm = 2*fd;       % nombre de bit par secondes par channel
N = (nbSymbols)*(fix(fe/fm/2));       % Nombre d'�chantillons dans chaque voie
k = (1:N)/(N*fc/100) + ones(1,N)


% Axe des temps
t = (1:N)/fe;

% G�n�ration des cosinus et sinus surr�lev�s
rootRaised = mskmod(symbols,fix(fe/fm/2),[],pi/2);

% Génération du sinus pour les coeffs
sinPorteuse = sin(2*pi* (fc+k*dfc) .*t);
cosPorteuse = cos(2*pi* (fc+k*dfc) .*t);

partI = sinPorteuse .* imag(rootRaised)' ;   % multiplication element par element
partQ = cosPorteuse .* real(rootRaised)' ;

s = partI + partQ ;
signal=awgn(s,5); %Ajout d'un bruit gaussien


%% Démodulation

demodI = signal .* sinPorteuse ;
demodQ = signal .* cosPorteuse ;

b = ones(1,150)*(1/100);
%b = [1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10];
resI = filter(b,1,demodI);
resQ = filter(b,1,demodQ);

resSum = resQ + j*resI ;
%% FFT

spectre = abs(fft(cosPorteuse));

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
plot(t, cosPorteuse);
title('cosPorteuse')

subplot(426);
plot(t, sinPorteuse);
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
plot(t, resI);
title('Channel I en reception apr�s filtrage');

subplot(223);
plot(t, resQ);
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


