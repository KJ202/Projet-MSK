%Programm that makes the treatment og the signal given by our teacher
%@signal z(k,i) given by Guirec Poulennec
%returns the sampler e(i,k)

function f = derivationOfEstimator(z)
%derivationOfEstimator(z) makes a treatment on the signal z
%@z the signal given to the function.

A=[];
lengthSignal = size(z);
A = matrixing(z,lengthSignal);
%disp(A);
lengthColumn = size(A(:,1));

for k=1:lengthColumn(1)
    for i=1:16
        A(k,i)=squarred(A(k,i));
        A(k,i)=A(k,i)*(-1)^(k+1);
    end        
end
f = A;


function g = squarred(z)
%squarred(x) returns x²
%@x the signal given.
g = z*z;

function h = matrixing(z,l)
%shinfting(y) return the signal shifted.
%@y the signal given
%@i the sample

A=[];
for k=1:(l(1)/16)
    for i=1:16
        A(k,i)=z((k-1)*16+i);
    end;
end
h=A;

    











