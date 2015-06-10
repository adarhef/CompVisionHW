function [ displayedCorr ] = DisplayCorr( image1, image2, matches, distVals, x )
    
    diff = size(image1, 1) - size(image2, 1);
    if (diff > 0) % pad the smaller image with zero rows
        image2 = cat(1, image2, zeros(abs(diff), size(image2, 2)));
    else
        image1 = cat(1, image1, zeros(abs(diff), size(image1, 2)));
    end    
    [~, indices] = sort(distVals);
    for i=1:min(x, size(matches, 1))
        matchRow = matches(indices(i), :);
        image1 = insertText(image1, matchRow(1:2), i);
        image2 = insertText(image2, matchRow(3:4), i);
    end
    % at this point both images are the same height and can be concatenated
    imshow([image1 image2]);
    displayedCorr = matches(1:x ,:);
end

