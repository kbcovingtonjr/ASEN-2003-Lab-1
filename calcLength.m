function [ length ] = calcLength()
% function [] = calcLength()
%
% The purpose of this function is to calculate the length of each
% track element in order to calculate the length of the entire track.
% 
% input:  ----------------------------
%
% output: ----------------------------
%
% Author: 	Keith Covington
%		Ryan Davis
% Created:	01/31/2016
% Modified: 	01/31/2016


%% Pull variables from Main.m
global int1 int2 int3 int4 int5 int6 int7 int8 int9 int10 g endZ2 rad


leng = zeros(1,10);

% arc length 1
arc1 = @(t) sqrt( (sqrt(2)/2*g*t).^2 + (0).^2 + (sqrt(2)/2*g*t).^2 );
leng(1) = integral(arc1, int1(1), int1(end));

% arc length 2
arc2 = @(t) sqrt( (-26*sin(t)).^2 + (0).^2 + (-26*sin(t)).^2 );
leng(2) = integral(arc2, int2(1), int2(end));

% arc length 3
arc3 = @(t) sqrt( (g*(125-endZ2)) + 0 + (sqrt(g*(125-endZ2)) - g.*t).^2 );
leng(3) = integral(arc3, int3(1), int3(end));

% arc length 4
arc4 = @(t) sqrt( (-26*sin(t)).^2 + 0 + (26*cos(t)).^2 );
leng(4) = integral(arc4, int4(1), int4(end));

% arc length 5
arc5 = @(t) sqrt( (1).^2 + (0.*t).^2 + (0).^2 );
leng(5) = integral(arc5, int5(1), int5(end));

% arc length 6
arc6 = @(t) sqrt( (26*cos(t)).^2 + (-26*sin(t)).^2 + (0).^2 );
leng(6) = integral(arc6, int6(1), int6(end));

% arc length 7
arc7 = @(t) sqrt( (0).^2 + (-26*sin(t)).^2 + (26*cos(t)).^2 );
leng(7) = integral(arc7, int7(1), int7(end));

% arc length 8
arc8 = @(t) sqrt( (30*cos(t)).^2 + (-30*sin(t)).^2 + (30*cos(t)).^2 );
leng(8) = integral(arc8, int8(1), int8(end));

% arc length 9
arc9 = @(t) sqrt( (-rad*sin(t)).^2 + (0).^2 + (rad*cos(t)).^2 );
leng(9) = integral(arc9, int9(1), int9(end));

% arc length 10
arc10 = @(t) sqrt( (1).^2 + (0.*t).^2 + (0).^2 );
leng(10) = integral(arc10, int10(1), int10(end));

elementLength = abs(leng); % display length of each track element

% Total arc tack length
length = sum(abs(leng));


