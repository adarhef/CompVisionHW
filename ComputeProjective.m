function [ TransformedIm ] = ComputeProjective( im, H )
    imSize = size(im);
    height = imSize(1);
    width = imSize(2);
    
    xMax = 1;
    yMax = 1;
    for i = 1:height
        for j = 1:width
            vec = H*[i; j; 1];
            xCur = vec(1);
            yCur = vec(2);
            if (xCur > xMax)
                xMax = xCur;
            end
            if (yCur > yMax)
                yMax = yCur;
            end
        end
    end
    
    % Now we have the target size.
    
    invH = inv(H);
    xMax = round(xMax);
    yMax = round(yMax);
    
    imageMat = zeros(xMax, yMax);
    for i = 1:xMax
        for j = 1:yMax 
            src = invH*[i; j; 1];
            rSrc = round(src); % nearest neighbor
            if ((rSrc(1) >= 1) && (rSrc(1) <= height)) && ((rSrc(2) >= 1) && (rSrc(2) <= width))
                imageMat(i, j) = im( rSrc(1), rSrc(2) );
            end
        end
    end
     
    TransformedIm = imageMat;
end

