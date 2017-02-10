function [] = plotPlots()
% function [] = plotPlots()
%
% The purpose of this function is to create plots, e.g. the G-Forces,
% speed vs. track length, bank angle plots, and the track itself.
% 
% input:  ----------------------------
%
% output: ----------------------------
%
% Authors: 	Keith Covington
%		Ryan Davis
% Created:	01/31/2016
% Modified: 	01/31/2016


%% Pull variables from Main.m
global int1 int2 int3 int4 int5 int6 int7 int8 int9 int10 x y z...
	x10 y10 z10 g Gn speed aBrake brakeSpeed bankAng1...
       	bankAng2 trackLength


%% Plot Track

% Min and max speeds
minSpeed = speed(125);
maxSpeed = speed(0);

% Create figure with appropriate axes, orientation, and accessories
figure
hold on
grid on
axis equal
c = colorbar;
caxis([minSpeed, maxSpeed]);
c.Label.String = 'Speed [m/s]';
view(145,15);
colormap('jet');

% Label plot
title('Roller Coaster');
xlabel('x');
ylabel('y');
zlabel('z');

% Plot the track
scatter3(x,y,z,1,speed(z))
scatter3(x10(int10),y10(int10),z10(int10),1,brakeSpeed(fliplr(int10)));


%% Plot Speed vs. Track Length
numInt = length([int1 int2 int3 int4 int5 int6 int7 int8 int9 int10]);
figure
s = linspace(0,trackLength,numInt);
plot(s,[speed(z) fliplr(brakeSpeed(int10))])
line([s(length(int1)) s(length(int1))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2])) s(length([int1 int2]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3])) s(length([int1 int2 int3]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4])) s(length([int1 int2 int3 int4]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5])) s(length([int1 int2 int3 int4 int5]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6])) s(length([int1 int2 int3 int4 int5 int6]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7])) s(length([int1 int2 int3 int4 int5 int6 int7]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7 int8])) s(length([int1 int2 int3 int4 int5 int6 int7 int8]))], [0 50],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7 int8 int9])) s(length([int1 int2 int3 int4 int5 int6 int7 int8 int9]))], [0 50],'Color','g','LineStyle','--');

% Label plot
title('Speed vs. Track Length');
xlabel('Position Along Track [m]');
ylabel('Speed of Coaster [m/s]');
legend('Speed', 'Division Between Track Sections');


%% Plot G's in the normal direction (through riders' seats)
Gtan10 = @(t) aBrake/g + 0.*t;
Gtan = [zeros(1,numInt-length(int10)) Gtan10(int10)];
Glat = zeros(1,numInt);
figure
hold on

% Plot G-Force graphs
plot(s,Glat,'--')
plot(s,Gtan,':')
plot(s,Gn)
line([s(length(int1)) s(length(int1))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2])) s(length([int1 int2]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3])) s(length([int1 int2 int3]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4])) s(length([int1 int2 int3 int4]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5])) s(length([int1 int2 int3 int4 int5]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6])) s(length([int1 int2 int3 int4 int5 int6]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7])) s(length([int1 int2 int3 int4 int5 int6 int7]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7 int8])) s(length([int1 int2 int3 int4 int5 int6 int7 int8]))], [-1 6],'Color','g','LineStyle','--');
line([s(length([int1 int2 int3 int4 int5 int6 int7 int8 int9])) s(length([int1 int2 int3 int4 int5 int6 int7 int8 int9]))], [-1 6],'Color','g','LineStyle','--');

% Label plot
title('G-Forces Experienced by Riders');
xlabel('Position Along Track [m]');
ylabel('Gs Experienced (dimensionless)');
legend('Gs Experienced Laterally (Side to Side)', 'Gs Experienced Forward/Backward', 'Gs Experienced "Through the Seat"', 'Division Between Track Sections');


%% Bank angle plots
figure

% 1st bank angle plot
subplot(1,2,1)
plot(int6 - pi/2, bankAng1(int6)*180/pi)
title('Bank Angle on 1st Perfectly Banked Turn');
xlabel('Position Along Track Element [m]');
ylabel('Bank Angle (degrees)');

% 2nd bank angle plot
subplot(1,2,2)
plot(int8, bankAng2(int8)*180/pi)
title('Bank Angle on 2nd Perfectly Banked Turn');
xlabel('Position Along Track Element [m]');
ylabel('Bank Angle (degrees)');

