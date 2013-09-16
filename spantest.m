
converge=zeros(length(6:60)*10,4);% list to contain values of interest
count=0;
n=30;
Pconverge=[];%convergence tim of PI
Cconverge=[];%convergence time of ST
for(n=[15:40])  %iterate through size of network  

    
 for(p=[.3 .5 .8]) %interate through other variable (depends on what you want to check
   L=smallworld(p,n);%construct netwwork
   %L=scalefree(p,n); 
    %L=smallworld(.4,n);
    
    %L=smallworld(p,n);
    L=arena(p,n);
    
  u=[];  
    w=rand(length(L),1);
% populate graph
for(i=1:length(L))

a=L(i,:) ;
%note some of these variables have no functionality as of yet but there
%will be in the future
a(i)=0;
a=a*-1;
N=find(a~=0);

node.Id=i;
node.Edge_list=[N];
%node.Root=Rvec(i);
node.Root=node.Id;
if(~isempty(N))
node.Parent=N(1);
else
    node.Parent=node.Id;
end
%node.Parent=Pvec(i);
node.Distance=0;
node.Request=0;
node.Direction=0;
node.From=0;
node.To=0;
node.T=0;
node.Nchild=0;
node.Nchild2=0;
node.phasor=[rand() rand()];

node.input=rand();





node.input2=rand();
node.tots=[];
node.tots2=[];
node.cumtot=0;
node.cumtot2=0;
node.leaves=0;
node.reported=0;
node.reported2=0;
node.global_avg=0;
node.global_avg2=0;
node.location=[rand() rand() rand()];


network(i)=node;
end

for(i=1:length(L))

a=L(i,:) ;

a(i)=0;
a=a*-1;
N=find(a~=0);

node.Id=i;
node.Edge_list=[N];
node.Root=node.Id;
if(~isempty(N))
node.Parent=N(1);
else
    node.Parent=node.Id;
end
%node.Parent=Pvec(i);
node.Distance=0;
node.Request=0;
node.Direction=0;
node.From=0;
node.To=0;
node.T=0;
node.Nchild=0;
node.Nchild2=0;
node.phasor=[rand() rand()];

node.input=rand();
u=[u; node.input];
node.input2=rand();
node.tots=[];
node.tots2=[];
node.cumtot=0;
node.cumtot2=0;
node.leaves=0;
node.reported=0;
node.reported2=0;
node.global_avg=0;
node.global_avg2=0;
node.location=[rand() rand() rand()];


network(i)=node;
end





x=[];
globalclock=0;
i=0;
i=i+1;

actavg=0; 
actavg2=0;
for(i=1:length(network))
    actavg=actavg+network(i).input;
    actavg2=actavg2+network(i).input2;
end

actavg=[actavg/length(network)];
actavg2=[actavg2/length(network)];



Cs=0;
Cfilled=0;
Ps=0;
Pfilled=0;

x=rand(length(L),1);
w=rand(length(L),1);
fprintf('Size: %d, Initial degree: %d\n',n,p)
while(1)
    ind=mod(i,length(L))+1;
    %%
    ch=[];
    %update each node in network
    for j=1:length(network)
        ind=j;
    [network changed]=nodetrans(network(ind),network,ind);
    
    ch=[ch changed] ;
    
    network=avgest1(network(j),network,j);
    network=avgest2(network(j),network,j);
    globalclock=globalclock+1;
    end
   
   %PI estimator Update
   [xout wout]=PIest(x,w,u,L);
   Cs=Cs+1;
   Ps=Ps+1;
   x=xout;
   w=wout;
    
    Ap=zeros(n,n);
    
    for(ii=1:length(network))
            Ap(ii,network(ii).Parent)=1;
            Ap(network(ii).Parent,ii)=1;
    end
   
                
    
    g=[];
    h=[];
    for(kk=1:length(network))
        g=[g network(kk).global_avg];
        h=[h network(kk).global_avg2];
        
    end
    
%plot(i,max(abs(g-actavg)),'r+',i,max(abs(x-actavg)),'b+')
%hold on
%pause(.01)
if((max(abs(g-actavg))<.0001)&&(Cfilled==0))
    Cconverge=[Cconverge; n p Cs];
    Cfilled=1;
end

if((max(abs(x-actavg))<.0001)&&(Pfilled==0))
    Pconverge=[Pconverge; n p Ps];
    Pfilled=1;
end
if((max(abs(g-actavg))<.00001)&& (max(abs(x-actavg))<.00001))
    break;
end



i=i+1;



end
clf


 count=count+1;
 

converge(count,:)=[ n i (max(abs(g-actavg))) (max(abs(h-actavg2))) ];
i=0;

 end
end



 
for(i=1:length(network))
    network(i)
end










