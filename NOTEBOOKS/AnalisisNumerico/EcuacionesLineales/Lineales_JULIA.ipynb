{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "74445927",
   "metadata": {},
   "source": [
    "Usarememos LinearAlgebra"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "0ba1ac3d",
   "metadata": {},
   "outputs": [],
   "source": [
    "#using Pkg\n",
    "#Pkg.add(\"LinearAlgebra\")\n",
    "using LinearAlgebra"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "e6450959",
   "metadata": {},
   "outputs": [],
   "source": [
    "#using Pkg\n",
    "#Pkg.add(\"SpecialMatrices\")\n",
    "using SpecialMatrices"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0923ac37",
   "metadata": {},
   "source": [
    "### Normas \n",
    "Los comandos para calcular normas de vectores y de matrices son presentados a continuación. \n",
    "En Julia se distingen las normas subordinadas como normas de operadores. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "f2c8dc8e",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1, 2, 3, -4]\n",
      "La norma 1 de x es 10.0\n",
      "La norma 6 de x es 4.119882308593889\n",
      "La norma 11 de x es 4.015242126566954\n",
      "\n",
      "La norma Inf de x es 4.0\n"
     ]
    }
   ],
   "source": [
    "x=[1,2,3,-4]\n",
    "println(x)\n",
    "nx=norm(x,1)\n",
    "for i=1:5:15\n",
    "    nx=norm(x,i)\n",
    "    println(\"La norma \",i,\" de x es \",nx)\n",
    "end\n",
    "nx=norm(x,Inf)\n",
    "println(\"\\nLa norma \",Inf,\" de x es \",nx)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "9ae27f82",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[0 0 1; -1 2 0; 1 2 1]\n",
      "La norma  2 de la matrix extendida a vector  es = 3.4641016151377544\n",
      "La norma de Frobenious es = 3.4641016151377544\n",
      "La norma subordinada 1 es = 4.0\n",
      "La norma subordinada Inf es = 4.0\n"
     ]
    }
   ],
   "source": [
    "A=[0 0 1; -1  2  0; 1 2  1]\n",
    "println(A)\n",
    "println(\"La norma  2 de la matrix extendida a vector  es = \", norm(A)) #máximo valor singular\n",
    "println(\"La norma de Frobenious es = \",norm(A,2)) # Frobeniusln\n",
    "println(\"La norma subordinada 1 es = \",opnorm(A,1))\n",
    "println(\"La norma subordinada Inf es = \", opnorm(A,Inf))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fc663fa7",
   "metadata": {},
   "source": [
    "### Factorización $A=PLU$ y Cholesky\n",
    "Presentamos algunos comandos relacionados con la solución de sistemas lineales por métodos directos. \n",
    "Calculemos la factorización $A=PLU$ de una matriz $4\\times 4$."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "eb07d929",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Int64}:\n",
       " 2  5  8  7\n",
       " 5  2  2  8\n",
       " 7  5  6  6\n",
       " 5  4  4  8"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A =[2  5  8  7 ; 5  2  2  8 ; 7  5  6  6; 5 4 4 8]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "e836d721",
   "metadata": {},
   "outputs": [],
   "source": [
    "luA= lu(A);"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "28c2794b",
   "metadata": {},
   "source": [
    "Las matrices $L$, $U$ y $P$ pueden ser desplegadas como sigue, "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "daef18d9",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Float64}:\n",
       " 7.0  5.0       6.0      6.0\n",
       " 0.0  3.57143   6.28571  5.28571\n",
       " 0.0  0.0      -1.04     3.08\n",
       " 0.0  0.0       0.0      7.46154"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Float64}:\n",
       " 1.0        0.0    0.0       0.0\n",
       " 0.285714   1.0    0.0       0.0\n",
       " 0.714286   0.12   1.0       0.0\n",
       " 0.714286  -0.44  -0.461538  1.0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Float64}:\n",
       " 0.0  0.0  1.0  0.0\n",
       " 1.0  0.0  0.0  0.0\n",
       " 0.0  0.0  0.0  1.0\n",
       " 0.0  1.0  0.0  0.0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "display(luA.U)\n",
    "display(luA.L)\n",
    "display(luA.P)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a39e5e0c",
   "metadata": {},
   "source": [
    "Podemos calcular la norma del residuo de la factorización: $ ||| PA-LU|||$,"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "30f0a106",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "1.2560739669470201e-15"
      ]
     },
     "execution_count": 7,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "opnorm(luA.P*A-luA.L*luA.U)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a7c9a34e",
   "metadata": {},
   "source": [
    "Con el paquete SpecialMatrices podemos generar la matriz de Hilbert."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c3fc8b76",
   "metadata": {},
   "source": [
    "Ahora calculemos la factorización para la matriz de Hilbert y el respectivo residuo."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "2684dbce",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "5×5 Hilbert{Rational{Int64}}:\n",
       " 1//1  1//2  1//3  1//4  1//5\n",
       " 1//2  1//3  1//4  1//5  1//6\n",
       " 1//3  1//4  1//5  1//6  1//7\n",
       " 1//4  1//5  1//6  1//7  1//8\n",
       " 1//5  1//6  1//7  1//8  1//9"
      ]
     },
     "execution_count": 8,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "H=Hilbert{Rational{Int64}}(5,5)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "d3f978d2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "5×5 Hilbert{Float64}:\n",
       " 1.0       0.5       0.333333  0.25      0.2\n",
       " 0.5       0.333333  0.25      0.2       0.166667\n",
       " 0.333333  0.25      0.2       0.166667  0.142857\n",
       " 0.25      0.2       0.166667  0.142857  0.125\n",
       " 0.2       0.166667  0.142857  0.125     0.111111"
      ]
     },
     "execution_count": 9,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "H=Hilbert{Float64}(5,5)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "b0d94c75",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "La norma Inf del residuo es 1.3183898417423734e-16\n",
      "La norma 2 del residuo es 5.0105092629290024e-17\n"
     ]
    }
   ],
   "source": [
    "H=Hilbert{Float64}(50,50)\n",
    "luH= lu(H)\n",
    "res=luH.P*H-luH.L*luH.U\n",
    "#println(\"pA-LU=\",res)\n",
    "println(\"La norma Inf del residuo es \",opnorm(res,Inf))\n",
    "println(\"La norma 2 del residuo es \", opnorm(res,2))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "05a93330",
   "metadata": {},
   "source": [
    "Calculemos la permutación de la factorización $A=PLU$ para una matriz diagonal dominante."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "08ae4d3a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Int64}:\n",
       "  5  -1  2  -1\n",
       " -1   5  0   1\n",
       "  0  -1  4   2\n",
       "  1   1  1   5"
      ]
     },
     "execution_count": 12,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A =[5 -1 2 -1; -1 5 0 1; 0 -1 4 2; 1 1 1 5]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "0c4912af",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "LU{Float64, Matrix{Float64}}\n",
       "L factor:\n",
       "4×4 Matrix{Float64}:\n",
       "  1.0   0.0       0.0       0.0\n",
       " -0.2   1.0       0.0       0.0\n",
       "  0.0  -0.208333  1.0       0.0\n",
       "  0.2   0.25      0.122449  1.0\n",
       "U factor:\n",
       "4×4 Matrix{Float64}:\n",
       " 5.0  -1.0  2.0      -1.0\n",
       " 0.0   4.8  0.4       0.8\n",
       " 0.0   0.0  4.08333   2.16667\n",
       " 0.0   0.0  0.0       4.73469"
      ]
     },
     "execution_count": 14,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "luA=lu(A)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "5a68454e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Float64}:\n",
       " 1.0  0.0  0.0  0.0\n",
       " 0.0  1.0  0.0  0.0\n",
       " 0.0  0.0  1.0  0.0\n",
       " 0.0  0.0  0.0  1.0"
      ]
     },
     "execution_count": 15,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "luA.P"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5f0f9e59",
   "metadata": {},
   "source": [
    "Observe que eneste caso la matriz de permutación es la matriz identidad. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "55609adb",
   "metadata": {},
   "source": [
    "Calculemos ahora la factorización de Cholesky de una matri de la forma $A^TA$ con $A$ aleatoria. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "aa971385",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 Matrix{Float64}:\n",
       " 10.092    5.29224   5.91063  7.08298\n",
       "  5.29224  9.37529   6.6888   3.15639\n",
       "  5.91063  6.6888   12.9585   4.06197\n",
       "  7.08298  3.15639   4.06197  5.95102"
      ]
     },
     "execution_count": 20,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "B=1.0.+randn(4,4)\n",
    "A=B'B"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "d4d3ad8d",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "4×4 LowerTriangular{Float64, Matrix{Float64}}:\n",
       " 3.17679    ⋅         ⋅          ⋅ \n",
       " 1.66591   2.56905    ⋅          ⋅ \n",
       " 1.86056   1.39712   2.74679     ⋅ \n",
       " 2.2296   -0.217167  0.0790246  0.962547"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "4×4 UpperTriangular{Float64, Matrix{Float64}}:\n",
       " 3.17679  1.66591  1.86056   2.2296\n",
       "  ⋅       2.56905  1.39712  -0.217167\n",
       "  ⋅        ⋅       2.74679   0.0790246\n",
       "  ⋅        ⋅        ⋅        0.962547"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "cholA=cholesky(A)\n",
    "display(cholA.L)\n",
    "display(cholA.U)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "cf5949a5",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "Cholesky{Float64, Matrix{Float64}}"
      ]
     },
     "execution_count": 28,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "typeof(cholA)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "aacef1d4",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "LowerTriangular{Float64, Matrix{Float64}}"
      ]
     },
     "execution_count": 30,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "typeof(cholA.L)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ccc1ce01",
   "metadata": {},
   "source": [
    "### Sistemas lineales"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "82120a9a",
   "metadata": {},
   "source": [
    "Resolver un sistema lineal general usando \"backslash\" (notación de MatLab), "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "id": "45859522",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "3-element Vector{Float64}:\n",
       "  2.0\n",
       " -2.0\n",
       "  9.0"
      ]
     },
     "execution_count": 41,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A =[3  2  0 ; 1 -1 0; 0 5 1]\n",
    "b = [2; 4; -1]\n",
    "x=A\\b"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "35955fdd",
   "metadata": {},
   "source": [
    "Podemos calcular el vector residuo y su norma, "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "id": "f82e9475",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "res=0.0\n"
     ]
    }
   ],
   "source": [
    "res=b-A*x\n",
    "println(\"res=\",norm(res))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "adda5a54",
   "metadata": {},
   "source": [
    "Intentemos ahora con la matriz de Hilbert."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "id": "087dd928",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "La norma del residuo es 5.3513579568049484e-8\n"
     ]
    }
   ],
   "source": [
    "n=25\n",
    "H=Hilbert{Float64}(n,n)\n",
    "b=fill(1,n,1)\n",
    "x=H\\b\n",
    "res=b-H*x\n",
    "println(\"La norma del residuo es \",norm(res))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f78b7354",
   "metadata": {},
   "source": [
    "Recuerden que debemos mirar el número de de cóndición de la matriz, el comando *cond(H,p)* aproxima la condición de la matriz con $p=1,2,\\infty$"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 55,
   "id": "f4fad11a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "5.104244624590389e20"
      ]
     },
     "execution_count": 55,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "cond(H,Inf)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "129aab3d",
   "metadata": {},
   "source": [
    "## Iteraciones"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 59,
   "id": "c50fb223",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "2×2 Matrix{Float64}:\n",
       " 0.142475  0.949037\n",
       " 0.371734  0.00402607"
      ]
     },
     "execution_count": 59,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A=rand(2,2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 65,
   "id": "6e4e38f2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "2×2 Diagonal{Float64, Vector{Float64}}:\n",
       " 0.142475   ⋅ \n",
       "  ⋅        0.00402607"
      ]
     },
     "execution_count": 65,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "Diagonal(diag(A))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 68,
   "id": "1318653e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "jacobisolver (generic function with 1 method)"
      ]
     },
     "execution_count": 68,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function jacobisolver(A,b,tol,Maxiter,x)\n",
    "    D=Diagonal(diag(A))\n",
    "    for i=1:Maxiter\n",
    "        r=b-A*x\n",
    "        nr=norm(r)\n",
    "        println(\"norm(r(\",i,\"))=\",nr)\n",
    "        if nr<tol\n",
    "            break\n",
    "        end\n",
    "        delta=D\\r\n",
    "        x = x+delta\n",
    "\n",
    "    end\n",
    "    return x\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 71,
   "id": "1b04db82",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "norm(r(1))=8.06225774829855\n",
      "norm(r(2))=20.000510197574094\n",
      "norm(r(3))=2.8793777672494825\n",
      "norm(r(4))=7.143039356276458\n",
      "norm(r(5))=1.0283492025890995\n",
      "norm(r(6))=2.5510854843844424\n",
      "norm(r(7))=0.36726757235324725\n",
      "norm(r(8))=0.9111019587087231\n",
      "norm(r(9))=0.13116699012615812\n",
      "norm(r(10))=0.32539355668168024\n",
      "norm(r(11))=0.04684535361648392\n",
      "norm(r(12))=0.1162119845291715\n",
      "norm(r(13))=0.016730483434458102\n",
      "norm(r(14))=0.041504280188990335\n",
      "norm(r(15))=0.005975172655162978\n",
      "norm(r(16))=0.014822957210348608\n",
      "norm(r(17))=0.002133990233986526\n",
      "norm(r(18))=0.0052939132894127576\n",
      "norm(r(19))=0.0007621393692816576\n",
      "norm(r(20))=0.0018906833176474099\n",
      "norm(r(21))=0.00027219263188473246\n",
      "norm(r(22))=0.0006752440420128702\n",
      "norm(r(23))=9.721165424278468e-5\n",
      "norm(r(24))=0.00024115858643062216\n",
      "norm(r(25))=3.471844794275002e-5\n",
      "norm(r(26))=8.61280665757637e-5\n",
      "norm(r(27))=1.2399445693902245e-5\n",
      "norm(r(28))=3.076002378111679e-5\n",
      "norm(r(29))=4.428373463115167e-6\n",
      "norm(r(30))=1.0985722780500993e-5\n",
      "norm(r(31))=1.5815619521197824e-6\n",
      "norm(r(32))=3.923472424661665e-6\n",
      "norm(r(33))=5.648435543914452e-7\n",
      "norm(r(34))=1.4012401521615228e-6\n",
      "norm(r(35))=2.017298393432536e-7\n",
      "norm(r(36))=5.004429165614339e-7\n",
      "norm(r(37))=7.204637220124179e-8\n",
      "norm(r(38))=1.7872961178795473e-7\n",
      "norm(r(39))=2.573084708882649e-8\n",
      "norm(r(40))=6.38320057270989e-8\n",
      "norm(r(41))=9.18958937913539e-9\n",
      "norm(r(42))=2.279714084964495e-8\n",
      "norm(r(43))=3.2819952625656306e-9\n",
      "norm(r(44))=8.141833731182386e-9\n",
      "norm(r(45))=1.1721403468342495e-9\n",
      "norm(r(46))=2.907799789394335e-9\n",
      "norm(r(47))=4.186233780395606e-10\n",
      "norm(r(48))=1.0384989133737326e-9\n",
      "norm(r(49))=1.495070902726393e-10\n",
      "norm(r(50))=3.708914612789493e-10\n",
      "norm(r(51))=5.3395641191383255e-11\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "2-element Vector{Float64}:\n",
       "  7.111111111070637\n",
       " -3.2222222221942585"
      ]
     },
     "execution_count": 71,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A =[2.0 1.0; 5.0 7.0]\n",
    "b = [11.0;13.0]\n",
    "x0 =[1.0 ; 1.0]\n",
    "\n",
    "x = jacobisolver(A,b,1e-10,100,x0)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 72,
   "id": "6bcbd2c0",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "2-element Vector{Float64}:\n",
       " 5.298339544879127e-11\n",
       " 6.622258297284134e-12"
      ]
     },
     "execution_count": 72,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "res=b-A*x"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "58c0d61d",
   "metadata": {},
   "source": [
    "## Sparse"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0c7532a6",
   "metadata": {},
   "source": [
    "Consideremos un ejemplo de una matriz dispersa en https://suitesparse-collection-website.herokuapp.com/. En particular la matriz correspondiente a: *HB/1138_bus\n",
    "S ADMITTANCE MATRIX 1138 BUS POWER SYSTEM, D.J.TYLAVSKY, JULY 1985.*\n",
    "\n",
    "Usaremos los siguientes paquetes, "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "8a08ab1f",
   "metadata": {},
   "outputs": [],
   "source": [
    "#using Pkg\n",
    "#Pkg.add(\"MAT\")\n",
    "using MAT\n",
    "#Pkg.add(\"HTTP\")\n",
    "using HTTP\n",
    "#Pkg.add(\"SparseArrays\")\n",
    "using SparseArrays"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "77bc40f3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\"https://suitesparse-collection-website.herokuapp.com/mat/HB/494_bus.mat\""
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "url = \"https://suitesparse-collection-website.herokuapp.com/mat/HB/494_bus.mat\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "da095324",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "HTTP.Messages.Response:\n",
       "\"\"\"\n",
       "HTTP/1.1 200 OK\r\n",
       "x-amz-id-2: Us+gRyA1BdvIl5KmMCmWMVeVVed2ItN29ZS5NA+fsxHY0uNY6wKI5t89irQdByU03VYqhH4sxuA=\r\n",
       "x-amz-request-id: HAD3HQMNQ02K450X\r\n",
       "Date: Fri, 07 Oct 2022 14:45:41 GMT\r\n",
       "Last-Modified: Fri, 01 May 2020 20:44:28 GMT\r\n",
       "ETag: \"233b536e247ffe071bea02e270ccaf1e\"\r\n",
       "Content-Type: binary/octet-stream\r\n",
       "Server: AmazonS3\r\n",
       "Content-Length: 12824\r\n",
       "\r\n",
       "\n",
       "⋮\n",
       "12824-byte body\n",
       "\"\"\""
      ]
     },
     "execution_count": 5,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "r = HTTP.request(\"GET\", url)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "f114184a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\"MATLAB 5.0 MAT-file, Platform: GLNXA64, Created on: Sat Sep  6 04:04:21 2008                                                \\0\\x01IM\\x0f\\0\\0\\0\\x901\\0\\0x\\x9cl\\x99\\t\\x98\\xcf\\xd5\\x1a\\xc7ϙ\\\"˵\\x94+*\\xcb\\xdf\\x12e\\xcb\\xd6X\\x8a\\xcc0\\xf6a\\x98\\xb1\\x8c\\x16\\xfb\\x96]C\\b\\xe5RHȒ\\ne\\xab\\xe4ڗH\\\\K\\x91\\xb1\\x14\\xb2\\x8cܚ\\xac\\xc9ruo\\xe5\\xb6\\\\\\xe9~\\xbf\\xde\\xf7}~\\xe7z\\xee<\\xcf\\xe79\\xeb\\xef\\xf7;\\xffs\\xde\\xf5L~\\xe7\\\\fG\\xe7r\\xa2\\xcc\\x05\\xe2\\x9c\\xfc\\xe5ж\\x0f\\xb8\\x03\\xa4\\f\\x1dԭ\\x7f\\xcf\\x01\\x18\\xbf\\xfdf\\x9b\\xfd\\xb5AFߌ\\xfe=\\x9dK\\x90\\xa7\\av\\x1d\\x80\\x86\\xeb\\xdb\\xe3f\" ⋯ 12264 bytes ⋯ \"\\x03\\xf1C\\xec\\xdasһKG\\x04\\xa4\\xb1\\xda\\xdc\\x1eT\\x9a \\x850\\xf6,{\\xc69\\x1a~\\xdcs\\x04\\xd9\\x18\\x1c\\xc6\\xc9\\xe8'\\x1cPI\\xf2\\xa2T^\\x88\\x03f\\x9d\\xab\\x94\\xd15d\\x01\\x99\\xa7\\xdd'\\x1f\\xe8\\x18\\xb5\\x1a!\\x91'|\\xd9ݡ\\xb3\\xba\\x9cb`\\xbf\\x96\\x9d\\xdc[>WZ\\x8eB\\x9aO!\\x90w<\\xe2O\\x84\\xd3\\xee=x\\x15L\\xf3\\x89\\x7f\\xb3\\xcfm\\xd1ug\\x83At\\xecy\\x8d\\xf3\\xe3\\xe3\\xfc&s~\\xbc\\xe3\\t\\x9c\\xeb'\\x8a\\xe6\\xe6\\xfc\\x04)\\x1c\\xfb\\x13\\xa3h'[]\\xa3\\xd9Fa\\x91\\x99\\xe9\\xe3\\xfc1;z\\xffe\\x87\\xefo\\xecp\\xff\\x97\\x1d\\x1e\\xce\\x7f<\\x7f\\xa3\\xf7w\\xfey\\xff䟗K\\x7f\\xb6\\x99\\xf1\\xff&n\\xa1\\tq\\x8f\\xd1su\\x98>\\xd9\\t\\x11\\x8b\\xd2\\x17f\\xd3q\\xb3\\xfe\\xc1\\x8e\\xdc\\x04;c\\xb4\\xb3\\x0esn\\xe6\\xfc\\xf9ZL\\xb6\\x0e\\xd31-.1&]\\x8b\\xe9\\xa2\\xc3t\\x8bɊK'v\\x9d\\xfe\\xc1\\xae\\xe4\\x04\\xbbctJrVL\\x1a3)&#+9m!3%-92!&\\x91\\xc3\\xff7Lׄ\\x01\""
      ]
     },
     "execution_count": 6,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "Body=String(r.body)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "995a2c24",
   "metadata": {},
   "source": [
    "Ahora escribimos en un archivo, "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "9191f316",
   "metadata": {},
   "outputs": [],
   "source": [
    "io = open(\"out.mat\", \"w\")\n",
    "write(io,Body)\n",
    "close(io);"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4643ca01",
   "metadata": {},
   "source": [
    "Y usamos el paquete MAT para leer el archivo .mat"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "27762948",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "Dict{String, Any} with 1 entry:\n",
       "  \"Problem\" => Dict{String, Any}(\"name\"=>\"HB/494_bus\", \"A\"=>sparse([1, 16, 46, …"
      ]
     },
     "execution_count": 9,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "#file = matopen(\"out.mat\")\n",
    "vars = matread(\"out.mat\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "00046c87",
   "metadata": {},
   "source": [
    "Note que la variable del archivo .mat es un dicctionary. Para recuperar la matriz usamos las claves apropiadas del diccionario vars"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "7436e995",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "494×494 SparseArrays.SparseMatrixCSC{Float64, Int64} with 1666 stored entries:\n",
       "⢟⣵⡀⠈⠡⠀⠀⠀⠀⠊⠀⡀⠊⠂⠀⠁⠐⠀⠀⠀⠀⠈⢂⠀⠀⠀⢀⠀⠀⠐⠀⠀⠀⠔⠚⠄⠀⠀⠀⠀\n",
       "⡀⠈⠑⣤⠀⠀⠈⠀⡁⠀⠀⠡⡈⢈⡑⠊⡀⠐⠀⠂⡀⡄⠠⡀⠈⠁⡄⠀⠀⠀⠂⠀⠄⠤⠁⠐⠀⠀⠀⠀\n",
       "⠁⠂⠀⠀⠑⢄⡘⡄⠀⠁⠂⢀⠀⠁⠀⠄⠈⡀⠂⠁⠀⠘⠈⠀⠈⣁⠨⠐⡀⠂⠂⠨⠈⠠⠄⡌⠈⡀⠀⠀\n",
       "⠀⠀⠂⠀⠒⠬⠻⣦⠀⠂⠁⠐⠀⠀⠂⠁⠀⠁⠀⠄⠂⠁⠂⠂⠀⠀⡄⠀⠐⠠⠀⡖⠀⢈⠂⠂⠐⠀⠀⠀\n",
       "⡠⠀⠁⠈⠄⠀⠠⠀⠱⣦⡄⠀⠉⠀⠡⡂⠀⠈⠉⠐⠐⡆⠀⢅⠌⠀⠐⢄⠠⠀⠔⠁⠀⠠⢈⠀⠀⠀⠀⠀\n",
       "⠀⠠⠄⡀⠈⢀⢁⠀⠀⠉⢻⣶⠀⠀⢈⠀⠄⠀⠁⢀⠀⠁⠀⠀⠀⠀⠀⡄⠀⠀⠀⠁⠀⠀⠀⠁⠀⠀⡀⡀\n",
       "⠪⠀⡂⢈⠄⠀⠀⠀⠃⠀⠀⠀⠛⣤⠐⠀⠁⠈⠠⠢⠂⠀⠀⠀⠀⠀⡀⢄⠠⠐⠀⠚⡂⠤⠌⠈⠀⠠⠀⠀\n",
       "⠄⠀⡱⠈⠀⠄⠌⠀⠡⠢⠂⠐⠐⠀⠑⣤⠅⠄⠑⠀⠂⠀⠀⠁⠀⠀⠀⠁⠀⠀⠤⠀⠄⠠⠀⠀⠀⡁⠀⠀\n",
       "⠐⠀⢀⠈⠂⠠⠄⠀⡀⠀⠀⠁⡁⠀⠁⠅⠱⣦⢀⡈⠀⢀⡚⡈⠀⠀⠀⠀⠐⢑⠀⠄⠀⠀⢀⡤⡠⡄⠀⠀\n",
       "⠀⠀⠠⠀⠌⠀⠀⠄⢃⠀⠁⢀⠠⡂⠑⠀⡀⠰⠑⢄⢀⠀⠈⠠⣤⠢⢠⠈⠀⠀⠁⠂⠍⠨⢀⠂⠈⠀⢂⠀\n",
       "⡀⠀⠀⠬⣀⠀⠌⠀⠰⠤⠄⠀⠈⠀⠈⠀⠀⢀⠀⠐⠻⢆⡀⠀⠀⡀⠀⠆⠀⢁⡄⠂⢂⢀⠒⠠⠀⠐⠀⠀\n",
       "⠈⠐⠀⠢⠂⠀⠨⠀⠄⢄⠀⠀⠀⠀⠄⠀⡚⠨⠂⡀⠀⠈⠻⣦⡀⠁⠀⠈⠀⠀⠁⠈⠈⢀⠈⢀⢀⠀⠈⠀\n",
       "⠀⠀⠆⠀⠆⢠⠀⠀⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠠⡛⠀⠠⠄⠈⠿⣧⡁⠀⠀⠈⠂⠄⡐⠀⠜⠀⠀⠀⠀⠘\n",
       "⠀⠐⠀⠉⢂⠂⠀⠉⠐⢄⠀⠤⠀⢌⠄⠀⠀⠀⡀⠒⠠⠄⡀⠀⠁⠈⠵⣧⡀⠀⡀⠰⠀⢀⠤⠁⠀⠀⠀⠀\n",
       "⢀⠀⠀⠀⠠⠈⠐⡀⠀⠂⠀⠀⢀⠂⠀⠀⢔⢀⠀⠀⠄⢀⠀⠀⡀⠀⠀⠈⠱⣦⡀⠊⠃⠐⡀⠄⠀⠀⠀⠀\n",
       "⠀⠀⠈⠀⡈⡀⢠⠤⠔⠁⠄⠀⣠⠀⠀⠃⠀⠄⠡⠀⠠⠉⡁⠀⠈⠄⢀⡈⡠⠈⡑⢌⢈⠐⠐⡄⢀⡀⠀⠀\n",
       "⢀⠄⠀⡅⠂⡀⡀⢀⠀⡀⠀⠀⠈⡌⠀⡁⠀⠀⡃⡁⠈⢐⠂⢀⠐⠈⠀⢀⢉⠀⢂⠐⠑⣤⡂⡌⠀⠀⠀⠀\n",
       "⠚⠄⢁⠀⡀⠥⠨⠀⠂⠐⠄⠀⡂⠁⠀⠀⠀⡴⠠⠐⠘⡀⠂⢀⠒⠁⠄⠃⠀⠌⠐⠤⡈⠬⠱⢆⣀⠀⠀⠀\n",
       "⠀⠀⠀⠀⠂⠠⠐⠀⠀⠀⠀⠀⠀⡀⠄⠠⠀⠮⠂⠀⢀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⠀⠘⠱⢆⣀⠀\n",
       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⠀⠀⠀⠀⠀⠀⠈⠐⠀⠀⠂⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠱⣦"
      ]
     },
     "execution_count": 10,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "sparsA=vars[\"Problem\"][\"A\"]"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d8de664a",
   "metadata": {},
   "source": [
    "Observamos que es un SparseArray con 166 entradas y nos muestra el patron de dispersion de la matriz. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "91f2fb46",
   "metadata": {},
   "source": [
    "Notamos que las matrices dispersas (o ralas) necesitan tratamiento especial. Por ejemplo si calculamos la factorización LU de una matriz rala como si fuera una matriz densa, entonces se produce el fenomeno de fill-in, es decir, los factores L y U son densos. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "1912e044",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "494×494 SparseMatrixCSC{Float64, Int64} with 6681 stored entries:\n",
       "⢗⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⡀⣈⠑⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠁⠒⠀⠐⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠀⠂⠀⠒⠬⠷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⣠⠀⠁⠈⠄⠀⠠⠄⠱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠠⠄⡀⠈⢀⣁⣀⠀⠉⢳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠺⠠⡂⢈⠄⠀⠀⠀⠃⠐⠀⠂⢓⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠄⠀⡱⠈⠄⠄⠌⠅⠡⠫⠆⡐⢐⠀⠱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠐⠀⢀⠈⠂⠠⠤⠤⡀⠀⠀⠡⣉⢀⠁⠍⠵⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠀⠠⠀⠌⠀⠀⠄⢃⠤⠉⢀⠠⣒⢗⠠⡄⡰⢑⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⡀⣀⠀⢬⣈⠀⢌⠀⠰⠤⠄⠨⠈⠀⡭⠶⣅⢅⠀⣽⣷⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠈⠐⠀⠲⠒⠀⠸⠁⠄⢍⡀⠀⠤⠀⢇⡠⡟⠨⠪⡟⠛⡜⠷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠀⠆⠀⠆⢠⡄⣤⠂⠁⠁⢠⠀⠀⠈⠁⠐⡄⠠⣻⣭⡽⠿⠿⠷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠐⠀⠙⢒⠂⠐⠉⠐⢆⡀⠤⠉⢌⡦⠉⡇⠈⡨⣳⣶⢗⣿⠿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⢀⢀⠀⠀⠠⠈⠑⣉⠀⠂⠀⢘⢀⡂⢀⠀⢔⣃⠀⢚⣿⣷⣒⣒⣒⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⠀⠀⠈⠀⡈⡀⢠⡤⠔⠁⠄⢠⣠⢀⢠⡛⠀⣤⢡⢠⣼⡯⣭⣭⣭⣭⣭⣿⣭⣭⡗⣄⠀⠀⠀⠀⠀⠀⠀⠀\n",
       "⢀⠄⠀⡥⠃⡀⣐⢀⠀⡁⠀⢀⠬⣆⠈⣡⠄⡀⣃⣍⣉⣝⢛⢿⣿⣿⣿⣿⣿⣿⣟⣿⣷⣄⠀⠀⠀⠀⠀⠀\n",
       "⠚⠌⢁⠀⠀⠥⠬⠤⠃⠐⠄⠠⡒⢑⠀⠀⠀⡴⠵⢴⣾⡗⠲⢒⠒⣷⣶⣿⣿⣿⡟⣿⣿⣿⣷⣄⠀⠀⠀⠀\n",
       "⠀⠀⠀⠀⠂⠠⠔⠦⠀⠒⠀⠠⠀⣀⠆⠠⠆⠮⢂⢶⢶⡜⠛⠿⠿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣷⣄⠀⠀\n",
       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⠀⠀⠀⠀⠀⠅⠈⠸⠿⠇⠒⠒⣒⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣷⣄"
      ]
     },
     "execution_count": 30,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "luA=lu(Array{Float64}(sparsA))\n",
    "sparse(luA.L)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e59f5145",
   "metadata": {},
   "source": [
    "# Problemas"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ff21f409",
   "metadata": {},
   "source": [
    "## Problema 1\n",
    "Considere la matriz de segundas diferencias $A$ definida por \n",
    "$$a_{ij}=\\left\\{\\begin{array}{cl}\n",
    "-2, & i=j,\\\\\n",
    "1, & |j-i|=1,\\\\\n",
    "0, & |j-i|>1.\n",
    "\\end{array} \\right.$$\n",
    "Considere tambien la matriz de Frank de dimension $n\\times n$, \n",
    "$$\n",
    "A=\\left(\\begin{array}{cccccccccc}\n",
    "n & n-1 & n-2 & n-3 & n-4& \\dots 1\\\\\n",
    "n-1 & n-1 &n-2 &n-3 & n-4 &\\dots 1\\\\\n",
    "0 & n-2 & n-2 & n-3 & n-4 & \\dots 1\\\\\n",
    "0&0&n-3 &n-3 & n-4&\\dots 1 \\\\\n",
    "\\vdots& \\ddots&\\ddots &\\ddots &\\ddots &\\dots\n",
    "\\end{array}\\right)\n",
    "$$\n",
    "\n",
    "Note que en la diagonal principal, es decir, la diagonal 0 tenemos los números $n,n-1,\\dots,1$, en la diagonal $1$ y $-1$ tenemos $n-1,n-2,\\dots,1$. En la diagonal $k>1$ tenemos $n-k,n-k-1,\\dots,1$ y en la diagonal $-k$ con $k>1$ tenemos entradas nulas. Esta matriz es un ejemplo de matriz de Hessenberg. \n",
    "\n",
    "\n",
    "\n",
    "1.   Que propiedades puede listar de las matrices de segundas diferencias y de Frank\n",
    "2.   Investigue como medir el tiempo de ejecución de un comando en python o MatLab y \n",
    "calcule el tiempo de resolver un sistema  $Ax=b$ con $A$ una matriz de \n",
    " segundas diferencias de segundo orden de dimension $n=2,4,8,1,32,64,128,\\dots$. Tome  $b=(1,1,\\dots,1)^T.$\n",
    "3. Repita con la matriz de Frank.\n",
    "4. Repita con la matriz de Hilbert.\n",
    "\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "756d67eb",
   "metadata": {},
   "source": [
    "## Problema 2\n",
    "Considere la matriz de Hilbert $H(n)$ con $n=4,5,6,\\dots$.\n",
    "\n",
    "\n",
    "1.   Para $n=5,6,7,\\dots$ calcule $\\lambda(n)$ el menor valor propio de $H(n)$. Grafique $\\lambda$ como funcion de $n$.\n",
    "2.   Al intentar hacer a factorización de Cholesky de $H(20)$ en Julia/Octave/Matlab/Python la factorización no se calcula llevando a la conclución de que la representación numérica de $H(20)$ no es definida positiva. En Octave parece el error \n",
    "```\n",
    "# error: chol : imput matrix must be positive definite\n",
    "```\n",
    "Verifique teoricamente  $H(n)$ es en realidad positiva definida (no necesita mostrar detalles aqui). Con ayuda del gráfico anterior y de lo estudiado sobre artimética de punto flotante explique esta situación.\n",
    "3. Calcule $R(n)$ de la factorización de Cholesky de $H(n)=R(n)^TR(n)$ con $n=14,15,\\dots,20$. Presente un gráfico de $t(n)=tr(R(n))$ como evidencia del cálculo.\n",
    "\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1c3d312c",
   "metadata": {},
   "source": [
    "## Problema 3\n",
    "Considere la matriz de Hilbert $H(n)$ con $n=4,5,\\dots,20$. Existe una fórmula exacta para la inversa de $H(n)$, implemente esta fórmula. Con el comando de MatLab o Python para calcular la inversa calcule $G=\\mbox{inv}(H(n))$. Compare y comente los resultados.\n",
    "\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "47d533a8",
   "metadata": {},
   "source": [
    "# Problema 5\n",
    "Considere la matriz en https://suitesparse-collection-website.herokuapp.com/Sandia/oscil_dcop_21. Use un método iterativo (diferente de Jacobi) para resolver el sistema $Ax=b$\n",
    "con $b=(1,1,\\dots,1)$. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c75c6125",
   "metadata": {},
   "source": [
    "## Problema 6 (Responda parrafo de texto)\n",
    "Considere la matriz https://suitesparse-collection-website.herokuapp.com/Sybrandt/AGATHA_2015.  Que puede decir del problema asociado a esta matriz? "
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.7.3",
   "language": "julia",
   "name": "julia-1.7"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.7.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
