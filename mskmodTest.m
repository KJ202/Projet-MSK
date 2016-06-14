%% Paramètres initiaux
nbSymbols= 10  ; % NB de symboles à transmettre


nsamp = 32 ; %nombre d'�chantillons pour un bit dans le channel I et Q. Dans chaque channel, un bit sera cod� sur 2*nsamp �chantillons
symbols = randi([0 1],nbSymbols,1);


%% Modulation
% Génération d'un sinus et ajout d'un bruit blanc Gaussien

fp = 100;      % fréquence de la porteuse 
fm = 20;       % nombre de bit par secondes par channel
fe = 1000;      % Fréquence des �chantillons: On a 1000 echantillons par secondes
N = (var/2)*(fe/fm);       % Nombre d'�chantillons dans chaque voie

% Axe des temps
t = (1:N)/fe;

% G�n�ration des cosinus et sinus surr�lev�s
rootRaised = mskmod(symbols,fe/fm/2,[],pi/2);

% Génération du sinus pour les coeffs

sinPorteuse = sin(2*pi* fp *t);
cosPorteuse = cos(2*pi* fp *t);

partI = sinPorteuse .* imag(rootRaised)' ;   % multiplication element par element
partQ = cosPorteuse .* real(rootRaised)' ;

signal = partI + partQ ;
%s=awgn(signal,10);
%% Démodulation

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
plot(t2,symbols,'bs');
xlabel('Symboles : bits input')

subplot(424);
plot(t, cosPorteuse);
xlabel('cosPorteuse')

subplot(422);
plot(t, real(rootRaised));
xlabel('Partie r�elle : coeff ak ?')

subplot(423);
plot(t, partQ);
xlabel('partie Q modulée')

subplot(425);
plot(t, signal);
xlabel('Signal modulé')


L = N ;
f = fe*(0:(L/2))/L;
fft1Signal = abs(fft(cosPorteuse));
fft2Signal = fft1Signal(1:L/2+1);

fft1PartQ = abs(fft(partQ));
fft2PartQ = fft1Signal(1:L/2+1);

subplot(426);
plot(f,fft2PartQ);
xlabel('fft de partQ')

subplot(427);
plot(f,fft2Signal);
xlabel('fft du signal modul�')

subplot(428);
plot(z,'bs');
xlabel('Symboles re�us')

