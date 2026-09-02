function [x1, x2] = polynomial_roots_function(a, b, c)

    % inputs
    % a = 1;
    % b = 2;
    % c = 3;
    
    discriminant = b^2 - 4*a*c;
    
    if discriminant > 0
        % two real roots
        x1 = (-b + sqrt(discriminant)) / (2*a);
        x2 = (-b - sqrt(discriminant)) / (2*a);
        % fprintf("x1 = %.4f\nx2 = %.4f\n", x1, x2);
    elseif discriminant == 0
        % double real root
        x1 = -b / (2*a);
        x2 = x1; 
        % fprintf("x1 = %.4f\nx2 = %.4f\n", x1, x2);
    else
        % two complex roots
        x1 = (-b + sqrt(discriminant)) / (2*a);
        x2 = (-b - sqrt(discriminant)) / (2*a);
        % fprintf( ...
        %     "x1 = %.4f+%.4fi\nx2 = %.4f+%.4fi\n", ...
        %     real(x1), imag(x1), ...
        %     real(x2), imag(x2) ...
        % );
    end

end

% run in the console:
% x1, x2 = polynomial_roots_function(1,2,3)
% ~, x2 = polynomial_roots_function(1,2,3)
% x1, ~ = polynomial_roots_function(1,2,3)