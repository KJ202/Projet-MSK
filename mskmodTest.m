%% ParamÃ¨tres initiaux
nbSymbols= 30  ; % NB de symboles Ã  transmettre

symbols = randi([0 1],nbSymbols,1); %générations des symboles aléatoires

fe = 10000;      % FrÃ©quence des échantillons: On a 1000 echantillons par secondes

%% Modulation
% GÃ©nÃ©ration d'un sinus et ajout d'un bruit blanc Gaussien

%Paramètres de la modulation
fc = 500;% frÃ©quence centrale 
fd = 100; %fréquence de déviation

%Paramètres de calculs
fm = 2*fd;       % nombre de bit par secondes par channel
N = (nbSymbols)*(fix(fe/fm/2));       % Nombre d'échantillons dans chaque voie

% Axe des temps
t = (1:N)/fe;

% Génération des cosinus et sinus surrélevés
rootRaised = mskmod(symbols,fix(fe/fm/2),[],pi/2);

% GÃ©nÃ©ration du sinus pour les coeffs

sinPorteuse = sin(2*pi* fc *t);
cosPorteuse = cos(2*pi* fc *t);

partI = sinPorteuse .* imag(rootRaised)' ;   % multiplication element par element
partQ = cosPorteuse .* real(rootRaised)' ;

signal = partI + partQ ;
%s=awgn(signal,10);
%% DÃ©modulation

demodI = signal .* sinPorteuse ;
demodQ = signal .* cosPorteuse ;

b = [1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10];
resI = filter(b,1,demodI);
resQ = filter(b,1,demodQ);

resSum = resQ + j*resI ;
%z = mskdemod(resSum,nsamp,[],pi/2);

%% FFT

spectre = abs(fft(cosPorteuse));

%% Plot

subplot(421);
plot(symbols,'bs');
title('Generated symbols')

subplot(422);
plot(t, signal);
title('Signal modulé')

subplot(423);
plot(t, real(rootRaised));
title('Partie réelle (Q)')

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
title('partie Q modulée par un cosinus')

subplot(428);
plot(t, partI);
title('partie I modulée par un cosinus')

Y = fft(partQ);

P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fe*(0:(N/2))/N;
figure
subplot(211);
plot(f,P1)
title('Single-Sided Amplitude Spectrum of partQ(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


Y = fft(signal);

P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fe*(0:(N/2))/N;
subplot(212);
plot(f,P1)
title('Single-Sided Amplitude Spectrum of signal(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
