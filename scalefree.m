function L=scalefree(d0,n)

A=[0 1 1; 1 0 0; 1 0 0];


while(length(A)<n)

   w=sum(A)/length(A);
   same=1;
   
   
    while(same==1)
  
    y = randsample(length(A),d0,true,w);
    
    if(length(unique(y))==d0)
        same=0;
    else
        same=1;
    end
    
    
    end
    Anew=zeros(length(A)+1);
    
    Anew(1:length(A),1:length(A))=A;
    
    Anew(end,y)=1;
    Anew(y,end)=1;
    
    A=Anew;
    
    

    
end

L=diag(sum(A))-A;
end





