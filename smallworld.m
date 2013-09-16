function L=smallworld(p,n)

A=zeros(n);

V=ones(length(A)-1,1);
V2=ones(length(A)-2,1);
A=diag(V,1)+diag(V2,2)+diag(V,-1)+diag(V2,-2);
%set up inital ring 
A(1,end)=1;
A(end,1)=1;
A(length(A)-1,1)=1;
A(1,length(A)-1)=1;
A(2,end)=1;
A(end,2)=1;

%reassign links with probability p
for(i=1:length(A))
    for(j=i+1:length(A))
        if(A(i,j)==1)%check if entry is a link
        if(rand()<p)%flip coin
            if(A(i,j)==1)
                A(i,j)=0;%reassign
                A(j,i)=0;
                a=randsample(length(A),1);
                b=randsample(length(A),1);
                
                while(a==b)
                     a=randsample(length(A),1);
                 b=randsample(length(A),1);
                end
                A(a,b)=1;
                A(b,a)=1;
                
                
            end
        end
        end
    end
end


D=diag(sum(A));
L=D-A;

end
        



