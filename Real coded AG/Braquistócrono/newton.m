% Newton-Rapson method to calculate the final angle of the cycloid that
% constitute the  brachystochrone's curve for (0,y0),(1,yf) points.
% Inputs: 
% y0: value of the angle for the approximation of NR method
% yf: value of the angle calculated by NR

function y=newton(y0)
	while 1
        f=1-(1-cos(y0))/(y0-sin(y0));
		fp=((1-cos(y0))^2-sin(y0)*(y0-sin(y0)))/(y0-sin(y0))^2;
        y=y0-f/fp;
		if y-y0<0.001
			break;
		else
			y0=y;
		end
	end
end