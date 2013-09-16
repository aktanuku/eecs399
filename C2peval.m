function C2p=C2peval(v,network)

%% condition C2p.
C2p=0;
a=isempty(v.Request);
if(a)
    C2p=0;
else
    
    if(sum(find(v.From==v.Edge_list)))
     
       w= network(v.From);
       
      
      
        if(isempty(w.Request)==0)
            
        a=(w.Root==w.Id)&&(w.Id==w.From)&&(w.From==w.Request)&&(w.Request==v.From);
       
        b=(w.To==v.Id);
        c=(w.Direction=='A');
        d=(w.Parent==v.Id);
        e=(w.Request==v.Request)&&(w.Request~=w.Id)&&(v.Request~=w.Id);
        f=(v.From==w.Id);
        g=(v.To==v.Parent);
        h=(w.To==v.Id);
       

        C2p= (1&&(a&&b&&c))||(1&&d&&e&&f&&g&&h);
        else
            C2p=0;
        end
        
    end
    %VStfM63C
    %!3AsTupper#
end
        
    
        
        
    
    
    
    
    
    
    

    



end