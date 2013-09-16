function L=erdosrenyi(p,n)

b=1;
while(b==1)
A=zeros(n);
for(i=1:length(A))
    for(j=i+1:length(A))
    if(rand()<p)
        A(i,j)=1;
        A(j,i)=1;
    end
    end
end

    
   L= diag(sum(A))-A;
   
  if( length(find(eig(L)==0))==1)
      b=0;
  else
      b=1;
  end
  
end
    
end