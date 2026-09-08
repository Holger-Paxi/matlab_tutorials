% inputs
n = 1;
x0 = 1;

% symbolical function
syms x
func = exp(2.*x);

% symbolical evaluation
deriv = diff(func, x);
% derivative function
deriv = matlabFunction(deriv);
% numerical evaluation
true_val = deriv(x0);

% numerical function
func = matlabFunction(func);

% step
h = 10.^-n;

% formulas
forward = (func(x0+h) - func(x0))./h;
backward = (func(x0) - func(x0-h))./h;
central = (func(x0+h) - func(x0-h))./(2.*h);
% errors
err_forw = abs((forward - true_val).*100./true_val);
err_back = abs((backward - true_val).*100./true_val);
err_cent = abs((central - true_val).*100./true_val);

% results
tab = table( ...
    n, h, x0, true_val, ...
    forward, backward, central, ...
    err_forw, err_back, err_cent, ...
    'VariableNames', ...
    [ ...
        "n", "h", "x", "true value", ...
        "forward", "backward", "central", ...
        "error forward", "error backward", "error central" ...
    ] ...
);