%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% This script is used in designing, depicting, and analyzing a roller
% coaster for Lab 1 in ASEN 2003.
% The purpose of this Main.m script is to build the track element equations
% and call functions to perform tasks such as finding the track length and
% create necessary plots.
% 
% Authors:  Keith Covington
%           Ryan Davis
% Created:  01/23/2017
% Modified: 01/31/2017
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Housekeeping
clear all; close all; clc;


%% Definitions

global int1 int2 int3 int4 int5 int6 int7 int8 int9 int10 x y z...
	x10 y10 z10 g Gn speed aBrake brakeSpeed bankAng1...
	bankAng2 trackLength endZ2 rad

h0 = 125;           % initial height of track [m]
hf = 0;             % final height of track [m]
maxLength = 1250;   % max length of track [m]
g = 9.807;          % acceleration due to gravity [m/s^2]
maxG_fwd = 5;       % max G's on rider forward (back of seat pushing on rider)
maxG_back = 4;      % max G's on rider back (seat restraint pushing back the rider)
maxG_up = 6;        % max G's on rider up (i.e. pushing up through the rider’s seat)
maxG_down = 1;      % max G's on rider down (i.e. pushing down on the rider through the lap bar)
maxG_lat = 3;       % max G's on rider lateral (pushing to the left or right on the rider)


%% Define functions

% Calculate speed at any given height--from conservation of energy
speed = @(h) sqrt( 2 .* g .* (h0-h) );

% Calculate G's on passenger
Gs = @(accel) accel ./ g; %probably can't use this (bummer)


% -------------------------- Track Elements -------------------------------

%% Initial Decent
% Initial Starting Coordinates
initX = 0;
initY = 0;
initZ = 125;

% Initial decent parameterized with respect to t
x1 = @(t) (0.5 .* g .* t.^2) .* sqrt(2)/2;
y1 = @(t) 0.*t;
z1 = @(t) 125 - (0.5 .* g .* t.^2) .* sqrt(2)/2;

%hf = 125-65+26-26*sqrt(2)/2; % end height of initial decent

% Time interval for initial decent
t0_1 = 0;
tf_1 = sqrt((156/sqrt(2)+52)/g)-0.3;
%int1 = t0_1 : 0.001 : tf_1;
int1 = linspace(t0_1, tf_1, 69619);

% End coordinates of decent
endX1 = x1(int1(end));
endY1 = y1(int1(end));
endZ1 = z1(int1(end));


%% Semi-circle valley

xz_qCircle = sqrt(2)/2 * 40; % x or y length of quarter circle

% Semi-circle valley path parameterized with respect to t
x2 = @(theta) 40 .* cos(theta) + endX1-40*cos(5*pi/4);
y2 = @(theta) 0 .* theta;
z2 = @(theta) 40 .* sin(theta) + endZ1+40/sqrt(2);
%int2 = 5*pi/4 : 0.001 : 7*pi/4;
int2 = linspace(5*pi/4, 7*pi/4, 51979);

% End coordinates of semicircle
endX2 = x2(int2(end));
endY2 = y2(int2(end));
endZ2 = z2(int2(end));


%% Parabolic hill (zero-gravity section)

% Parabolic path parameterized with respect to t
x3 = @(t) endX2 + sqrt(g*(125-endZ2)) .*t;
y3 = @(t) 0.*t;
z3 = @(t) endZ2 + sqrt(g*(125-endZ2)).*t -g/2.*(t.^2);

% Parabolic path time interval
tf_3 = 2 * sqrt(g*(125-endZ2))/g;
%int3 = 0 : 0.001 : tf_3;
int3 = linspace(0, tf_3, 113029);

% End coordinates of parabolic hill
endX3 = x3(int3(end));
endY3 = y3(int3(end));
endZ3 = z3(int3(end));

% 1/8 circle parameterized with respect to t
x4 = @(theta) 40 .* cos(theta) + endX3-40*cos(5*pi/4);
y4 = @(theta) 0 .* theta;
z4 = @(theta) 40 .* sin(theta) + endZ3+40/sqrt(2);
%int4 = 5*pi/4 : 0.001 : 3*pi/2;
int4 = linspace(5*pi/4, 3*pi/2, 20410);

% End coordinates of 1/8 circle
endX4 = x4(int4(end));
endY4 = y4(int4(end));
endZ4 = z4(int4(end));


%% Perfectly banked turn

% Staight line approach to turn
x5 = @(t) t + endX4;
y5 = @(t) 0 .* t;
z5 = @(t) 0 .* t + endZ4;
%int5 = 0 : 0.001 : 20;
int5 = linspace(0, 20, 20000);

% End coordinates of straight line
endX5 = x5(int5(end));
endY5 = y5(int5(end));
endZ5 = z5(int5(end));

% Banked turn
x6 = @(theta) 40 .* sin(theta) + endX5;
y6 = @(theta) 40 .* cos(theta) + 40; 
z6 = @(theta) 0 .* theta + endZ5;
%int6 = pi/2 : 0.001 : pi;
int6 = linspace(pi/2, pi, 40820);

% End coordinates of banked turn
endX6 = x6(int6(end));
endY6 = y6(int6(end));
endZ6 = z6(int6(end));


%% Loop

loopRad = (124-endZ6)/2; % radius of loop-de-loop

% Loop parameterized with respect to theta
x7 = @(theta) 0 .* theta + endX6 + 40;
y7 = @(theta) loopRad .* cos(theta) + endY6 + 40; 
z7 = @(theta) loopRad .* sin(theta) + endZ6 + loopRad;
%int7 = -pi/2 : 0.001 : 3*pi/2;
int7 = linspace(-pi/2, 3*pi/2, 163358);

% End coordinates of loop
endX7 = x7(int7(end));
endY7 = y7(int7(end));
endZ7 = z7(int7(end));


%% Drop to h=0

% Drop/turn parameterized with respect to theta
x8 = @(theta) 40 .* sin(theta) + endX7 - 40;
y8 = @(theta) 40 .* cos(theta) + endY7; 
z8 = @(theta) 40 .* sin(theta) + endZ7 - 40;
%int8 = pi/2 : -0.001 : 0;
int8 = linspace(pi/2, 0, 57269);

% End coordinates of drop/turn
endX8 = x8(int8(end));
endY8 = y8(int8(end));
endZ8 = z8(int8(end));

% 1/8 circle drop parameterized with respect to theta
rad = endZ8/(1-sqrt(2)/2); % radius of circle
x9 = @(theta) rad .* cos(theta) - sqrt(2)/2*rad + endX8;
y9 = @(theta) 0 .* theta + endY8; 
z9 = @(theta) rad .* sin(theta) + rad;
%int9 = 7*pi/4 : -0.001 : 3*pi/2;
int9 = linspace(7*pi/4, 3*pi/2, 64555);

% End coordinates of drop
endX9 = x9(int9(end));
endY9 = y9(int9(end));
endZ9 = z9(int9(end));


%% Braking section

% Staight line finish
x10 = @(t) t;
y10 = @(t) 0 .* t + endY9;
z10 = @(t) 0 .* t + endZ9;
%int10 = endX9 : -0.001 : 0;
int10 = linspace(endX9, 0, 194468);

% End coordinates of straight line
endX10 = x10(int10(end));
endY10 = y10(int10(end));
endZ10 = z10(int10(end));

% Calculate acceleration durring braking section
aBrake = (-(speed(endZ10))^2) / (2* endX9);
brakeSpeed = @(x) sqrt( 2*aBrake * (x) + (speed(endZ10))^2 );



% ---------------------- End Track Elements -------------------------------



%% Calculate G's

% G-Force for initial decent
G1 = @(t) cos(pi/4) + 0.*t;

%G-Force for second section
G2 = @(theta) (speed(z2(theta)).^2)./(g*40) - sin(theta);

%G-Force of parabolic hill
G3 = @(t) 0.*t;

%G-Force of 1/8 circle
G4 = @(theta) (speed(z4(theta)).^2)./(g*40) - sin(theta);

%G-Force of straight line
G5 = @(t) 0.*t + 1;

%G-Force of banked turn
bankAng1 = @(z) atan( (speed(endZ6).^2)/(40*g) ) + 0.*z;
G6 = @(t) 1./cos(bankAng1(t));

%G-Force of loop
G7 = @(theta) (speed(z7(theta)).^2)./(g*loopRad) - sin(theta);

% G-Force of drop/turn
bankAng2 = @(z) atan( (speed(z).^2)/(40*g) );
G8 = @(int8) 1./cos(bankAng2(z8(fliplr(int8))));

% G-Force of drop
G9 = @(t) (speed(z9(fliplr(t))).^2)./(g*rad) - sin(fliplr(t));

% G-Force of braking section
G10 = @(t) 1 + 0.*t;



%% Union all of the track elements for plotting

x = [x1(int1),x2(int2),x3(int3),x4(int4),x5(int5),x6(int6),x7(int7),x8(int8),x9(int9)];
y = [y1(int1),y2(int2),y3(int3),y4(int4),y5(int5),y6(int6),y7(int7),y8(int8),y9(int9)];
z = [z1(int1),z2(int2),z3(int3),z4(int4),z5(int5),z6(int6),z7(int7),z8(int8),z9(int9)];

% Union G-Forces for plotting
Gn = [G1(int1) G2(int2) G3(int3) G4(int4) G5(int5) G6(int6) G7(int7) G8(int8) G9(int9) G10(int10)];


%% Calculate length of track
trackLength = calcLength()


%% Plot Track
plotPlots();

