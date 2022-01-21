function [Sharpened_img] = lab2sharpen(img,limbda,M)

    [row,col,ch]=size(img);
    
    if (ch==3)
        
        img = rgb2gray(img);
        
    end
    
    
    if (M==1)
        
        Smoothed = lab1locbox(img,2); 
        
    elseif (M==2)
        
        Smoothed = lab2gaussfilt(img);
        
    elseif (M==3)
        
        Smoothed = lab2medfilt(img,3);
        
    end
    
    
    img = double(img);
    
    Smoothed = double(Smoothed);
    
    
    Sharpened_img = img + limbda*(img - Smoothed);
    
    
    img = uint8(img);
    
    Smoothed = uint8(Smoothed);
    
    Sharpened_img = uint8(Sharpened_img);
    
    
    figure('NumberTitle', 'off', 'Name', 'Sharpening');
        subplot(1,2,1)
            imshow(img)
            title('Original Image');
        subplot(1,2,2)
            imshow(Sharpened_img)
            title('Sharpened Image');
    
end
