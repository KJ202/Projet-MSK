var = 10 ;
nsamp = 16 ;
x = randi([0 1],var,1);
t1 = [1:var*nsamp];
t2 = [1:var];
y = mskmod(x,nsamp,[],pi/2);

subplot(322);
plot(t2,x,'bs');
ylabel('Bits input')

subplot(323);
plot(t1,imag(y));
ylabel('Partie Imaginaire')

subplot(324);
plot(t1,real(y));
ylabel('Part Réelle')

% Génération d'un sinus et ajout d'un bruit blanc Gaussien

fp = 100;      % fréquence de la porteuse
fe = 1000;      % Fréquence d'échantillonnage
N = var*nsamp;       % Nombre de points de la séquence

% Axe des temps
t = (1:N)/fe;

% Génération du sinus pour les coeffs
%%sinCoeff = sin(2*pi/4* fe *t)       % dépend du bits/sec

sinPorteuse = sin(2*pi* fp *t);
cosPorteuse = cos(2*pi* fp *t);

partI = sinPorteuse .* imag(y)' ;   % multiplication element par element
partQ = cosPorteuse .* real(y)' ;

signal = partI + partQ ;

subplot(325);
plot(t1,partI);
ylabel('Part I')

subplot(326);
plot(t1,partQ);
ylabel('Part Q')

subplot(321);
plot(signal);
ylabel('Signal MSK')