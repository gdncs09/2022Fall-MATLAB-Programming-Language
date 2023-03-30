#include "mex.h"
#include "matrix.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mxArray *a_in, *b_in, *c_out;
    const mwSize *dims;
    double *a, *b;
    double *c;
    int a_rows, a_cols, b_rows, b_cols;

    a_in = mxDuplicateArray(prhs[0]);
    b_in = mxDuplicateArray(prhs[1]);
    
    dims = mxGetDimensions(prhs[0]);
    a_rows = (int) dims[0];
    a_cols = (int) dims[1];

    dims = mxGetDimensions(prhs[1]);
    b_rows = (int) dims[0];
    b_cols = (int) dims[1];

    c_out = plhs[0] = mxCreateDoubleMatrix(a_rows, a_cols, mxREAL);

    a = mxGetPr(a_in);
    b = mxGetPr(b_in);
    c = mxGetPr(c_out);
   
    for (int i = 0; i < a_rows;  i++)
        for (int j = 0; j < a_cols; j++)
        {
            for (int q = 0; q < b_rows; q++)    
            {
                //mexPrintf("%lf\n",a[i*a_rows+j]);
                //mexPrintf("%lf\n",b[q*b_rows+0]);
                //mexPrintf("%lf\n",b[q*b_rows+1]);
                if ((int)a[i*a_rows+j] >= (int)b[q*b_rows+0] && (int)a[i*a_rows+j] < (int)b[q*b_rows+1])
                {
                    
                    c[i*a_rows+j] = q;
                    //mexPrintf("[%d %d] %d\n",i,j,q);
                    break;
                }
                else 
                {
                    c[i*a_rows+j] = 0;
                }
                
            }
            //mexPrintf("%d\n",i*a_rows+j);
        }
        
}

