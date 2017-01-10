
newfeature = zeros(1236*256,13*13);
for row = 1:1236
    for j = 1:256
    newfeature((row-1)*256+j,:) = feats(row,(j-1)*169+1:(j-1)*169+169);
    end
end
    
    
    


