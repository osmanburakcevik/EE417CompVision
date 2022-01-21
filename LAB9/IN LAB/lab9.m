clear all; close all; clc;
%% Definitions
%rng(1);
L = 300;
I1 = zeros(L,L);

f=L;
u0 = L/2;
v0 = L/2;

K = [f 0 u0;    
    0 f v0;
    0 0 1];

DEG_TO_RAD = pi/180;

%% World Coordinates
% we need to select 8 points since min 8 points is needed to estimate the
% essential matrix E
P_W=[0	2	0	1; %1
    0	1	0	1; %2
    0	0	0	1; 
    0	2	-1	1; 
    0	1	-1	1; %5 
    0	0	-1	1; %6
    0	2	-2	1; 
    0	1	-2	1; 
    0	0	-2	1; %9
    1	0	0	1; %10
    2	0	0	1; 
    1	0	-1	1; %12
    2	0	-1	1; %13
    1	0	-2	1;
    2	0	-2	1; 
    1	1	0	1; 
    2	1	0	1; 
    1	2	0	1;
    2	2	0	1
    ];

P_W = P_W';
NPTS = size(P_W,2); %Number of points


% SPTS = [0	2	0	1;
%         0	1	0	1;
%         0	1	-1	1;
%         0	0	-1	1;
%         0	0	-2	1;
%         1	0	0	1;
%         1	0	-1	1;
%         2	0	-1	1;
%     ];

%% Visualization
figure;
subplot(1,3,1)
wally = meshgrid(0:0.1:3); 
wallz = meshgrid(-3:0.1:0); 
wallx = 0*ones(size(wallz,1));
surf(wallx, wally, wallz','FaceColor',(1/255)*[97 178 205],'EdgeColor','none') 
hold on
wallx = meshgrid(0:0.1:3); 
wallz = meshgrid(-3:0.1:0); 
wally = 0*ones(size(wallz,1)); 
surf(wallx, wally, wallz','FaceColor',(1/255)*[77 137 157],'EdgeColor','none') 
wallx = meshgrid(0:0.1:3); 
wally = meshgrid(0:0.1:3); 
wallz = zeros(size(wally,1)); % Generate z data
surf(wallx, wally', wallz,'FaceColor',(1/255)*[45 162 200],'EdgeColor','none') 
plot3(P_W(1,:),P_W(2,:),P_W(3,:),'b.','MarkerSize',36);
axis equal;
grid on
axis vis3d;
axis([-3 3 -3 3 -3 3])
grid on
xlabel('x')
ylabel('y')
zlabel('z')

%% Camera Transformation for View 1
ax = 120 * DEG_TO_RAD;
ay = 0 *DEG_TO_RAD;
az = 60 * DEG_TO_RAD;

Rx = [1 0 0;
      0 cos(ax) -sin(ax);
      0 sin(ax) cos(ax)];
Ry = [cos(ay)  0  sin(ay);
           0   1     0;
      -sin(ay) 0  cos(ay)];
Rz = [cos(az) -sin(az) 0;
      sin(az) cos(az)  0;
      0          0     1];
  
Rc1 = Rx*Ry*Rz;
Tc1 = [0;0;5];
M = [Rc1 Tc1];

p1 = K*(M * P_W);
noise1 = 4*rand(3,NPTS)-2;
noise1(3,:)=1;
p1 = p1 + noise1;

u1(1,:) = p1(1,:) ./ p1(3,:);
u1(2,:) = p1(2,:) ./ p1(3,:);
u1(3,:) = p1(3,:) ./ p1(3,:);

for i=1:length(u1)
    x = round(u1(1,i)); y=round(u1(2,i));
    I1(y-2:y+2, x-2:x+2) = 255;
end

subplot(1,3,2), imshow(I1, []), title('View 1', 'FontSize',20);

%% Camera Transformation for View 2
ax = 0 * DEG_TO_RAD;
ay = -25 *DEG_TO_RAD;
az = 0 * DEG_TO_RAD;

Rx = [1 0 0;
      0 cos(ax) -sin(ax);
      0 sin(ax) cos(ax)];
Ry = [cos(ay)  0  sin(ay);
           0   1     0;
      -sin(ay) 0  cos(ay)];
Rz = [cos(az) -sin(az) 0;
      sin(az) cos(az)  0;
      0          0     1];

Rc2c1 = Rx*Ry*Rz;
TrueR = Rc2c1;
Tc2c1 = [3;0;1];
TrueT = Tc2c1;
Hc1 = [Rc1 Tc1; 0 0 0 1];
Hc2c1 = [Rc2c1 Tc2c1; 0 0 0 1];
Hc2 = Hc2c1*Hc1;

Rc2 = Hc2(1:3,1:3);
Tc2 = Hc2(1:3,4);

M = [Rc2 Tc2];

I2 = zeros(L,L);
p2 = K*(M*P_W);

noise2 = 4*rand(3,NPTS)-2;
noise2(3,:)=1;
p2 = p2 + noise2;

u2(1,:) = p2(1,:) ./ p2(3,:);
u2(2,:) = p2(2,:) ./ p2(3,:);
u2(3,:) = p2(3,:) ./ p2(3,:);

for i=1:length(u2)
    x = round(u2(1,i)); y=round(u2(2,i));
    I2(y-2:y+2, x-2:x+2) = 255;
end

subplot(1,3,3), imshow(I2, []), title('View 2', 'FontSize',20);

t = Tc2c1;
T_skew = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];
Etrue = T_skew*Rc2c1;

%% Displaying the information
disp('u1: Pixel coordinates in view 1')
u1info = ['Size of u1 is ' num2str(size(u1,1)) 'x' num2str(size(u1,2))];
disp(u1info)
disp('u2: Pixel coordinates in view 2')
u2info = ['Size of u2 is ' num2str(size(u2,1)) 'x' num2str(size(u2,2))];
disp(u2info)
disp('-------------')
%% Lab#8 Assignment starts here.
%% Transform pixel coordinates and construct X matrix using Equations 1 and 2
X=[];
for i=[1,2,5,6,9,10,12,13]
    P1=(inv(K)*u1);
    x1=inv(K)*u1(:,1);
    y1=inv(K)*u1(:,2);
    z1=inv(K)*u1(:,3);
    P2=(inv(K)*u2);
    x2=inv(K)*u2(:,1);
    y2=inv(K)*u2(:,2);
    z2=inv(K)*u2(:,3);
    a=[x1.*x2 x1.*y2 x1.*z2 y1.*x2 y1.*y2 y1.*z2 z1.*x2 z1.*y2 z1.*z2]';
    X=[X;a'];
end


%% Estimate E, cure it and check for Essential Matrix Characterization 

[U, S, V]=svd(X'*X);
Es=V(:,9);
E_est=[Es(1) Es(4) Es(7);
       Es(2) Es(5) Es(8);
       Es(3) Es(6) Es(9)];

[U_est Sigma_est V_est]=svd(E_est);

sigma_cured=[1 0 0; 0 1 0; 0 0 1];

E_estCured=U_est*sigma_cured*V_est;
%% Find epipoles and epipolar lines
e1=null(E_estCured);
e2=null(E_estCured');
L1=(E_est')*(x2);
L2=(E_est)*(x1);

%% Verify epipoles and epipolar lines
verified=0;

c1=L1'*e1;
c2=L2'*e2;

%% Recover the rotation and the translation
q=pi/2;
Rz1=[cos(q) -sin(q) 0; sin(q) cos(q) 0; 0 0 1]
Rz2=[cos(-q) -sin(-q) 0; sin(-q) cos(-q) 0; 0 0 1]

T1=U_est*Rz1*Sigma_est*U_est';
T1=[T1(3,2) ;-T1(3,1); T1(2,2)];
R1=U_est*Rz1*V_est';

T2=U_est*Rz2*Sigma_est*U_est';
T2=[T2(3,2); -T2(3,1); T2(2,2)];
R2=U_est*Rz2*V_est';

%% Compare your results with ground truth
disp('True E =')
disp(Etrue)
disp('Estimated E = ')
disp(E_est)
disp('-------------')
disp('-------------')

% R should be exactly similar, but one of them only since the other means
% the case when the camera is behind the view
disp('True R =')
disp(TrueR)
disp('Estimated R1 & R2 :')
disp('R1_est = ')
disp(R1)
disp('-------------')
disp('R2_est = ')
disp(R2)
disp('-------------')
disp('-------------')

% T should be scaled version of True T, since we cannot find a unique T and
% it is always up to scale
disp('True T =')
disp(TrueT)
disp('Estimated T1 & T2 :')
disp('T1_est = ')
disp(T1)
disp('-------------')
disp('T2_est = ')
disp(T2)
disp('-------------')