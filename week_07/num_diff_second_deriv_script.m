% inputs
x0 = 0.25;
h = 0.25;

% function
syms x
func = cos(pi.*x);

% independent variable
ind_var = symvar(func);

% derivatives
first_deriv = diff(func, ind_var);
second_deriv = diff(first_deriv, ind_var);

% derivative function
sec_der_function = matlabFunction(second_deriv, "Vars", ind_var);

% evaluate true value
true_value = sec_der_function(x0);

% redefine function
func = matlabFunction(func, "Vars", ind_var);

% numerical derivation
num_derv = (func(x0 - h) - 2.*func(x0) + func(x0 + h))/(h.^2);

% relative error
err_derv = abs((num_derv - true_value).*100./true_value);

% results
tab = table(x0, h, true_value, num_derv, err_derv);

disp(tab);