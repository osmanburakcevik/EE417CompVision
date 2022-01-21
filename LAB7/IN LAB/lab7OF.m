function lab6OF(ImPrev,ImCurr,k,Threshold)
% Smooth the input images using a Box filter
boxfilt = [1 1 1; 1 1 1;1 1 1]
smP = conv2(ImPrev, boxfilt);
smC = conv2(ImCurr, boxfilt);
% Calculate spatial gradients (Ix, Iy) using Prewitt filter
X_f = [ -1 0 1 ; -1 0 1; -1 0 1 ];
Y_f =  [-1 -1 -1 ; 0 0 0; 1 1 1];
Ix = conv2(smC,X_f,"same");
Iy = conv2(smC,Y_f,"same");
% Calculate temporal (It) gradient
tempG = smP - smC;
[ydim,xdim] = size(ImCurr);
Vx = zeros(ydim,xdim);
Vy = zeros(ydim,xdim);
G = zeros(2,2);
b = zeros(2,1);
for x=k+1:k:xdim-k-1
    for y=k+1:k:ydim-k-1
     % Calculate the elements of G and b
     G(1,1)= sum(sum(Ix(y-k:y+k,x-k:x+k).^2));
     G(1,2)= sum(sum(Ix(y-k:y+k,x-k:x+k).*Iy(y-k:y+k,x-k:x+k)));
     G(2,1)= sum(sum(Ix(y-k:y+k,x-k:x+k).*Iy(y-k:y+k,x-k:x+k)));
     G(2,2)= sum(sum(Iy(y-k:y+k,x-k:x+k).^2));
     
     b(1,1)= sum(sum(Ix(y-k:y+k,x-k:x+k).*tempG(y-k:y+k,x-k:x+k)));
     b(2,1)= sum(sum(Iy(y-k:y+k,x-k:x+k).*tempG(y-k:y+k,x-k:x+k)));

    if (min(eig(G)) < Threshold)
        Vx(cy,cx)=0;
        Vy(cy,cx)=0;
    else
        % Calculate u
        u = -1*(inv(G)* b);
        Vx(y,x)=u(1);
        Vy(y,x)=u(2);
    end
end
end
cla reset;
imagesc(ImPrev); hold on;
[xramp,yramp] = meshgrid(1:1:xdim,1:1:ydim);
quiver(xramp,yramp,Vx,Vy,10,'r');
colormap gray;
end