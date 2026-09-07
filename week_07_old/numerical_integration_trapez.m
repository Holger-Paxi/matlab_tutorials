% clear, clc
% inputs
delta_x = 0.25 % 0.1 0.05 0.001
x_a = 1;
x_b = 3;

% function
func = @(x) exp(x).*sin(x).^2;
% true val
true_val = integral(func, x_a, x_b);

% calculations
% N = (x_b - x_a)/iter_dx + 1;
x = x_a:delta_x:x_b;
x = x(2:end-1);

% initialise calculation
int_result = func(x_a);

for iter = x
    int_result = int_result + 2*func(iter);
end

int_result = int_result + func(x_b);
int_result = (delta_x/2)*int_result;

% error
err = abs(int_result - true_val)*100/true_val;

tab = table(...
    delta_x', int_result', true_val', err', ...
    'VariableNames', ...
    ["delta x" "trapezoidal" "true value" "rel. error"]...
    );

disp(tab)