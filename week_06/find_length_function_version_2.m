function C = find_length_function_version_2(rule, arg1, arg2, arg3)

    %       cos         sin
    % arg1  A=1         b_deg=30
    % arg2  B=0.5       c_deg=90
    % arg3  c_deg=60    B=1
    
    % rule = "cos";
    % 
    % arg1 = 1;
    % arg2 = 0.5;
    % arg3 = 60;
    
    if rule == "cos"
        A = arg1;
        B = arg2;
        c_deg = arg3;
    
        C = sqrt(A^2 + B^2 - 2*A*B*cosd(c_deg));
        % fprintf("C = %.3f\n", C);
    
    elseif rule == "sin"
        b_deg = arg1;
        c_deg = arg2;
        B = arg3;
    
        C = B*sind(c_deg)/sind(b_deg);
        % fprintf("C = %.3f\n", C);
    
    else
        fprintf("wrong inputs\n");
    
    end

end

% run in the console:
% C = find_length_function_version_2("cos", 1, 0.5, 60)
% C = find_length_function_version_2("sin", 30, 90, 1)