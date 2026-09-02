% inputs
% rule + 3 arguments
% arguments = either 2 lengths + 1 angle - for cosine
%                 or 2 angles + 1 length - for sine

%       cos         sin
% arg1  A=1         b_deg=30
% arg2  B=0.5       c_deg=90
% arg3  c_deg=60    B=1

rule = "cos";

arg1 = 1;
arg2 = 0.5;
arg3 = 60;

if rule == "cos"
    A = arg1;
    B = arg2;
    c_deg = arg3;

    C = sqrt(A^2 + B^2 - 2*A*B*cos(c_deg*pi/180));
    fprintf("C = %.3f\n", C);

elseif rule == "sin"
    b_deg = arg1;
    c_deg = arg2;
    B = arg3;

    C = B*sin(c_deg*pi/180)/sin(b_deg*pi/180);
    fprintf("C = %.3f\n", C);

else
    fprintf("wrong inputs\n");

end

% run in the console
% find_length_script