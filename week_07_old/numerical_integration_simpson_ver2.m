% clear, clc
% inputs
delta_x_vect = [0.25 0.1 0.05 0.001];
x_a = 1;
x_b = 3;

% function
func = @(x) exp(x).*sin(x).^2;
% true val
true_val = integral(func, x_a, x_b);

int_result_vect = [];
true_val_vect = [];
err_vect = [];

% calculations
for delta_x = delta_x_vect

    % N = (x_b - x_a)/delta_x + 1;
    x = x_a:delta_x:x_b;
    ind_vect = 1:length(x);
    ind_vect = ind_vect(2:end-1);

    % initialise calculation
    int_result = func(x_a);
    
    for ind = ind_vect
        if mod(ind, 2) == 0
            int_result = int_result + 4*func(x(ind));
        else
            int_result = int_result + 2*func(x(ind));
        end
    end
    
    int_result = int_result + func(x_b);
    int_result = (delta_x/3)*int_result;

    % error
    err = abs(int_result - true_val)*100/true_val;

    % store results
    int_result_vect(end + 1) = int_result;
    true_val_vect(end + 1) = true_val;
    err_vect(end + 1) = err;

end

tab = table( ...
    delta_x_vect', int_result_vect', true_val_vect', err_vect', ...
    'VariableNames', ...
    ["delta x" "simpson" "true value" "rel. error"]...
);

disp(tab)
