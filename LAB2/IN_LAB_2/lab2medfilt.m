function [Filtered_img] = lab2medfilt(img,k)

    [row,col,ch]=size(img);
    
    if (ch==3)
        
        img = rgb2gray(img);
        
    end
    
    img = double(img);
    
    Filtered_img = zeros(size(img));
    
    GaussianFiltered = lab2gaussfilt(img);
    
    for i = k+1:1:row-k-1
        
        for j = k+1:1:col-k-1
            
            Window = img(i-k:i+k,j-k:j+k);
            value = myMedian(Window);
            Filtered_img(i,j) = value;
            
        end
        
    end
    
    img = uint8(img);
    
    Filtered_img = uint8(Filtered_img);
    
    
    figure
    subplot(1,3,1)
        imshow(img)
    subplot(1,3,2)
        imshow(GaussianFiltered)
    subplot(1,3,3)
        imshow(Filtered_img)

end