function C2=C2eval(v,C2p)

%% condition C2

C2=(C2p||(isempty(v.Request)&&isempty(v.To)&&isempty(v.From)&&isempty(v.Direction)));


end
      