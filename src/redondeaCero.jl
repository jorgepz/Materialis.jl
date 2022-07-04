function [matrix] = redondeaCero(matrix)


for i=1:size(matrix,2)
  indisCasiNulos = find( abs( matrix(:,i) - 0 ) < 1e-10*max(abs( matrix(:,i) )) ) ;
  matrix( indisCasiNulos,i) = 0 ;
end
