function tab = diff_step_size_function(n, x0, func)
    
    % independent variable
    ind_var = symvar(func);
    
    % symbolical evaluation
    deriv = diff(func, ind_var);
    % derivative function
    deriv = matlabFunction(deriv, "Vars", ind_var);
    % numerical evaluation
    true_val = deriv(x0);
    
    % numerical function
    func = matlabFunction(func, "Vars", ind_var);
    
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

end