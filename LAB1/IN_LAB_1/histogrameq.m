function myHistEq()

current = imread('darkImage.png');

[r,c,~] = size(current);

new = uint8(zeros(r,c));

res = zeros(256,1);

cum = zeros(256,1);

cdf = zeros(256,1);

pdf = zeros(256,1);

f = zeros(256,1);

num = r*c;

for i = 1:1:r
    
    for j = 1:1:c
        
        x = current(i,j);
        f(x+1) = f(x+1)+1;
        pdf(x+1) = f(x+1)/num;
        
    end
    
end

sum =0 ;

val = 255;

for i = 1:1:size(pdf)
    
    sum=f(i)+sum;
    
    cum(i)=sum;
    
    cdf(i)=cum(i)/ num;
    
    res(i) =round(val*cdf(i));
    
end


for i = 1:1:r
    
    for j = 1:1:c
        
        new(i,j) = res(current(i,j)+1);
        
    end
    
end