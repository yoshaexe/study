#include <iostream>
#include <cstdlib> 
#include <ctime> 
using namespace std;

int main()
{
    generate_matrix(4, 4);
}

int generate_matrix(int rows, int columns)
{
    int array[rows][columns];

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < columns; j++)
        {
            array[i][j] = (rand()%6)+1;
            cout << array[i][j] << "\n";
        }
    }

}