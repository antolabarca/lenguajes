#include <iostream>
using namespace std;


long naive_f (long n)
{
    if (n == 0)
    {
        return 0;
    }
    else
    {
        short c = (n % 2 == 0) ? 1 : -1;
        return naive_f(n - 1) + c * n;
    }
}

// PARTE a)
// ¿Qué valor observó que “agota” la pila?
// al menos en el caso de mi computador, con n=174603 se alcanza a obtener un resultado (-87302) y con n=174604 se "agota" la pila,
// es decir, se genera un segfault.
// (lo hice como una especie de busqueda binaria, probando un valor gigante cualquiera al principio como limite superior)



// PARTE b)

long f_aux(long n, long ac)
{
    if (n==0)
    {
        return ac;
    }
    else
    {
        short c = (n%2 == 0)? 1 : -1;
        return f_aux(n-1, ac + n*c);
    }
    return 0;   
}


long smart_f (long n)
{
    return f_aux(n, 0);
}


int main ()
{
    while (1)
    {
        long number, res;
        cout << "Please enter a natural number: ";
        cin >> number;
        // res = naive_f(number);
        res = smart_f(number);
        cout << "Its image through f is: " << res << ".\n";
        return 0;
    }
}