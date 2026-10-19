import sympy as sp
import newton_raphson_function as nrf

def main(*args):

    # calculations; first way
    all_results = nrf.newton_raphson_function(*args)
    print(*all_results, sep="\n")

    # second way
    p, iter, results, func_sym, dfunc_sym, msg = \
        nrf.newton_raphson_function(*args)
    print(p, iter, results, func_sym, dfunc_sym, msg, sep="\n")

if __name__ == "__main__":

    # inputs
    p0 = 1
    tol = 1e-5
    max_iter = 100
    func = lambda x: x**2 - 4*x + 4 - sp.log(x)

    # run the main function
    main(p0, tol, max_iter, func)
