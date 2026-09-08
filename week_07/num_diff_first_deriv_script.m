% inputs
x0 = 0;
h = 0.25;

% function
syms x;
a = 3; b = -5; c = 5; d = 3; e = 2;
func = a.*x.^4 + b.*x.^3 + c.*x^2 + d.*x + e;

% independent variable
ind_var = symvar(func);

% first derivative
first_deriv = diff(func, ind_var);

% derivative function
first_der_function = matlabFunction(first_deriv, 'Vars', ind_var);

% evaluate true value of first derivative
true_value = first_der_function(x0);

% redefine function
func = matlabFunction(func, 'Vars', ind_var);

% numerical derivation
forward = (func(x0 + h) - func(x0))./h;
backward = (func(x0) - func(x0 - h))./h;
central = (func(x0 + h) - func(x0 - h))./(2.*h);

% relative error
forw_rel_err = abs((forward - true_value).*100./true_value);
back_rel_err = abs((backward - true_value).*100./true_value);
cent_rel_err = abs((central - true_value).*100./true_value);

% results
res = table( ...
    x0, h, true_value, forward, backward, central, ...
    forw_rel_err, back_rel_err, cent_rel_err, ...
    'VariableNames', ...
    [ ...
        "x value", "step - ""h""", "true f'(x)", ...
        "f'(x) forward", "f'(x) backward", "f'(x) central", ...
        "error forward", "error backward", "error central" ...
    ] ...
);

disp(res);