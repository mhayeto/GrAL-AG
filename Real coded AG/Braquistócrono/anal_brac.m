% This function calculates the brachystochrone's curve for (0,y0),(1,yf)
% points.
% Inputs:
% y0: 1st value of y
% yf: last value of y
% Outputs:
% x: x values of the curve
% y: y values of the curve
% t: needed time to travel from (0,y0) to (1,yf)

function [x,y,t]=anal_brac(y0,yf)
    g=9.8;
    yf2=yf+y0;
    theta2=newton(pi/2);
    R=yf2/(1-cos(theta2));
    theta=0:0.01:theta2;
    x=R*(theta-sin(theta));
    y=y0-R*(1-cos(theta));
    t=theta2*sqrt(R/g);
    disp(theta2);
end