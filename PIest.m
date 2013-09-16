

function [xout wout]=PIest(x,w,u,L)

%L=[2 -1 0 0 -1 0; -1 3 -1 0 -1 0; 0 -1 2 -1 0 0; 0 0 -1 3 -1 -1; -1 -1 0 -1 3 0; 0 0 0 -1 0 1];
%L=[ 2 -2 0 0 ; -1 1 0 0; 0 -1 2 -1; 0 0 1 -1];
g=1;

%Li=.99;
Li=.91;
Lp=.000002;
%Lp= 0.02;

%length([x;w])
%length([g*eye(size(L))*u; zeros(length(L))*u])
V=[-g*eye(size(L))-Lp*L*(1/length(L)) L'*Li*(1/length(L));  -Li*L*(1/length(L)) zeros(size(L))]*[x;w]+[g*eye(size(L))*u; zeros(length(L))*u]+[x;w];

%eig([-g*eye(size(L))-Lp*L*(1/length(L)) L'*Li*(1/length(L));  -Li*L*(1/length(L)) zeros(size(L))])

xout=V(1:length(L));
wout=V(length(L)+1:end);
end

