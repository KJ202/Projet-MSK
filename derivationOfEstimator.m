%Programm that makes the treatment og the signal given by our teacher
%@signal z(k,i) given by Guirec Poulennec
%returns the sampler e(i,k)

function f = derivationOfEstimator(signal)
%derivationOfEstimator(z) makes a treatment on the signal z
%@z the signal given to the function.

N=2048;
lengthSignal = size(signal);
A = matrixing(signal,lengthSignal);

lengthColumn = size(A(:,1));

for k=1:lengthColumn(1)
    for i=1:N
        A(k,i)=squarred(A(k,i));
        A(k,i)=A(k,i)*exp(2i*pi/2*(k+i/N));
       
    end        
end
f = A;

function g = squarred(z)
%squarred(x) returns x²
%@x the signal given.
g = z*z;

function h = matrixing(signal,lengthSignal)
%shinfting(y) return the signal shifted.
%@y the signal given
%@i the sample
N=2048;
A=[];
for k=1:(lengthSignal(2)/N)
    for i=1:N
        A(k,i)=signal((k-1)*N+i);
    end
end
h=A;
