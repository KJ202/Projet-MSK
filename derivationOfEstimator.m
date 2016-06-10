%Programm that makes the treatment og the signal given by our teacher
%@signal z(k,i) given by Guirec Poulennec
%returns the sampler e(i,k)

function f = derivationOfEstimator(i)
%derivationOfEstimator(z) makes a treatment on the signal z
%@z the signal given to the function.
z = [
0.122411 
0.242980 
0.359895 
0.471397 
0.575808 
0.671559 
0.757209 
0.831470 
0.893224 
0.941544 
0.975702 
0.995185 
0.999699 
0.989177 
0.963776 
0.923880 
0.870087 
0.803208 
0.724247 
0.634393 
0.534998 
0.427555 
0.313682 
0.195090 
];

A=[];
lengthSignal = size(z);
A = matrixing(z,i,lengthSignal);
disp(A);
lengthColumn = size(A(:,1));

for k=1:lengthColumn(1)
    for i=1:8
        A(k,i)=squarred(A(k,i));
        A(k,i)=A(k,i)*(-1)^(k+1);
    end        
end






f = A;


        


function g = squarred(z)
%squarred(x) returns x²
%@x the signal given.
g = z*z;

function h = matrixing(z,i,l)
%shinfting(y) return the signal shifted.
%@y the signal given
%@i the sample

A=[];
for k=1:(l(1)/8)
    for i=1:8
        A(k,i)=z(i);
    end;
end
h=A;

    











