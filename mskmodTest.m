<<<<<<< HEAD
var = 50 ;
nsamp = 16 ;
=======
%% Paramètres initiaux
var = 10 ; % NB de symboles à transmettre
nsamp = 32 ;
>>>>>>> cf4a64f2d534ddad5dc4a508beaa2f60cba75ee5
x = randi([0 1],var,1);
t1 = [1:var*nsamp];
t2 = [1:var];
y = mskmod(x,nsamp,[],pi/2);



%% Modulation
% Génération d'un sinus et ajout d'un bruit blanc Gaussien

fp = 150;      % fréquence de la porteuse
fe = 1000;      % Fréquence d'échantillonnage
N = var*nsamp;       % Nombre de points de la séquence

% Axe des temps
t = (1:N)/fe;

% Génération du sinus pour les coeffs
%sinCoeff = sin(2*pi/4* fe *t)       % dépend du bits/sec

sinPorteuse = sin(2*pi* fp *t);
cosPorteuse = cos(2*pi* fp *t);

partI = sinPorteuse .* imag(y)' ;   % multiplication element par element
partQ = cosPorteuse .* real(y)' ;

signal = partI + partQ ;

%% Démodulation

demodI = signal .* sinPorteuse ;
demodQ = signal .* cosPorteuse ;

b = [1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10];
resI = filter(b,1,demodI);
resQ = filter(b,1,demodQ);

resSum = resQ + j*resI ;
z = mskdemod(resSum,nsamp,[],pi/2);

%% Plot

subplot(421);
plot(t2,x,'bs');
xlabel('Symboles : bits input')

subplot(422);
plot(real(y));
xlabel('Partie imaginaire : coeff bk')

subplot(423);
plot(cosPorteuse);
xlabel('Porteuse')

subplot(424);
plot(partQ);
xlabel('partie Q modulée')

subplot(425);
plot(signal);
xlabel('Signal modulé')

subplot(426);
plot(demodQ);
xlabel('Partie I démodulée avant filtre')

subplot(427);
plot(resQ);
xlabel('Part I démodulée après filtre')

subplot(428);
plot(z);
xlabel('Symboles reçus')

