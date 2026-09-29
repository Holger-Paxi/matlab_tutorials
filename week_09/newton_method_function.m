function [p, iter, results] = newton_method_function(...
        p0, tol, max_iter, func ...
    )
    %% 
    % symbolic derivatives
    
    syms x
    func_sym = func(x);
    dfunc_sym = diff(func_sym, x);
    %% 
    % derivative function
    
    dfunc = matlabFunction(dfunc_sym, "Vars", x);
    %%
    % step 1
    iter = 1;
    
    results = table();

    % step 2
    while iter <= max_iter
        % step 3
        f_p0 = func(p0);
        df_p0 = dfunc(p0);
        p = p0 - f_p0./df_p0;
    
        f_p = func(p);  % not necessary
        results(end+1,:) = table( ...
            iter, p0, p, f_p0, df_p0, f_p ...
        );
    
        % step 4
        if abs(p - p0) < tol
            return
        end
    
        % step 5
        iter = iter + 1;
    
        % step 6
        p0 = p;
    
    end
    
    error("the method failed after %d iteration", max_iter)

end