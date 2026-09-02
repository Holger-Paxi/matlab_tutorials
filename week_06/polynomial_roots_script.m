% clear, clc

% inputs
a = 1;
b = 2;
c = 3;

discriminant = b^2 - 4*a*c;

if discriminant > 0
    % two real roots
    x1 = (-b + sqrt(discriminant)) / (2*a);
    x2 = (-b - sqrt(discriminant)) / (2*a);
    fprintf("x1 = %.4f\nx2 = %.4f\n", x1, x2);
elseif discriminant == 0
    % double real root
    x1 = -b / (2*a);
    x2 = x1; 
    fprintf("x1 = %.4f\nx2 = %.4f\n", x1, x2);
else
    % two complex roots
    x1 = (-b + sqrt(discriminant)) / (2*a);
    x2 = (-b - sqrt(discriminant)) / (2*a);
    fprintf( ...
        "x1 = %.4f+%.4fi\nx2 = %.4f+%.4fi\n", ...
        real(x1), imag(x1), ...
        real(x2), imag(x2) ...
    );
end

% run in the console:
% polynomial_roots_script