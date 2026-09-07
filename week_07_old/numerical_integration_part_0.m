% inputs
x_a = 1;
x_b = 3;

fun = @(x) exp(x).*sin(x).^2;

integ = integral(fun, x_a, x_b);

disp(integ)