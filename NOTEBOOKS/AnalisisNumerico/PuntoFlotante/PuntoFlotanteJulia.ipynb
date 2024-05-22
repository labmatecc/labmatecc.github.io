{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "c573cf17",
   "metadata": {
    "id": "IO6TXkoyL1OO"
   },
   "source": [
    "Elaborado por [Juan Galvis](https://scholar.google.com/citations?user=lbfc2joAAAAJ&hl=en)."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ae0080a1",
   "metadata": {},
   "source": [
    "# Punto flotante\n",
    "Presentamos ilustraciones simples de cálculo con números de máquina y redondeo."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "d650c5bd",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x16=\t0011110000000000\n",
      "x32=\t00111111100000000000000000000000\n",
      "x64=\t0011111111110000000000000000000000000000000000000000000000000000\n"
     ]
    }
   ],
   "source": [
    "x16=Float16(1.0)\n",
    "println(\"x16=\\t\",bitstring(x16))\n",
    "x32=Float32(1.0)\n",
    "println(\"x32=\\t\",bitstring(x32))\n",
    "x64=Float64(1.0)\n",
    "println(\"x64=\\t\",bitstring(x64))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "25ce02cf",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "1000000000000000000000000000000000000000000000000000000000000000\n",
      "0000000000000000000000000000000000000000000000000000000000000000\n"
     ]
    }
   ],
   "source": [
    "println(bitstring(-0.0))\n",
    "println(bitstring(0.0))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "e082e940",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x16=\t0010111001100110\n",
      "x32=\t00111101110011001100110011001101\n",
      "x64=\t0011111110111001100110011001100110011001100110011001100110011010\n"
     ]
    }
   ],
   "source": [
    "x16=Float16(0.1)\n",
    "println(\"x16=\\t\",bitstring(x16))\n",
    "x32=Float32(0.1)\n",
    "println(\"x32=\\t\",bitstring(x32))\n",
    "x64=Float64(0.1)\n",
    "println(\"x64=\\t\",bitstring(x64))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "92334235",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x16=\t3.14\n",
      "x32=\t3.1415927\n",
      "x64=\t3.141592653589793\n",
      "xBig=\t3.141592653589793238462643383279502884197169399375105820974944592307816406286198\n"
     ]
    }
   ],
   "source": [
    "x16=Float16(π)\n",
    "println(\"x16=\\t\", x16)\n",
    "x32=Float32(π)\n",
    "println(\"x32=\\t\",x32)\n",
    "x64=Float64(π)\n",
    "println(\"x64=\\t\",x64)\n",
    "xBig=BigFloat(π)\n",
    "println(\"xBig=\\t\", xBig)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d2b5ef49",
   "metadata": {},
   "source": [
    "Puede consultar cuántos bits usa cada uno de estos tipos de datos. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "8ad8b0f0",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/latex": [
       "\\begin{tabular}\n",
       "{l | r | l}\n",
       "name & size & summary \\\\\n",
       "\\hline\n",
       "Base &  & Module \\\\\n",
       "Core &  & Module \\\\\n",
       "Main &  & Module \\\\\n",
       "x16 & 2 bytes & Float16 \\\\\n",
       "x32 & 4 bytes & Float32 \\\\\n",
       "x64 & 8 bytes & Float64 \\\\\n",
       "xBig & 80 bytes & BigFloat \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "| name |     size | summary  |\n",
       "|:---- | --------:|:-------- |\n",
       "| Base |          | Module   |\n",
       "| Core |          | Module   |\n",
       "| Main |          | Module   |\n",
       "| x16  |  2 bytes | Float16  |\n",
       "| x32  |  4 bytes | Float32  |\n",
       "| x64  |  8 bytes | Float64  |\n",
       "| xBig | 80 bytes | BigFloat |\n"
      ],
      "text/plain": [
       "  name     size summary \n",
       "  –––– –––––––– ––––––––\n",
       "  Base          Module  \n",
       "  Core          Module  \n",
       "  Main          Module  \n",
       "  x16   2 bytes Float16 \n",
       "  x32   4 bytes Float32 \n",
       "  x64   8 bytes Float64 \n",
       "  xBig 80 bytes BigFloat"
      ]
     },
     "execution_count": 5,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "varinfo()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "16ebada1",
   "metadata": {},
   "source": [
    "Tambien podemos consultar por el $\\epsilon$ de la maquina y el rango representado"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "638785b2",
   "metadata": {},
   "outputs": [],
   "source": [
    "using Printf"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "37df68b6",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "eps para Float16\t 0.001\n",
      "eps para Float32\t 1.1921e-07\n",
      "eps para Float64\t 2.2204e-16\n",
      "eps para BogFloat\t 1.7272e-77\n"
     ]
    }
   ],
   "source": [
    "@printf(\"eps para Float16\\t %.g\\n\",eps(Float16))\n",
    "@printf(\"eps para Float32\\t %.5g\\n\",eps(Float32))\n",
    "@printf(\"eps para Float64\\t %.5g\\n\",eps(Float64))\n",
    "@printf(\"eps para BogFloat\\t %.5g\\n\",eps(BigFloat))\n",
    "#println(eps(Float16))\n",
    "#println(eps(Float32))\n",
    "#println(eps())\n",
    "#println(eps(BigFloat))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "1c3f3cb7",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Min, Max Float16\t 6.1035e-05  \t\t 65504\n",
      "Min, Max Float32\t 1.1755e-38\t\t 3.4028e+38\n",
      "Min, Max Float64\t 2.2251e-308\t\t 1.7977e+308\n",
      "Min, Max BogFloat\t 8.5097e-1388255822130839284\t 5.8757e+1388255822130839282\n"
     ]
    }
   ],
   "source": [
    "@printf(\"Min, Max Float16\\t %.5g  \\t\\t %.5g\\n\",floatmin(Float16),floatmax(Float16))\n",
    "@printf(\"Min, Max Float32\\t %.5g\\t\\t %.5g\\n\",floatmin(Float32), floatmax(Float32))\n",
    "@printf(\"Min, Max Float64\\t %.5g\\t\\t %.5g\\n\",floatmin(Float64), floatmax(Float64))\n",
    "@printf(\"Min, Max BogFloat\\t %.5g\\t %.5g\\n\",floatmin(BigFloat), floatmax(BigFloat))\n",
    "#println(eps(Float16))\n",
    "#println(eps(Float32))\n",
    "#println(eps())\n",
    "#println(eps(BigFloat))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "6c97c886",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "signo=0\t exp=01101000\t significand=00000000000000\n",
      "signo=0\t exp=00000001\t significand=00000000000000\n",
      "signo=0\t exp=11111110\t significand=11111111111111\n"
     ]
    }
   ],
   "source": [
    "xeps=bitstring(eps(Float32));\n",
    "println(\"signo=\",xeps[1],\"\\t exp=\",xeps[2:9],\"\\t significand=\",xeps[19:32])\n",
    "xmin=bitstring(floatmin(Float32))\n",
    "println(\"signo=\",xmin[1],\"\\t exp=\",xmin[2:9],\"\\t significand=\",xmin[19:32])\n",
    "xmax=bitstring(floatmax(Float32))\n",
    "println(\"signo=\",xmax[1],\"\\t exp=\",xmax[2:9],\"\\t significand=\",xmax[19:32])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ff476213",
   "metadata": {},
   "source": [
    "Debemos tener cuidado al comparar dos variables de tipo float en condiciones para control condicional o control iterativo. Considere los siguientes ejemplos."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "d18d896e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "true"
      ]
     },
     "execution_count": 10,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "(0.1+0.1)==0.2"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "323d8c78",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "false"
      ]
     },
     "execution_count": 11,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "(0.1+0.1+0.1)==0.3"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6378d5a4",
   "metadata": {},
   "source": [
    "Podemos comparar usando una tolerancia u usar el operador de comparación aproximada."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "b076c536",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "true"
      ]
     },
     "execution_count": 12,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "tol=1E-10\n",
    "((0.1+0.1+0.1)-0.3)< tol"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "257aa9e6",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "true"
      ]
     },
     "execution_count": 13,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "(0.1+0.1+0.1)≈0.3 #  comparación aproximada."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "01b3516c",
   "metadata": {},
   "source": [
    "Veamos que pasa si intentamos sumar x=1/10 varias veces, esto es, $\\sum_{i=1}^N 0.1$. Veamos la siguiente implementación."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "1e381db7",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Despues de 1000000 sumas(Float64) de 1/10, el resultado es 100000.00000133288\n",
      "El producto es : 100000.0\n"
     ]
    }
   ],
   "source": [
    "suma64=0.0\n",
    "n=10^6\n",
    "for i=1:n\n",
    "  suma64=suma64+(1/10) \n",
    "end\n",
    "println(\"Despues de \",n, \" sumas(Float64) de 1/10, el resultado es \",suma64)\n",
    "x=1/10\n",
    "p=n*x\n",
    "println(\"El producto es : \",p)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "f9dd1972",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Despues de 1000000 sumas(Float32) de 1/10, el resultado es 100958.34\n",
      "El producto es : 100000.0\n"
     ]
    }
   ],
   "source": [
    "suma32=Float32(0.0)\n",
    "n=10^6\n",
    "for i=1:n\n",
    "  suma32=suma32+Float32(1/10) \n",
    "end\n",
    "println(\"Despues de \",n, \" sumas(Float32) de 1/10, el resultado es \",suma32)\n",
    "x=Float32(1/10)\n",
    "p=n*x\n",
    "println(\"El producto es : \",p)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3e0a4810",
   "metadata": {},
   "source": [
    "Veamos  numéros de máquina positivos pequeños y algunas operaciones."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "226da6b3",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x=5.0e-324es un numero de maquina. Pero y=2E-324 es aproximado  a  y=\t0.0\n",
      "Al dividir x=3E-324 por dos tenemos x/2=\t0.0\n",
      "Note tambien que 1/x=\tInf"
     ]
    }
   ],
   "source": [
    "x=3E-324\n",
    "y=2E-324\n",
    "print(\"x=\",x,\"es un numero de maquina. Pero y=2E-324 es aproximado  a  y=\\t\",y, \"\\n\")\n",
    "print(\"Al dividir x=3E-324 por dos tenemos x/2=\\t\",x/2,\"\\n\")\n",
    "print(\"Note tambien que 1/x=\\t\",1/x)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a075b2b2",
   "metadata": {},
   "source": [
    "Ahora numéros positivos grandes."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "34e9cde6",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x=1.7e308 es un numéro de maquina pero  y genera desbordamiento\n"
     ]
    }
   ],
   "source": [
    "x=1.7E+308\n",
    "#y=1.8E+308 # overflow in numeric constant \n",
    "print(\"x=\",x,\" es un numéro de maquina pero  y genera desbordamiento\\n\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8bdf096f",
   "metadata": {},
   "source": [
    "Verificamos ahora la no-asociatividad de la suma en el siguiente ejemplo."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "a6e68ef4",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x= 1.0 diferente de   y=0.0"
     ]
    }
   ],
   "source": [
    "x=1E+26-1E+26+1\n",
    "y=1E+26+1-1E+26\n",
    "print(\"x= \",x, \" diferente de   y=\",y)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dba26119",
   "metadata": {},
   "source": [
    "Considere tambien el siguiente ejemplo."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "f427350e",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x=1.099e308 que es diferente a  y=Inf"
     ]
    }
   ],
   "source": [
    "a=1E+308\n",
    "b=1.1E+308\n",
    "c=-1.001E+308\n",
    "x=a+(b+c)\n",
    "y=(a+b)+c\n",
    "#y=a**2\n",
    "print(\"x=\",x,\" que es diferente a  y=\",y)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6997a80a",
   "metadata": {},
   "source": [
    "Otro ejemplo es el de calcular $\\sqrt{a^2+b^2}$ con $a=$1E+200 y $b=1$."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "ada9b725",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Inf\n"
     ]
    }
   ],
   "source": [
    "a=1E+200\n",
    "b=1\n",
    "y=sqrt( a^2+b^2)\n",
    "println(y)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dde24197",
   "metadata": {},
   "source": [
    "Podemos evitar el desbordamiento por exceso."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "fc3d1ee0",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "1.0e200\n"
     ]
    }
   ],
   "source": [
    "z=a*sqrt( 1+(b/a)^2)\n",
    "println(z)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bf0caa17",
   "metadata": {},
   "source": [
    "Algunas expresiones ideterminadas con las que se debe tener cuidado a la hora de calcular con punto flotante."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "8b69b0ac",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "x= 1, y=0, z=Inf, w=Inf\n",
      "\n",
      "Inf/Inf=NaN\n",
      "\n",
      "Inf*Inf=Inf\n",
      "\n",
      "1/NaN=NaN\n",
      "\n",
      "NaN*1=NaN\n",
      "\n",
      "sqrt(NaN)=NaN\n",
      "\n"
     ]
    }
   ],
   "source": [
    "x=1\n",
    "y=0\n",
    "z=1E+307*100\n",
    "w=1E+308*100\n",
    "println(\"x= \",x,\", y=\",y,\", z=\",z,\", w=\",w, \"\\n\")\n",
    "println(\"Inf/Inf=\",w/z,\"\\n\")\n",
    "println(\"Inf*Inf=\",w*z,\"\\n\")\n",
    "println(\"1/NaN=\", 1/(w/z),\"\\n\")\n",
    "println(\"NaN*1=\",(w/z)*1,\"\\n\")\n",
    "println(\"sqrt(NaN)=\",sqrt((w/z)),\"\\n\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2ea6450b",
   "metadata": {},
   "source": [
    "El siguiente código muestra un código simple para aproximar el epsilon de la máquina para precisión simple en esta maquina."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "3bd0ddfc",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Epsilon de máquina es aproximadamente 5.9604645e-8\n",
      "La precisión en bits es 24.0bits.\n",
      "La precisión en decimales es 7.22472.\n",
      "Usando la funcion eps de Julia eps=1.1920929e-7\n"
     ]
    }
   ],
   "source": [
    "diferencia=0\n",
    "t=1\n",
    "i=0\n",
    "while(diferencia!=1)\n",
    "  i=i+1\n",
    "  t=Float32(t/2)\n",
    "  uno=Float32(1.0)\n",
    "  diferencia=uno-t\n",
    "#  println(\"La resta de 1-t (\",i,\") es \",diferencia,\"\\n\")\n",
    "end\n",
    "println(\"Epsilon de máquina es aproximadamente \",2*t)\n",
    "println(\"La precisión en bits es \",-log2(2*t),\"bits.\")\n",
    "println(\"La precisión en decimales es \",-log10(2*t),\".\")\n",
    "println(\"Usando la funcion eps de Julia eps=\", eps(Float32))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "bb73500f",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Epsilon de máquina es aproximadamente 1.1102230246251565e-16\n",
      "La precisión en bits es 53.0bits.\n",
      "La precisión en decimales es 15.954589770191003.\n",
      "Usando la funcion eps de Julia eps=1.1920929e-7\n"
     ]
    }
   ],
   "source": [
    "diferencia=0\n",
    "t=1\n",
    "i=0\n",
    "while(diferencia!=1)\n",
    "  i=i+1\n",
    "  t=t/2\n",
    "  uno=1.0\n",
    "  diferencia=uno-t\n",
    "#  println(\"La resta de 1-t (\",i,\") es \",diferencia,\"\\n\")\n",
    "end\n",
    "println(\"Epsilon de máquina es aproximadamente \",2*t)\n",
    "println(\"La precisión en bits es \",-log2(2*t),\"bits.\")\n",
    "println(\"La precisión en decimales es \",-log10(2*t),\".\")\n",
    "println(\"Usando la funcion eps de Julia eps=\", eps(Float32))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "aa815899",
   "metadata": {},
   "source": [
    "Un ejemplo de perdida de dígitos (o cancelación) es el siguiente."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "3c3e809d",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "y=1.1102230246251565Con error relativo de 11.022302462515654%."
     ]
    }
   ],
   "source": [
    "x=1E-15\n",
    "y=((1+x)-1)/x\n",
    "print(\"y=\",y)\n",
    "print(\"Con error relativo de \", 100*(y-1),\"%.\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5b987cd2",
   "metadata": {},
   "source": [
    "Un otro ejemplo comun de cancelación es cuando se evaluan polinomios usando la expresión de potencias. Por ejemplo, evaluemos \n",
    "$$P(x)=(x-1)^7=x^7-7x^6+21x^5-35x^4+35x^3-21x^2+7x-1$$\n",
    "usando ests dos expresiones. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "e8d1a36f",
   "metadata": {},
   "outputs": [],
   "source": [
    "using Plots"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "5c2664c8",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/svg+xml": [
       "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n",
       "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"400\" viewBox=\"0 0 2400 1600\">\n",
       "<defs>\n",
       "  <clipPath id=\"clip110\">\n",
       "    <rect x=\"0\" y=\"0\" width=\"2400\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip110)\" d=\"\n",
       "M0 1600 L2400 1600 L2400 0 L0 0  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip111\">\n",
       "    <rect x=\"480\" y=\"0\" width=\"1681\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip110)\" d=\"\n",
       "M399.187 1486.45 L2352.76 1486.45 L2352.76 123.472 L399.187 123.472  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip112\">\n",
       "    <rect x=\"399\" y=\"123\" width=\"1955\" height=\"1364\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  454.476,1486.45 454.476,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  915.224,1486.45 915.224,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1375.97,1486.45 1375.97,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1836.72,1486.45 1836.72,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  2297.47,1486.45 2297.47,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,1486.45 2352.76,1486.45 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  454.476,1486.45 454.476,1467.55 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  915.224,1486.45 915.224,1467.55 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1375.97,1486.45 1375.97,1467.55 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1836.72,1486.45 1836.72,1467.55 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  2297.47,1486.45 2297.47,1467.55 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip110)\" d=\"M401.618 1517.37 Q398.007 1517.37 396.178 1520.93 Q394.372 1524.47 394.372 1531.6 Q394.372 1538.71 396.178 1542.27 Q398.007 1545.82 401.618 1545.82 Q405.252 1545.82 407.058 1542.27 Q408.886 1538.71 408.886 1531.6 Q408.886 1524.47 407.058 1520.93 Q405.252 1517.37 401.618 1517.37 M401.618 1513.66 Q407.428 1513.66 410.484 1518.27 Q413.562 1522.85 413.562 1531.6 Q413.562 1540.33 410.484 1544.94 Q407.428 1549.52 401.618 1549.52 Q395.808 1549.52 392.729 1544.94 Q389.673 1540.33 389.673 1531.6 Q389.673 1522.85 392.729 1518.27 Q395.808 1513.66 401.618 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M421.78 1542.97 L426.664 1542.97 L426.664 1548.85 L421.78 1548.85 L421.78 1542.97 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M436.988 1548.13 L436.988 1543.87 Q438.747 1544.7 440.553 1545.14 Q442.358 1545.58 444.094 1545.58 Q448.724 1545.58 451.155 1542.48 Q453.608 1539.36 453.955 1533.01 Q452.613 1535.01 450.553 1536.07 Q448.493 1537.13 445.993 1537.13 Q440.807 1537.13 437.775 1534.01 Q434.766 1530.86 434.766 1525.42 Q434.766 1520.1 437.914 1516.88 Q441.062 1513.66 446.294 1513.66 Q452.289 1513.66 455.437 1518.27 Q458.608 1522.85 458.608 1531.6 Q458.608 1539.77 454.719 1544.66 Q450.854 1549.52 444.303 1549.52 Q442.544 1549.52 440.738 1549.17 Q438.932 1548.82 436.988 1548.13 M446.294 1533.48 Q449.442 1533.48 451.27 1531.32 Q453.122 1529.17 453.122 1525.42 Q453.122 1521.7 451.27 1519.54 Q449.442 1517.37 446.294 1517.37 Q443.145 1517.37 441.294 1519.54 Q439.465 1521.7 439.465 1525.42 Q439.465 1529.17 441.294 1531.32 Q443.145 1533.48 446.294 1533.48 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M467.15 1548.13 L467.15 1543.87 Q468.909 1544.7 470.715 1545.14 Q472.52 1545.58 474.256 1545.58 Q478.886 1545.58 481.316 1542.48 Q483.77 1539.36 484.117 1533.01 Q482.775 1535.01 480.715 1536.07 Q478.654 1537.13 476.154 1537.13 Q470.969 1537.13 467.937 1534.01 Q464.928 1530.86 464.928 1525.42 Q464.928 1520.1 468.076 1516.88 Q471.224 1513.66 476.455 1513.66 Q482.451 1513.66 485.599 1518.27 Q488.77 1522.85 488.77 1531.6 Q488.77 1539.77 484.881 1544.66 Q481.016 1549.52 474.465 1549.52 Q472.705 1549.52 470.9 1549.17 Q469.094 1548.82 467.15 1548.13 M476.455 1533.48 Q479.604 1533.48 481.432 1531.32 Q483.284 1529.17 483.284 1525.42 Q483.284 1521.7 481.432 1519.54 Q479.604 1517.37 476.455 1517.37 Q473.307 1517.37 471.455 1519.54 Q469.627 1521.7 469.627 1525.42 Q469.627 1529.17 471.455 1531.32 Q473.307 1533.48 476.455 1533.48 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M507.752 1529.7 Q504.603 1529.7 502.752 1531.86 Q500.923 1534.01 500.923 1537.76 Q500.923 1541.49 502.752 1543.66 Q504.603 1545.82 507.752 1545.82 Q510.9 1545.82 512.728 1543.66 Q514.58 1541.49 514.58 1537.76 Q514.58 1534.01 512.728 1531.86 Q510.9 1529.7 507.752 1529.7 M517.034 1515.05 L517.034 1519.31 Q515.275 1518.48 513.469 1518.04 Q511.687 1517.6 509.927 1517.6 Q505.298 1517.6 502.844 1520.72 Q500.414 1523.85 500.066 1530.17 Q501.432 1528.15 503.492 1527.09 Q505.552 1526 508.029 1526 Q513.238 1526 516.247 1529.17 Q519.279 1532.32 519.279 1537.76 Q519.279 1543.08 516.131 1546.3 Q512.983 1549.52 507.752 1549.52 Q501.756 1549.52 498.585 1544.94 Q495.414 1540.33 495.414 1531.6 Q495.414 1523.41 499.302 1518.55 Q503.191 1513.66 509.742 1513.66 Q511.501 1513.66 513.284 1514.01 Q515.089 1514.36 517.034 1515.05 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M862.493 1517.37 Q858.882 1517.37 857.053 1520.93 Q855.247 1524.47 855.247 1531.6 Q855.247 1538.71 857.053 1542.27 Q858.882 1545.82 862.493 1545.82 Q866.127 1545.82 867.932 1542.27 Q869.761 1538.71 869.761 1531.6 Q869.761 1524.47 867.932 1520.93 Q866.127 1517.37 862.493 1517.37 M862.493 1513.66 Q868.303 1513.66 871.358 1518.27 Q874.437 1522.85 874.437 1531.6 Q874.437 1540.33 871.358 1544.94 Q868.303 1549.52 862.493 1549.52 Q856.682 1549.52 853.604 1544.94 Q850.548 1540.33 850.548 1531.6 Q850.548 1522.85 853.604 1518.27 Q856.682 1513.66 862.493 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M882.655 1542.97 L887.539 1542.97 L887.539 1548.85 L882.655 1548.85 L882.655 1542.97 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M897.863 1548.13 L897.863 1543.87 Q899.622 1544.7 901.428 1545.14 Q903.233 1545.58 904.969 1545.58 Q909.599 1545.58 912.029 1542.48 Q914.483 1539.36 914.83 1533.01 Q913.488 1535.01 911.428 1536.07 Q909.367 1537.13 906.867 1537.13 Q901.682 1537.13 898.65 1534.01 Q895.641 1530.86 895.641 1525.42 Q895.641 1520.1 898.789 1516.88 Q901.937 1513.66 907.168 1513.66 Q913.164 1513.66 916.312 1518.27 Q919.483 1522.85 919.483 1531.6 Q919.483 1539.77 915.594 1544.66 Q911.728 1549.52 905.178 1549.52 Q903.418 1549.52 901.613 1549.17 Q899.807 1548.82 897.863 1548.13 M907.168 1533.48 Q910.316 1533.48 912.145 1531.32 Q913.997 1529.17 913.997 1525.42 Q913.997 1521.7 912.145 1519.54 Q910.316 1517.37 907.168 1517.37 Q904.02 1517.37 902.168 1519.54 Q900.34 1521.7 900.34 1525.42 Q900.34 1529.17 902.168 1531.32 Q904.02 1533.48 907.168 1533.48 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M928.025 1548.13 L928.025 1543.87 Q929.784 1544.7 931.589 1545.14 Q933.395 1545.58 935.131 1545.58 Q939.761 1545.58 942.191 1542.48 Q944.645 1539.36 944.992 1533.01 Q943.65 1535.01 941.589 1536.07 Q939.529 1537.13 937.029 1537.13 Q931.844 1537.13 928.812 1534.01 Q925.802 1530.86 925.802 1525.42 Q925.802 1520.1 928.951 1516.88 Q932.099 1513.66 937.33 1513.66 Q943.326 1513.66 946.474 1518.27 Q949.645 1522.85 949.645 1531.6 Q949.645 1539.77 945.756 1544.66 Q941.89 1549.52 935.339 1549.52 Q933.58 1549.52 931.775 1549.17 Q929.969 1548.82 928.025 1548.13 M937.33 1533.48 Q940.478 1533.48 942.307 1531.32 Q944.159 1529.17 944.159 1525.42 Q944.159 1521.7 942.307 1519.54 Q940.478 1517.37 937.33 1517.37 Q934.182 1517.37 932.33 1519.54 Q930.501 1521.7 930.501 1525.42 Q930.501 1529.17 932.33 1531.32 Q934.182 1533.48 937.33 1533.48 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M968.048 1532.44 Q964.714 1532.44 962.793 1534.22 Q960.895 1536 960.895 1539.13 Q960.895 1542.25 962.793 1544.03 Q964.714 1545.82 968.048 1545.82 Q971.381 1545.82 973.302 1544.03 Q975.223 1542.23 975.223 1539.13 Q975.223 1536 973.302 1534.22 Q971.404 1532.44 968.048 1532.44 M963.372 1530.45 Q960.362 1529.7 958.673 1527.64 Q957.006 1525.58 957.006 1522.62 Q957.006 1518.48 959.946 1516.07 Q962.909 1513.66 968.048 1513.66 Q973.21 1513.66 976.149 1516.07 Q979.089 1518.48 979.089 1522.62 Q979.089 1525.58 977.399 1527.64 Q975.733 1529.7 972.747 1530.45 Q976.126 1531.23 978.001 1533.52 Q979.899 1535.82 979.899 1539.13 Q979.899 1544.15 976.821 1546.83 Q973.765 1549.52 968.048 1549.52 Q962.33 1549.52 959.251 1546.83 Q956.196 1544.15 956.196 1539.13 Q956.196 1535.82 958.094 1533.52 Q959.992 1531.23 963.372 1530.45 M961.659 1523.06 Q961.659 1525.75 963.325 1527.25 Q965.015 1528.76 968.048 1528.76 Q971.057 1528.76 972.747 1527.25 Q974.46 1525.75 974.46 1523.06 Q974.46 1520.38 972.747 1518.87 Q971.057 1517.37 968.048 1517.37 Q965.015 1517.37 963.325 1518.87 Q961.659 1520.38 961.659 1523.06 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1312.96 1544.91 L1320.6 1544.91 L1320.6 1518.55 L1312.29 1520.21 L1312.29 1515.95 L1320.55 1514.29 L1325.23 1514.29 L1325.23 1544.91 L1332.87 1544.91 L1332.87 1548.85 L1312.96 1548.85 L1312.96 1544.91 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1342.31 1542.97 L1347.2 1542.97 L1347.2 1548.85 L1342.31 1548.85 L1342.31 1542.97 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1367.38 1517.37 Q1363.77 1517.37 1361.94 1520.93 Q1360.14 1524.47 1360.14 1531.6 Q1360.14 1538.71 1361.94 1542.27 Q1363.77 1545.82 1367.38 1545.82 Q1371.02 1545.82 1372.82 1542.27 Q1374.65 1538.71 1374.65 1531.6 Q1374.65 1524.47 1372.82 1520.93 Q1371.02 1517.37 1367.38 1517.37 M1367.38 1513.66 Q1373.19 1513.66 1376.25 1518.27 Q1379.33 1522.85 1379.33 1531.6 Q1379.33 1540.33 1376.25 1544.94 Q1373.19 1549.52 1367.38 1549.52 Q1361.57 1549.52 1358.49 1544.94 Q1355.44 1540.33 1355.44 1531.6 Q1355.44 1522.85 1358.49 1518.27 Q1361.57 1513.66 1367.38 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1397.55 1517.37 Q1393.93 1517.37 1392.11 1520.93 Q1390.3 1524.47 1390.3 1531.6 Q1390.3 1538.71 1392.11 1542.27 Q1393.93 1545.82 1397.55 1545.82 Q1401.18 1545.82 1402.99 1542.27 Q1404.81 1538.71 1404.81 1531.6 Q1404.81 1524.47 1402.99 1520.93 Q1401.18 1517.37 1397.55 1517.37 M1397.55 1513.66 Q1403.36 1513.66 1406.41 1518.27 Q1409.49 1522.85 1409.49 1531.6 Q1409.49 1540.33 1406.41 1544.94 Q1403.36 1549.52 1397.55 1549.52 Q1391.74 1549.52 1388.66 1544.94 Q1385.6 1540.33 1385.6 1531.6 Q1385.6 1522.85 1388.66 1518.27 Q1391.74 1513.66 1397.55 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1427.71 1517.37 Q1424.1 1517.37 1422.27 1520.93 Q1420.46 1524.47 1420.46 1531.6 Q1420.46 1538.71 1422.27 1542.27 Q1424.1 1545.82 1427.71 1545.82 Q1431.34 1545.82 1433.15 1542.27 Q1434.98 1538.71 1434.98 1531.6 Q1434.98 1524.47 1433.15 1520.93 Q1431.34 1517.37 1427.71 1517.37 M1427.71 1513.66 Q1433.52 1513.66 1436.57 1518.27 Q1439.65 1522.85 1439.65 1531.6 Q1439.65 1540.33 1436.57 1544.94 Q1433.52 1549.52 1427.71 1549.52 Q1421.9 1549.52 1418.82 1544.94 Q1415.76 1540.33 1415.76 1531.6 Q1415.76 1522.85 1418.82 1518.27 Q1421.9 1513.66 1427.71 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1774.51 1544.91 L1782.15 1544.91 L1782.15 1518.55 L1773.84 1520.21 L1773.84 1515.95 L1782.1 1514.29 L1786.78 1514.29 L1786.78 1544.91 L1794.42 1544.91 L1794.42 1548.85 L1774.51 1548.85 L1774.51 1544.91 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1803.86 1542.97 L1808.74 1542.97 L1808.74 1548.85 L1803.86 1548.85 L1803.86 1542.97 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1828.93 1517.37 Q1825.32 1517.37 1823.49 1520.93 Q1821.68 1524.47 1821.68 1531.6 Q1821.68 1538.71 1823.49 1542.27 Q1825.32 1545.82 1828.93 1545.82 Q1832.56 1545.82 1834.37 1542.27 Q1836.2 1538.71 1836.2 1531.6 Q1836.2 1524.47 1834.37 1520.93 Q1832.56 1517.37 1828.93 1517.37 M1828.93 1513.66 Q1834.74 1513.66 1837.8 1518.27 Q1840.87 1522.85 1840.87 1531.6 Q1840.87 1540.33 1837.8 1544.94 Q1834.74 1549.52 1828.93 1549.52 Q1823.12 1549.52 1820.04 1544.94 Q1816.99 1540.33 1816.99 1531.6 Q1816.99 1522.85 1820.04 1518.27 Q1823.12 1513.66 1828.93 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1859.09 1517.37 Q1855.48 1517.37 1853.65 1520.93 Q1851.85 1524.47 1851.85 1531.6 Q1851.85 1538.71 1853.65 1542.27 Q1855.48 1545.82 1859.09 1545.82 Q1862.73 1545.82 1864.53 1542.27 Q1866.36 1538.71 1866.36 1531.6 Q1866.36 1524.47 1864.53 1520.93 Q1862.73 1517.37 1859.09 1517.37 M1859.09 1513.66 Q1864.9 1513.66 1867.96 1518.27 Q1871.04 1522.85 1871.04 1531.6 Q1871.04 1540.33 1867.96 1544.94 Q1864.9 1549.52 1859.09 1549.52 Q1853.28 1549.52 1850.2 1544.94 Q1847.15 1540.33 1847.15 1531.6 Q1847.15 1522.85 1850.2 1518.27 Q1853.28 1513.66 1859.09 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1883.28 1544.91 L1899.6 1544.91 L1899.6 1548.85 L1877.66 1548.85 L1877.66 1544.91 Q1880.32 1542.16 1884.9 1537.53 Q1889.51 1532.88 1890.69 1531.53 Q1892.93 1529.01 1893.81 1527.27 Q1894.72 1525.51 1894.72 1523.82 Q1894.72 1521.07 1892.77 1519.33 Q1890.85 1517.6 1887.75 1517.6 Q1885.55 1517.6 1883.1 1518.36 Q1880.67 1519.13 1877.89 1520.68 L1877.89 1515.95 Q1880.71 1514.82 1883.17 1514.24 Q1885.62 1513.66 1887.66 1513.66 Q1893.03 1513.66 1896.22 1516.35 Q1899.42 1519.03 1899.42 1523.52 Q1899.42 1525.65 1898.6 1527.57 Q1897.82 1529.47 1895.71 1532.07 Q1895.13 1532.74 1892.03 1535.95 Q1888.93 1539.15 1883.28 1544.91 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2234.21 1544.91 L2241.85 1544.91 L2241.85 1518.55 L2233.54 1520.21 L2233.54 1515.95 L2241.81 1514.29 L2246.48 1514.29 L2246.48 1544.91 L2254.12 1544.91 L2254.12 1548.85 L2234.21 1548.85 L2234.21 1544.91 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2263.57 1542.97 L2268.45 1542.97 L2268.45 1548.85 L2263.57 1548.85 L2263.57 1542.97 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2288.64 1517.37 Q2285.02 1517.37 2283.2 1520.93 Q2281.39 1524.47 2281.39 1531.6 Q2281.39 1538.71 2283.2 1542.27 Q2285.02 1545.82 2288.64 1545.82 Q2292.27 1545.82 2294.08 1542.27 Q2295.9 1538.71 2295.9 1531.6 Q2295.9 1524.47 2294.08 1520.93 Q2292.27 1517.37 2288.64 1517.37 M2288.64 1513.66 Q2294.45 1513.66 2297.5 1518.27 Q2300.58 1522.85 2300.58 1531.6 Q2300.58 1540.33 2297.5 1544.94 Q2294.45 1549.52 2288.64 1549.52 Q2282.83 1549.52 2279.75 1544.94 Q2276.69 1540.33 2276.69 1531.6 Q2276.69 1522.85 2279.75 1518.27 Q2282.83 1513.66 2288.64 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2318.8 1517.37 Q2315.19 1517.37 2313.36 1520.93 Q2311.55 1524.47 2311.55 1531.6 Q2311.55 1538.71 2313.36 1542.27 Q2315.19 1545.82 2318.8 1545.82 Q2322.43 1545.82 2324.24 1542.27 Q2326.07 1538.71 2326.07 1531.6 Q2326.07 1524.47 2324.24 1520.93 Q2322.43 1517.37 2318.8 1517.37 M2318.8 1513.66 Q2324.61 1513.66 2327.66 1518.27 Q2330.74 1522.85 2330.74 1531.6 Q2330.74 1540.33 2327.66 1544.94 Q2324.61 1549.52 2318.8 1549.52 Q2312.99 1549.52 2309.91 1544.94 Q2306.85 1540.33 2306.85 1531.6 Q2306.85 1522.85 2309.91 1518.27 Q2312.99 1513.66 2318.8 1513.66 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2351.81 1518.36 L2340 1536.81 L2351.81 1536.81 L2351.81 1518.36 M2350.58 1514.29 L2356.46 1514.29 L2356.46 1536.81 L2361.39 1536.81 L2361.39 1540.7 L2356.46 1540.7 L2356.46 1548.85 L2351.81 1548.85 L2351.81 1540.7 L2336.2 1540.7 L2336.2 1536.19 L2350.58 1514.29 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,1403.21 2352.76,1403.21 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,1177.01 2352.76,1177.01 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,950.801 2352.76,950.801 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,724.596 2352.76,724.596 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,498.391 2352.76,498.391 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  399.187,272.186 2352.76,272.186 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,1486.45 399.187,123.472 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,1403.21 418.084,1403.21 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,1177.01 418.084,1177.01 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,950.801 418.084,950.801 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,724.596 418.084,724.596 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,498.391 418.084,498.391 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  399.187,272.186 418.084,272.186 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip110)\" d=\"M50.9921 1410.11 L80.6679 1410.11 L80.6679 1414.04 L50.9921 1414.04 L50.9921 1410.11 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M91.5706 1423 L99.2095 1423 L99.2095 1396.64 L90.8993 1398.3 L90.8993 1394.04 L99.1632 1392.38 L103.839 1392.38 L103.839 1423 L111.478 1423 L111.478 1426.94 L91.5706 1426.94 L91.5706 1423 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M120.922 1421.06 L125.807 1421.06 L125.807 1426.94 L120.922 1426.94 L120.922 1421.06 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M136.038 1392.38 L154.394 1392.38 L154.394 1396.31 L140.32 1396.31 L140.32 1404.79 Q141.339 1404.44 142.357 1404.28 Q143.376 1404.09 144.394 1404.09 Q150.181 1404.09 153.561 1407.26 Q156.941 1410.43 156.941 1415.85 Q156.941 1421.43 153.468 1424.53 Q149.996 1427.61 143.677 1427.61 Q141.501 1427.61 139.232 1427.24 Q136.987 1426.87 134.58 1426.13 L134.58 1421.43 Q136.663 1422.56 138.885 1423.12 Q141.107 1423.67 143.584 1423.67 Q147.589 1423.67 149.927 1421.57 Q152.265 1419.46 152.265 1415.85 Q152.265 1412.24 149.927 1410.13 Q147.589 1408.03 143.584 1408.03 Q141.709 1408.03 139.834 1408.44 Q137.982 1408.86 136.038 1409.74 L136.038 1392.38 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M176.153 1395.46 Q172.542 1395.46 170.714 1399.02 Q168.908 1402.56 168.908 1409.69 Q168.908 1416.8 170.714 1420.36 Q172.542 1423.91 176.153 1423.91 Q179.788 1423.91 181.593 1420.36 Q183.422 1416.8 183.422 1409.69 Q183.422 1402.56 181.593 1399.02 Q179.788 1395.46 176.153 1395.46 M176.153 1391.75 Q181.964 1391.75 185.019 1396.36 Q188.098 1400.94 188.098 1409.69 Q188.098 1418.42 185.019 1423.03 Q181.964 1427.61 176.153 1427.61 Q170.343 1427.61 167.265 1423.03 Q164.209 1418.42 164.209 1409.69 Q164.209 1400.94 167.265 1396.36 Q170.343 1391.75 176.153 1391.75 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M224.487 1401.48 L213.908 1412.1 L224.487 1422.68 L221.732 1425.48 L211.107 1414.85 L200.482 1425.48 L197.751 1422.68 L208.306 1412.1 L197.751 1401.48 L200.482 1398.67 L211.107 1409.3 L221.732 1398.67 L224.487 1401.48 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M236.848 1423 L244.486 1423 L244.486 1396.64 L236.176 1398.3 L236.176 1394.04 L244.44 1392.38 L249.116 1392.38 L249.116 1423 L256.755 1423 L256.755 1426.94 L236.848 1426.94 L236.848 1423 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M276.199 1395.46 Q272.588 1395.46 270.759 1399.02 Q268.954 1402.56 268.954 1409.69 Q268.954 1416.8 270.759 1420.36 Q272.588 1423.91 276.199 1423.91 Q279.833 1423.91 281.639 1420.36 Q283.468 1416.8 283.468 1409.69 Q283.468 1402.56 281.639 1399.02 Q279.833 1395.46 276.199 1395.46 M276.199 1391.75 Q282.009 1391.75 285.065 1396.36 Q288.144 1400.94 288.144 1409.69 Q288.144 1418.42 285.065 1423.03 Q282.009 1427.61 276.199 1427.61 Q270.389 1427.61 267.31 1423.03 Q264.255 1418.42 264.255 1409.69 Q264.255 1400.94 267.31 1396.36 Q270.389 1391.75 276.199 1391.75 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M288.144 1385.85 L312.255 1385.85 L312.255 1389.05 L288.144 1389.05 L288.144 1385.85 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M321.114 1396.33 L327.32 1396.33 L327.32 1374.91 L320.568 1376.26 L320.568 1372.8 L327.283 1371.45 L331.082 1371.45 L331.082 1396.33 L337.288 1396.33 L337.288 1399.53 L321.114 1399.53 L321.114 1396.33 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M355.4 1374.76 L345.808 1389.75 L355.4 1389.75 L355.4 1374.76 M354.403 1371.45 L359.181 1371.45 L359.181 1389.75 L363.187 1389.75 L363.187 1392.91 L359.181 1392.91 L359.181 1399.53 L355.4 1399.53 L355.4 1392.91 L342.724 1392.91 L342.724 1389.24 L354.403 1371.45 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M50.9921 1183.9 L80.6679 1183.9 L80.6679 1187.84 L50.9921 1187.84 L50.9921 1183.9 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M91.5706 1196.8 L99.2095 1196.8 L99.2095 1170.43 L90.8993 1172.1 L90.8993 1167.84 L99.1632 1166.17 L103.839 1166.17 L103.839 1196.8 L111.478 1196.8 L111.478 1200.73 L91.5706 1200.73 L91.5706 1196.8 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M120.922 1194.85 L125.807 1194.85 L125.807 1200.73 L120.922 1200.73 L120.922 1194.85 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M145.992 1169.25 Q142.381 1169.25 140.552 1172.82 Q138.746 1176.36 138.746 1183.49 Q138.746 1190.59 140.552 1194.16 Q142.381 1197.7 145.992 1197.7 Q149.626 1197.7 151.431 1194.16 Q153.26 1190.59 153.26 1183.49 Q153.26 1176.36 151.431 1172.82 Q149.626 1169.25 145.992 1169.25 M145.992 1165.55 Q151.802 1165.55 154.857 1170.15 Q157.936 1174.74 157.936 1183.49 Q157.936 1192.21 154.857 1196.82 Q151.802 1201.4 145.992 1201.4 Q140.181 1201.4 137.103 1196.82 Q134.047 1192.21 134.047 1183.49 Q134.047 1174.74 137.103 1170.15 Q140.181 1165.55 145.992 1165.55 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M176.153 1169.25 Q172.542 1169.25 170.714 1172.82 Q168.908 1176.36 168.908 1183.49 Q168.908 1190.59 170.714 1194.16 Q172.542 1197.7 176.153 1197.7 Q179.788 1197.7 181.593 1194.16 Q183.422 1190.59 183.422 1183.49 Q183.422 1176.36 181.593 1172.82 Q179.788 1169.25 176.153 1169.25 M176.153 1165.55 Q181.964 1165.55 185.019 1170.15 Q188.098 1174.74 188.098 1183.49 Q188.098 1192.21 185.019 1196.82 Q181.964 1201.4 176.153 1201.4 Q170.343 1201.4 167.265 1196.82 Q164.209 1192.21 164.209 1183.49 Q164.209 1174.74 167.265 1170.15 Q170.343 1165.55 176.153 1165.55 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M224.487 1175.27 L213.908 1185.9 L224.487 1196.47 L221.732 1199.28 L211.107 1188.65 L200.482 1199.28 L197.751 1196.47 L208.306 1185.9 L197.751 1175.27 L200.482 1172.47 L211.107 1183.09 L221.732 1172.47 L224.487 1175.27 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M236.848 1196.8 L244.486 1196.8 L244.486 1170.43 L236.176 1172.1 L236.176 1167.84 L244.44 1166.17 L249.116 1166.17 L249.116 1196.8 L256.755 1196.8 L256.755 1200.73 L236.848 1200.73 L236.848 1196.8 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M276.199 1169.25 Q272.588 1169.25 270.759 1172.82 Q268.954 1176.36 268.954 1183.49 Q268.954 1190.59 270.759 1194.16 Q272.588 1197.7 276.199 1197.7 Q279.833 1197.7 281.639 1194.16 Q283.468 1190.59 283.468 1183.49 Q283.468 1176.36 281.639 1172.82 Q279.833 1169.25 276.199 1169.25 M276.199 1165.55 Q282.009 1165.55 285.065 1170.15 Q288.144 1174.74 288.144 1183.49 Q288.144 1192.21 285.065 1196.82 Q282.009 1201.4 276.199 1201.4 Q270.389 1201.4 267.31 1196.82 Q264.255 1192.21 264.255 1183.49 Q264.255 1174.74 267.31 1170.15 Q270.389 1165.55 276.199 1165.55 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M288.144 1159.65 L312.255 1159.65 L312.255 1162.85 L288.144 1162.85 L288.144 1159.65 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M321.114 1170.13 L327.32 1170.13 L327.32 1148.7 L320.568 1150.06 L320.568 1146.6 L327.283 1145.24 L331.082 1145.24 L331.082 1170.13 L337.288 1170.13 L337.288 1173.32 L321.114 1173.32 L321.114 1170.13 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M355.4 1148.55 L345.808 1163.54 L355.4 1163.54 L355.4 1148.55 M354.403 1145.24 L359.181 1145.24 L359.181 1163.54 L363.187 1163.54 L363.187 1166.7 L359.181 1166.7 L359.181 1173.32 L355.4 1173.32 L355.4 1166.7 L342.724 1166.7 L342.724 1163.04 L354.403 1145.24 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M52.1958 957.7 L81.8716 957.7 L81.8716 961.635 L52.1958 961.635 L52.1958 957.7 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M92.0104 939.968 L110.367 939.968 L110.367 943.904 L96.2928 943.904 L96.2928 952.376 Q97.3113 952.029 98.3298 951.866 Q99.3483 951.681 100.367 951.681 Q106.154 951.681 109.533 954.853 Q112.913 958.024 112.913 963.44 Q112.913 969.019 109.441 972.121 Q105.969 975.2 99.6493 975.2 Q97.4734 975.2 95.2049 974.829 Q92.9595 974.459 90.5521 973.718 L90.5521 969.019 Q92.6354 970.153 94.8576 970.709 Q97.0798 971.265 99.5567 971.265 Q103.561 971.265 105.899 969.158 Q108.237 967.052 108.237 963.44 Q108.237 959.829 105.899 957.723 Q103.561 955.616 99.5567 955.616 Q97.6817 955.616 95.8067 956.033 Q93.9549 956.45 92.0104 957.329 L92.0104 939.968 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M122.126 968.649 L127.01 968.649 L127.01 974.528 L122.126 974.528 L122.126 968.649 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M147.195 943.047 Q143.584 943.047 141.756 946.612 Q139.95 950.154 139.95 957.283 Q139.95 964.39 141.756 967.954 Q143.584 971.496 147.195 971.496 Q150.83 971.496 152.635 967.954 Q154.464 964.39 154.464 957.283 Q154.464 950.154 152.635 946.612 Q150.83 943.047 147.195 943.047 M147.195 939.343 Q153.005 939.343 156.061 943.95 Q159.14 948.533 159.14 957.283 Q159.14 966.01 156.061 970.616 Q153.005 975.2 147.195 975.2 Q141.385 975.2 138.306 970.616 Q135.251 966.01 135.251 957.283 Q135.251 948.533 138.306 943.95 Q141.385 939.343 147.195 939.343 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M177.357 943.047 Q173.746 943.047 171.917 946.612 Q170.112 950.154 170.112 957.283 Q170.112 964.39 171.917 967.954 Q173.746 971.496 177.357 971.496 Q180.991 971.496 182.797 967.954 Q184.626 964.39 184.626 957.283 Q184.626 950.154 182.797 946.612 Q180.991 943.047 177.357 943.047 M177.357 939.343 Q183.167 939.343 186.223 943.95 Q189.302 948.533 189.302 957.283 Q189.302 966.01 186.223 970.616 Q183.167 975.2 177.357 975.2 Q171.547 975.2 168.468 970.616 Q165.413 966.01 165.413 957.283 Q165.413 948.533 168.468 943.95 Q171.547 939.343 177.357 939.343 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M225.69 949.066 L215.112 959.691 L225.69 970.269 L222.936 973.07 L212.311 962.445 L201.686 973.07 L198.954 970.269 L209.51 959.691 L198.954 949.066 L201.686 946.265 L212.311 956.89 L222.936 946.265 L225.69 949.066 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M238.051 970.593 L245.69 970.593 L245.69 944.228 L237.38 945.894 L237.38 941.635 L245.644 939.968 L250.32 939.968 L250.32 970.593 L257.959 970.593 L257.959 974.528 L238.051 974.528 L238.051 970.593 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M277.403 943.047 Q273.792 943.047 271.963 946.612 Q270.158 950.154 270.158 957.283 Q270.158 964.39 271.963 967.954 Q273.792 971.496 277.403 971.496 Q281.037 971.496 282.843 967.954 Q284.671 964.39 284.671 957.283 Q284.671 950.154 282.843 946.612 Q281.037 943.047 277.403 943.047 M277.403 939.343 Q283.213 939.343 286.269 943.95 Q289.347 948.533 289.347 957.283 Q289.347 966.01 286.269 970.616 Q283.213 975.2 277.403 975.2 Q271.593 975.2 268.514 970.616 Q265.459 966.01 265.459 957.283 Q265.459 948.533 268.514 943.95 Q271.593 939.343 277.403 939.343 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M289.347 933.445 L313.459 933.445 L313.459 936.642 L289.347 936.642 L289.347 933.445 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M322.317 943.921 L328.524 943.921 L328.524 922.499 L321.772 923.853 L321.772 920.392 L328.486 919.038 L332.285 919.038 L332.285 943.921 L338.492 943.921 L338.492 947.118 L322.317 947.118 L322.317 943.921 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M346.203 919.038 L361.118 919.038 L361.118 922.235 L349.683 922.235 L349.683 929.119 Q350.51 928.837 351.338 928.705 Q352.165 928.555 352.993 928.555 Q357.695 928.555 360.441 931.131 Q363.187 933.708 363.187 938.109 Q363.187 942.642 360.365 945.162 Q357.544 947.663 352.41 947.663 Q350.642 947.663 348.799 947.362 Q346.974 947.062 345.018 946.46 L345.018 942.642 Q346.711 943.563 348.517 944.015 Q350.322 944.466 352.335 944.466 Q355.588 944.466 357.488 942.755 Q359.387 941.043 359.387 938.109 Q359.387 935.175 357.488 933.464 Q355.588 931.752 352.335 931.752 Q350.811 931.752 349.288 932.091 Q347.783 932.429 346.203 933.144 L346.203 919.038 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M351.242 710.395 Q347.631 710.395 345.802 713.959 Q343.997 717.501 343.997 724.631 Q343.997 731.737 345.802 735.302 Q347.631 738.843 351.242 738.843 Q354.876 738.843 356.682 735.302 Q358.511 731.737 358.511 724.631 Q358.511 717.501 356.682 713.959 Q354.876 710.395 351.242 710.395 M351.242 706.691 Q357.052 706.691 360.108 711.297 Q363.187 715.881 363.187 724.631 Q363.187 733.357 360.108 737.964 Q357.052 742.547 351.242 742.547 Q345.432 742.547 342.353 737.964 Q339.298 733.357 339.298 724.631 Q339.298 715.881 342.353 711.297 Q345.432 706.691 351.242 706.691 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M92.0104 487.559 L110.367 487.559 L110.367 491.494 L96.2928 491.494 L96.2928 499.966 Q97.3113 499.619 98.3298 499.457 Q99.3483 499.271 100.367 499.271 Q106.154 499.271 109.533 502.443 Q112.913 505.614 112.913 511.031 Q112.913 516.609 109.441 519.711 Q105.969 522.79 99.6493 522.79 Q97.4734 522.79 95.2049 522.419 Q92.9595 522.049 90.5521 521.308 L90.5521 516.609 Q92.6354 517.744 94.8576 518.299 Q97.0798 518.855 99.5567 518.855 Q103.561 518.855 105.899 516.748 Q108.237 514.642 108.237 511.031 Q108.237 507.42 105.899 505.313 Q103.561 503.207 99.5567 503.207 Q97.6817 503.207 95.8067 503.623 Q93.9549 504.04 92.0104 504.92 L92.0104 487.559 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M122.126 516.239 L127.01 516.239 L127.01 522.119 L122.126 522.119 L122.126 516.239 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M147.195 490.637 Q143.584 490.637 141.756 494.202 Q139.95 497.744 139.95 504.873 Q139.95 511.98 141.756 515.544 Q143.584 519.086 147.195 519.086 Q150.83 519.086 152.635 515.544 Q154.464 511.98 154.464 504.873 Q154.464 497.744 152.635 494.202 Q150.83 490.637 147.195 490.637 M147.195 486.934 Q153.005 486.934 156.061 491.54 Q159.14 496.123 159.14 504.873 Q159.14 513.6 156.061 518.207 Q153.005 522.79 147.195 522.79 Q141.385 522.79 138.306 518.207 Q135.251 513.6 135.251 504.873 Q135.251 496.123 138.306 491.54 Q141.385 486.934 147.195 486.934 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M177.357 490.637 Q173.746 490.637 171.917 494.202 Q170.112 497.744 170.112 504.873 Q170.112 511.98 171.917 515.544 Q173.746 519.086 177.357 519.086 Q180.991 519.086 182.797 515.544 Q184.626 511.98 184.626 504.873 Q184.626 497.744 182.797 494.202 Q180.991 490.637 177.357 490.637 M177.357 486.934 Q183.167 486.934 186.223 491.54 Q189.302 496.123 189.302 504.873 Q189.302 513.6 186.223 518.207 Q183.167 522.79 177.357 522.79 Q171.547 522.79 168.468 518.207 Q165.413 513.6 165.413 504.873 Q165.413 496.123 168.468 491.54 Q171.547 486.934 177.357 486.934 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M225.69 496.656 L215.112 507.281 L225.69 517.859 L222.936 520.66 L212.311 510.035 L201.686 520.66 L198.954 517.859 L209.51 507.281 L198.954 496.656 L201.686 493.855 L212.311 504.48 L222.936 493.855 L225.69 496.656 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M238.051 518.183 L245.69 518.183 L245.69 491.818 L237.38 493.484 L237.38 489.225 L245.644 487.559 L250.32 487.559 L250.32 518.183 L257.959 518.183 L257.959 522.119 L238.051 522.119 L238.051 518.183 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M277.403 490.637 Q273.792 490.637 271.963 494.202 Q270.158 497.744 270.158 504.873 Q270.158 511.98 271.963 515.544 Q273.792 519.086 277.403 519.086 Q281.037 519.086 282.843 515.544 Q284.671 511.98 284.671 504.873 Q284.671 497.744 282.843 494.202 Q281.037 490.637 277.403 490.637 M277.403 486.934 Q283.213 486.934 286.269 491.54 Q289.347 496.123 289.347 504.873 Q289.347 513.6 286.269 518.207 Q283.213 522.79 277.403 522.79 Q271.593 522.79 268.514 518.207 Q265.459 513.6 265.459 504.873 Q265.459 496.123 268.514 491.54 Q271.593 486.934 277.403 486.934 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M289.347 481.035 L313.459 481.035 L313.459 484.232 L289.347 484.232 L289.347 481.035 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M322.317 491.511 L328.524 491.511 L328.524 470.089 L321.772 471.443 L321.772 467.982 L328.486 466.628 L332.285 466.628 L332.285 491.511 L338.492 491.511 L338.492 494.708 L322.317 494.708 L322.317 491.511 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M346.203 466.628 L361.118 466.628 L361.118 469.825 L349.683 469.825 L349.683 476.709 Q350.51 476.427 351.338 476.295 Q352.165 476.145 352.993 476.145 Q357.695 476.145 360.441 478.722 Q363.187 481.298 363.187 485.699 Q363.187 490.232 360.365 492.752 Q357.544 495.254 352.41 495.254 Q350.642 495.254 348.799 494.953 Q346.974 494.652 345.018 494.05 L345.018 490.232 Q346.711 491.153 348.517 491.605 Q350.322 492.056 352.335 492.056 Q355.588 492.056 357.488 490.345 Q359.387 488.633 359.387 485.699 Q359.387 482.765 357.488 481.054 Q355.588 479.342 352.335 479.342 Q350.811 479.342 349.288 479.681 Q347.783 480.019 346.203 480.734 L346.203 466.628 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M91.5706 291.978 L99.2095 291.978 L99.2095 265.613 L90.8993 267.279 L90.8993 263.02 L99.1632 261.354 L103.839 261.354 L103.839 291.978 L111.478 291.978 L111.478 295.914 L91.5706 295.914 L91.5706 291.978 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M120.922 290.034 L125.807 290.034 L125.807 295.914 L120.922 295.914 L120.922 290.034 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M145.992 264.432 Q142.381 264.432 140.552 267.997 Q138.746 271.539 138.746 278.668 Q138.746 285.775 140.552 289.34 Q142.381 292.881 145.992 292.881 Q149.626 292.881 151.431 289.34 Q153.26 285.775 153.26 278.668 Q153.26 271.539 151.431 267.997 Q149.626 264.432 145.992 264.432 M145.992 260.729 Q151.802 260.729 154.857 265.335 Q157.936 269.918 157.936 278.668 Q157.936 287.395 154.857 292.002 Q151.802 296.585 145.992 296.585 Q140.181 296.585 137.103 292.002 Q134.047 287.395 134.047 278.668 Q134.047 269.918 137.103 265.335 Q140.181 260.729 145.992 260.729 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M176.153 264.432 Q172.542 264.432 170.714 267.997 Q168.908 271.539 168.908 278.668 Q168.908 285.775 170.714 289.34 Q172.542 292.881 176.153 292.881 Q179.788 292.881 181.593 289.34 Q183.422 285.775 183.422 278.668 Q183.422 271.539 181.593 267.997 Q179.788 264.432 176.153 264.432 M176.153 260.729 Q181.964 260.729 185.019 265.335 Q188.098 269.918 188.098 278.668 Q188.098 287.395 185.019 292.002 Q181.964 296.585 176.153 296.585 Q170.343 296.585 167.265 292.002 Q164.209 287.395 164.209 278.668 Q164.209 269.918 167.265 265.335 Q170.343 260.729 176.153 260.729 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M224.487 270.451 L213.908 281.076 L224.487 291.654 L221.732 294.455 L211.107 283.83 L200.482 294.455 L197.751 291.654 L208.306 281.076 L197.751 270.451 L200.482 267.65 L211.107 278.275 L221.732 267.65 L224.487 270.451 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M236.848 291.978 L244.486 291.978 L244.486 265.613 L236.176 267.279 L236.176 263.02 L244.44 261.354 L249.116 261.354 L249.116 291.978 L256.755 291.978 L256.755 295.914 L236.848 295.914 L236.848 291.978 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M276.199 264.432 Q272.588 264.432 270.759 267.997 Q268.954 271.539 268.954 278.668 Q268.954 285.775 270.759 289.34 Q272.588 292.881 276.199 292.881 Q279.833 292.881 281.639 289.34 Q283.468 285.775 283.468 278.668 Q283.468 271.539 281.639 267.997 Q279.833 264.432 276.199 264.432 M276.199 260.729 Q282.009 260.729 285.065 265.335 Q288.144 269.918 288.144 278.668 Q288.144 287.395 285.065 292.002 Q282.009 296.585 276.199 296.585 Q270.389 296.585 267.31 292.002 Q264.255 287.395 264.255 278.668 Q264.255 269.918 267.31 265.335 Q270.389 260.729 276.199 260.729 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M288.144 254.83 L312.255 254.83 L312.255 258.027 L288.144 258.027 L288.144 254.83 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M321.114 265.306 L327.32 265.306 L327.32 243.884 L320.568 245.238 L320.568 241.777 L327.283 240.423 L331.082 240.423 L331.082 265.306 L337.288 265.306 L337.288 268.503 L321.114 268.503 L321.114 265.306 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M355.4 243.733 L345.808 258.723 L355.4 258.723 L355.4 243.733 M354.403 240.423 L359.181 240.423 L359.181 258.723 L363.187 258.723 L363.187 261.883 L359.181 261.883 L359.181 268.503 L355.4 268.503 L355.4 261.883 L342.724 261.883 L342.724 258.215 L354.403 240.423 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M881.579 12.096 L919.819 12.096 L919.819 18.9825 L889.761 18.9825 L889.761 36.8875 L918.563 36.8875 L918.563 43.7741 L889.761 43.7741 L889.761 65.6895 L920.548 65.6895 L920.548 72.576 L881.579 72.576 L881.579 12.096 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M971.387 27.2059 L954.981 49.2833 L972.238 72.576 L963.447 72.576 L950.241 54.752 L937.036 72.576 L928.245 72.576 L945.867 48.8377 L929.744 27.2059 L938.534 27.2059 L950.566 43.369 L962.597 27.2059 L971.387 27.2059 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M989.981 65.7705 L989.981 89.8329 L982.487 89.8329 L982.487 27.2059 L989.981 27.2059 L989.981 34.0924 Q992.33 30.0415 995.895 28.0971 Q999.5 26.1121 1004.48 26.1121 Q1012.75 26.1121 1017.89 32.6746 Q1023.08 39.2371 1023.08 49.9314 Q1023.08 60.6258 1017.89 67.1883 Q1012.75 73.7508 1004.48 73.7508 Q999.5 73.7508 995.895 71.8063 Q992.33 69.8214 989.981 65.7705 M1015.34 49.9314 Q1015.34 41.7081 1011.94 37.0496 Q1008.57 32.3505 1002.66 32.3505 Q996.746 32.3505 993.343 37.0496 Q989.981 41.7081 989.981 49.9314 Q989.981 58.1548 993.343 62.8538 Q996.746 67.5124 1002.66 67.5124 Q1008.57 67.5124 1011.94 62.8538 Q1015.34 58.1548 1015.34 49.9314 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1056.05 49.7694 Q1047.02 49.7694 1043.53 51.8354 Q1040.05 53.9013 1040.05 58.8839 Q1040.05 62.8538 1042.64 65.2034 Q1045.28 67.5124 1049.77 67.5124 Q1055.97 67.5124 1059.7 63.1374 Q1063.46 58.7219 1063.46 51.4303 L1063.46 49.7694 L1056.05 49.7694 M1070.92 46.6907 L1070.92 72.576 L1063.46 72.576 L1063.46 65.6895 Q1060.91 69.8214 1057.1 71.8063 Q1053.3 73.7508 1047.79 73.7508 Q1040.82 73.7508 1036.69 69.8619 Q1032.6 65.9325 1032.6 59.3701 Q1032.6 51.7138 1037.7 47.825 Q1042.85 43.9361 1053.01 43.9361 L1063.46 43.9361 L1063.46 43.2069 Q1063.46 38.0623 1060.06 35.2672 Q1056.7 32.4315 1050.58 32.4315 Q1046.69 32.4315 1043.01 33.3632 Q1039.32 34.295 1035.92 36.1584 L1035.92 29.2718 Q1040.01 27.692 1043.86 26.9223 Q1047.71 26.1121 1051.35 26.1121 Q1061.2 26.1121 1066.06 31.2163 Q1070.92 36.3204 1070.92 46.6907 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1123.98 45.1919 L1123.98 72.576 L1116.53 72.576 L1116.53 45.4349 Q1116.53 38.994 1114.02 35.7938 Q1111.51 32.5936 1106.48 32.5936 Q1100.45 32.5936 1096.97 36.4419 Q1093.48 40.2903 1093.48 46.9338 L1093.48 72.576 L1085.99 72.576 L1085.99 27.2059 L1093.48 27.2059 L1093.48 34.2544 Q1096.16 30.163 1099.76 28.1376 Q1103.41 26.1121 1108.15 26.1121 Q1115.96 26.1121 1119.97 30.9732 Q1123.98 35.7938 1123.98 45.1919 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1167.78 28.5427 L1167.78 35.5912 Q1164.62 33.9709 1161.21 33.1607 Q1157.81 32.3505 1154.16 32.3505 Q1148.61 32.3505 1145.82 34.0519 Q1143.06 35.7533 1143.06 39.156 Q1143.06 41.7486 1145.05 43.2475 Q1147.03 44.7058 1153.03 46.0426 L1155.58 46.6097 Q1163.52 48.3111 1166.84 51.4303 Q1170.21 54.509 1170.21 60.0587 Q1170.21 66.3781 1165.18 70.0644 Q1160.2 73.7508 1151.45 73.7508 Q1147.8 73.7508 1143.83 73.0216 Q1139.9 72.3329 1135.53 70.9151 L1135.53 63.2184 Q1139.66 65.3654 1143.67 66.4591 Q1147.68 67.5124 1151.61 67.5124 Q1156.88 67.5124 1159.71 65.73 Q1162.55 63.9071 1162.55 60.6258 Q1162.55 57.5877 1160.48 55.9673 Q1158.46 54.3469 1151.53 52.8481 L1148.94 52.2405 Q1142.01 50.7821 1138.93 47.7845 Q1135.85 44.7463 1135.85 39.4801 Q1135.85 33.0797 1140.39 29.5959 Q1144.93 26.1121 1153.27 26.1121 Q1157.4 26.1121 1161.05 26.7198 Q1164.7 27.3274 1167.78 28.5427 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1182.07 27.2059 L1189.53 27.2059 L1189.53 72.576 L1182.07 72.576 L1182.07 27.2059 M1182.07 9.54393 L1189.53 9.54393 L1189.53 18.9825 L1182.07 18.9825 L1182.07 9.54393 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1222.71 32.4315 Q1216.71 32.4315 1213.23 37.1306 Q1209.74 41.7891 1209.74 49.9314 Q1209.74 58.0738 1213.19 62.7728 Q1216.67 67.4314 1222.71 67.4314 Q1228.66 67.4314 1232.14 62.7323 Q1235.63 58.0333 1235.63 49.9314 Q1235.63 41.8701 1232.14 37.1711 Q1228.66 32.4315 1222.71 32.4315 M1222.71 26.1121 Q1232.43 26.1121 1237.98 32.4315 Q1243.53 38.7509 1243.53 49.9314 Q1243.53 61.0714 1237.98 67.4314 Q1232.43 73.7508 1222.71 73.7508 Q1212.94 73.7508 1207.39 67.4314 Q1201.88 61.0714 1201.88 49.9314 Q1201.88 38.7509 1207.39 32.4315 Q1212.94 26.1121 1222.71 26.1121 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1293.6 45.1919 L1293.6 72.576 L1286.14 72.576 L1286.14 45.4349 Q1286.14 38.994 1283.63 35.7938 Q1281.12 32.5936 1276.1 32.5936 Q1270.06 32.5936 1266.58 36.4419 Q1263.09 40.2903 1263.09 46.9338 L1263.09 72.576 L1255.6 72.576 L1255.6 27.2059 L1263.09 27.2059 L1263.09 34.2544 Q1265.77 30.163 1269.37 28.1376 Q1273.02 26.1121 1277.76 26.1121 Q1285.58 26.1121 1289.59 30.9732 Q1293.6 35.7938 1293.6 45.1919 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1329.49 27.2059 L1337.39 27.2059 L1351.56 65.2844 L1365.74 27.2059 L1373.64 27.2059 L1356.63 72.576 L1346.5 72.576 L1329.49 27.2059 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1412.85 28.5427 L1412.85 35.5912 Q1409.7 33.9709 1406.29 33.1607 Q1402.89 32.3505 1399.24 32.3505 Q1393.69 32.3505 1390.9 34.0519 Q1388.14 35.7533 1388.14 39.156 Q1388.14 41.7486 1390.13 43.2475 Q1392.11 44.7058 1398.11 46.0426 L1400.66 46.6097 Q1408.6 48.3111 1411.92 51.4303 Q1415.29 54.509 1415.29 60.0587 Q1415.29 66.3781 1410.26 70.0644 Q1405.28 73.7508 1396.53 73.7508 Q1392.88 73.7508 1388.91 73.0216 Q1384.98 72.3329 1380.61 70.9151 L1380.61 63.2184 Q1384.74 65.3654 1388.75 66.4591 Q1392.76 67.5124 1396.69 67.5124 Q1401.96 67.5124 1404.79 65.73 Q1407.63 63.9071 1407.63 60.6258 Q1407.63 57.5877 1405.56 55.9673 Q1403.54 54.3469 1396.61 52.8481 L1394.02 52.2405 Q1387.09 50.7821 1384.01 47.7845 Q1380.93 44.7463 1380.93 39.4801 Q1380.93 33.0797 1385.47 29.5959 Q1390.01 26.1121 1398.35 26.1121 Q1402.48 26.1121 1406.13 26.7198 Q1409.78 27.3274 1412.85 28.5427 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1453.85 12.096 L1488.61 12.096 L1488.61 18.9825 L1462.03 18.9825 L1462.03 36.8065 L1486.01 36.8065 L1486.01 43.6931 L1462.03 43.6931 L1462.03 72.576 L1453.85 72.576 L1453.85 12.096 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1514.25 49.7694 Q1505.22 49.7694 1501.73 51.8354 Q1498.25 53.9013 1498.25 58.8839 Q1498.25 62.8538 1500.84 65.2034 Q1503.47 67.5124 1507.97 67.5124 Q1514.17 67.5124 1517.89 63.1374 Q1521.66 58.7219 1521.66 51.4303 L1521.66 49.7694 L1514.25 49.7694 M1529.12 46.6907 L1529.12 72.576 L1521.66 72.576 L1521.66 65.6895 Q1519.11 69.8214 1515.3 71.8063 Q1511.49 73.7508 1505.99 73.7508 Q1499.02 73.7508 1494.89 69.8619 Q1490.79 65.9325 1490.79 59.3701 Q1490.79 51.7138 1495.9 47.825 Q1501.04 43.9361 1511.21 43.9361 L1521.66 43.9361 L1521.66 43.2069 Q1521.66 38.0623 1518.26 35.2672 Q1514.9 32.4315 1508.78 32.4315 Q1504.89 32.4315 1501.2 33.3632 Q1497.52 34.295 1494.12 36.1584 L1494.12 29.2718 Q1498.21 27.692 1502.06 26.9223 Q1505.9 26.1121 1509.55 26.1121 Q1519.39 26.1121 1524.25 31.2163 Q1529.12 36.3204 1529.12 46.6907 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1551.84 14.324 L1551.84 27.2059 L1567.19 27.2059 L1567.19 32.9987 L1551.84 32.9987 L1551.84 57.6282 Q1551.84 63.1779 1553.34 64.7578 Q1554.88 66.3376 1559.54 66.3376 L1567.19 66.3376 L1567.19 72.576 L1559.54 72.576 Q1550.91 72.576 1547.63 69.3758 Q1544.35 66.1351 1544.35 57.6282 L1544.35 32.9987 L1538.88 32.9987 L1538.88 27.2059 L1544.35 27.2059 L1544.35 14.324 L1551.84 14.324 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1594.58 32.4315 Q1588.58 32.4315 1585.1 37.1306 Q1581.62 41.7891 1581.62 49.9314 Q1581.62 58.0738 1585.06 62.7728 Q1588.54 67.4314 1594.58 67.4314 Q1600.53 67.4314 1604.02 62.7323 Q1607.5 58.0333 1607.5 49.9314 Q1607.5 41.8701 1604.02 37.1711 Q1600.53 32.4315 1594.58 32.4315 M1594.58 26.1121 Q1604.3 26.1121 1609.85 32.4315 Q1615.4 38.7509 1615.4 49.9314 Q1615.4 61.0714 1609.85 67.4314 Q1604.3 73.7508 1594.58 73.7508 Q1584.82 73.7508 1579.27 67.4314 Q1573.76 61.0714 1573.76 49.9314 Q1573.76 38.7509 1579.27 32.4315 Q1584.82 26.1121 1594.58 26.1121 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1654.05 34.1734 Q1652.79 33.4443 1651.29 33.1202 Q1649.83 32.7556 1648.05 32.7556 Q1641.73 32.7556 1638.33 36.8875 Q1634.97 40.9789 1634.97 48.6757 L1634.97 72.576 L1627.47 72.576 L1627.47 27.2059 L1634.97 27.2059 L1634.97 34.2544 Q1637.32 30.1225 1641.08 28.1376 Q1644.85 26.1121 1650.24 26.1121 Q1651.01 26.1121 1651.94 26.2337 Q1652.87 26.3147 1654.01 26.5172 L1654.05 34.1734 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1661.86 27.2059 L1669.32 27.2059 L1669.32 72.576 L1661.86 72.576 L1661.86 27.2059 M1661.86 9.54393 L1669.32 9.54393 L1669.32 18.9825 L1661.86 18.9825 L1661.86 9.54393 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1681.67 27.2059 L1717.08 27.2059 L1717.08 34.0114 L1689.05 66.6212 L1717.08 66.6212 L1717.08 72.576 L1680.66 72.576 L1680.66 65.7705 L1708.69 33.1607 L1681.67 33.1607 L1681.67 27.2059 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1749.08 49.7694 Q1740.05 49.7694 1736.56 51.8354 Q1733.08 53.9013 1733.08 58.8839 Q1733.08 62.8538 1735.67 65.2034 Q1738.3 67.5124 1742.8 67.5124 Q1749 67.5124 1752.73 63.1374 Q1756.49 58.7219 1756.49 51.4303 L1756.49 49.7694 L1749.08 49.7694 M1763.95 46.6907 L1763.95 72.576 L1756.49 72.576 L1756.49 65.6895 Q1753.94 69.8214 1750.13 71.8063 Q1746.33 73.7508 1740.82 73.7508 Q1733.85 73.7508 1729.72 69.8619 Q1725.63 65.9325 1725.63 59.3701 Q1725.63 51.7138 1730.73 47.825 Q1735.87 43.9361 1746.04 43.9361 L1756.49 43.9361 L1756.49 43.2069 Q1756.49 38.0623 1753.09 35.2672 Q1749.73 32.4315 1743.61 32.4315 Q1739.72 32.4315 1736.04 33.3632 Q1732.35 34.295 1728.95 36.1584 L1728.95 29.2718 Q1733.04 27.692 1736.89 26.9223 Q1740.73 26.1121 1744.38 26.1121 Q1754.22 26.1121 1759.09 31.2163 Q1763.95 36.3204 1763.95 46.6907 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1809.15 34.0924 L1809.15 9.54393 L1816.61 9.54393 L1816.61 72.576 L1809.15 72.576 L1809.15 65.7705 Q1806.81 69.8214 1803.2 71.8063 Q1799.64 73.7508 1794.61 73.7508 Q1786.39 73.7508 1781.2 67.1883 Q1776.06 60.6258 1776.06 49.9314 Q1776.06 39.2371 1781.2 32.6746 Q1786.39 26.1121 1794.61 26.1121 Q1799.64 26.1121 1803.2 28.0971 Q1806.81 30.0415 1809.15 34.0924 M1783.76 49.9314 Q1783.76 58.1548 1787.12 62.8538 Q1790.52 67.5124 1796.43 67.5124 Q1802.35 67.5124 1805.75 62.8538 Q1809.15 58.1548 1809.15 49.9314 Q1809.15 41.7081 1805.75 37.0496 Q1802.35 32.3505 1796.43 32.3505 Q1790.52 32.3505 1787.12 37.0496 Q1783.76 41.7081 1783.76 49.9314 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1849.54 32.4315 Q1843.55 32.4315 1840.06 37.1306 Q1836.58 41.7891 1836.58 49.9314 Q1836.58 58.0738 1840.02 62.7728 Q1843.51 67.4314 1849.54 67.4314 Q1855.5 67.4314 1858.98 62.7323 Q1862.46 58.0333 1862.46 49.9314 Q1862.46 41.8701 1858.98 37.1711 Q1855.5 32.4315 1849.54 32.4315 M1849.54 26.1121 Q1859.26 26.1121 1864.81 32.4315 Q1870.36 38.7509 1870.36 49.9314 Q1870.36 61.0714 1864.81 67.4314 Q1859.26 73.7508 1849.54 73.7508 Q1839.78 73.7508 1834.23 67.4314 Q1828.72 61.0714 1828.72 49.9314 Q1828.72 38.7509 1834.23 32.4315 Q1839.78 26.1121 1849.54 26.1121 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip112)\" style=\"stroke:#009af9; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  454.476,725.337 472.906,725.239 491.336,725.153 509.766,725.077 528.196,725.009 546.626,724.95 565.056,724.899 583.486,724.854 601.916,724.815 620.345,724.781 \n",
       "  638.775,724.751 657.205,724.726 675.635,724.704 694.065,724.686 712.495,724.67 730.925,724.657 749.355,724.646 767.785,724.636 786.215,724.628 804.644,724.622 \n",
       "  823.074,724.617 841.504,724.612 859.934,724.609 878.364,724.606 896.794,724.603 915.224,724.602 933.654,724.6 952.084,724.599 970.513,724.598 988.943,724.598 \n",
       "  1007.37,724.597 1025.8,724.597 1044.23,724.596 1062.66,724.596 1081.09,724.596 1099.52,724.596 1117.95,724.596 1136.38,724.596 1154.81,724.596 1173.24,724.596 \n",
       "  1191.67,724.596 1210.1,724.596 1228.53,724.596 1246.96,724.596 1265.39,724.596 1283.82,724.596 1302.25,724.596 1320.68,724.596 1339.11,724.596 1357.54,724.596 \n",
       "  1375.97,724.596 1394.4,724.596 1412.83,724.596 1431.26,724.596 1449.69,724.596 1468.12,724.596 1486.55,724.596 1504.98,724.596 1523.41,724.596 1541.84,724.596 \n",
       "  1560.27,724.596 1578.7,724.596 1597.13,724.596 1615.56,724.596 1633.99,724.596 1652.42,724.596 1670.85,724.596 1689.28,724.595 1707.71,724.595 1726.14,724.595 \n",
       "  1744.57,724.595 1763,724.594 1781.43,724.593 1799.86,724.593 1818.29,724.592 1836.72,724.59 1855.15,724.588 1873.58,724.586 1892.01,724.583 1910.44,724.579 \n",
       "  1928.87,724.575 1947.3,724.57 1965.73,724.563 1984.16,724.555 2002.59,724.546 2021.02,724.535 2039.45,724.522 2057.88,724.506 2076.31,724.487 2094.74,724.466 \n",
       "  2113.17,724.44 2131.6,724.411 2150.03,724.377 2168.46,724.338 2186.89,724.293 2205.32,724.241 2223.75,724.182 2242.18,724.115 2260.61,724.039 2279.04,723.952 \n",
       "  2297.47,723.855 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip112)\" style=\"stroke:#e26f46; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  454.476,764.778 472.906,965.688 491.336,644.232 509.766,1126.42 528.196,322.775 546.626,804.96 565.056,965.688 583.486,483.503 601.916,845.142 620.345,684.414 \n",
       "  638.775,1005.87 657.205,684.414 675.635,684.414 694.065,362.957 712.495,1005.87 730.925,845.142 749.355,724.596 767.785,885.324 786.215,1046.05 804.644,403.139 \n",
       "  823.074,403.139 841.504,885.324 859.934,885.324 878.364,724.596 896.794,604.05 915.224,764.778 933.654,764.778 952.084,604.05 970.513,443.321 988.943,925.506 \n",
       "  1007.37,604.05 1025.8,644.232 1044.23,965.688 1062.66,804.96 1081.09,644.232 1099.52,804.96 1117.95,644.232 1136.38,483.503 1154.81,644.232 1173.24,684.414 \n",
       "  1191.67,684.414 1210.1,684.414 1228.53,1166.6 1246.96,1005.87 1265.39,1005.87 1283.82,684.414 1302.25,845.142 1320.68,403.139 1339.11,885.324 1357.54,563.868 \n",
       "  1375.97,724.596 1394.4,1046.05 1412.83,403.139 1431.26,724.596 1449.69,604.05 1468.12,443.321 1486.55,764.778 1504.98,604.05 1523.41,925.506 1541.84,1246.96 \n",
       "  1560.27,1246.96 1578.7,443.321 1597.13,804.96 1615.56,965.688 1633.99,1447.87 1652.42,483.503 1670.85,162.047 1689.28,1126.42 1707.71,483.503 1726.14,644.232 \n",
       "  1744.57,523.686 1763,202.229 1781.43,845.142 1799.86,523.686 1818.29,684.414 1836.72,845.142 1855.15,1166.6 1873.58,403.139 1892.01,885.324 1910.44,724.596 \n",
       "  1928.87,724.596 1947.3,885.324 1965.73,724.596 1984.16,724.596 2002.59,724.596 2021.02,925.506 2039.45,443.321 2057.88,443.321 2076.31,604.05 2094.74,604.05 \n",
       "  2113.17,764.778 2131.6,604.05 2150.03,604.05 2168.46,483.503 2186.89,804.96 2205.32,965.688 2223.75,804.96 2242.18,644.232 2260.61,644.232 2279.04,804.96 \n",
       "  2297.47,845.142 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip110)\" d=\"\n",
       "M1726.8 324.425 L2287.64 324.425 L2287.64 168.905 L1726.8 168.905  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1726.8,324.425 2287.64,324.425 2287.64,168.905 1726.8,168.905 1726.8,324.425 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip110)\" style=\"stroke:#009af9; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1748.51,220.745 1878.75,220.745 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip110)\" d=\"M1900.45 202.006 L1910.27 202.006 L1910.27 205.316 L1904.71 205.316 L1904.71 240.964 L1910.27 240.964 L1910.27 244.275 L1900.45 244.275 L1900.45 202.006 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1923.37 203.465 L1923.37 216.312 L1919.43 216.312 L1919.43 203.465 L1923.37 203.465 M1932.12 203.465 L1932.12 216.312 L1928.18 216.312 L1928.18 203.465 L1932.12 203.465 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1941.33 203.465 L1961.19 203.465 L1961.19 207.4 L1946.01 207.4 L1946.01 217.585 L1959.71 217.585 L1959.71 221.52 L1946.01 221.52 L1946.01 238.025 L1941.33 238.025 L1941.33 203.465 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1975.85 224.992 Q1970.68 224.992 1968.69 226.173 Q1966.7 227.353 1966.7 230.201 Q1966.7 232.469 1968.18 233.812 Q1969.69 235.131 1972.26 235.131 Q1975.8 235.131 1977.93 232.631 Q1980.08 230.108 1980.08 225.941 L1980.08 224.992 L1975.85 224.992 M1984.34 223.233 L1984.34 238.025 L1980.08 238.025 L1980.08 234.089 Q1978.62 236.451 1976.45 237.585 Q1974.27 238.696 1971.12 238.696 Q1967.14 238.696 1964.78 236.474 Q1962.44 234.228 1962.44 230.478 Q1962.44 226.103 1965.36 223.881 Q1968.3 221.659 1974.11 221.659 L1980.08 221.659 L1980.08 221.242 Q1980.08 218.303 1978.14 216.705 Q1976.22 215.085 1972.72 215.085 Q1970.5 215.085 1968.39 215.617 Q1966.29 216.15 1964.34 217.215 L1964.34 213.279 Q1966.68 212.377 1968.88 211.937 Q1971.08 211.474 1973.16 211.474 Q1978.79 211.474 1981.56 214.391 Q1984.34 217.307 1984.34 223.233 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2011.77 213.094 L2011.77 217.076 Q2009.97 216.08 2008.14 215.594 Q2006.33 215.085 2004.48 215.085 Q2000.34 215.085 1998.05 217.724 Q1995.75 220.34 1995.75 225.085 Q1995.75 229.83 1998.05 232.469 Q2000.34 235.085 2004.48 235.085 Q2006.33 235.085 2008.14 234.599 Q2009.97 234.089 2011.77 233.094 L2011.77 237.029 Q2009.99 237.863 2008.07 238.279 Q2006.17 238.696 2004.02 238.696 Q1998.16 238.696 1994.71 235.015 Q1991.26 231.335 1991.26 225.085 Q1991.26 218.742 1994.73 215.108 Q1998.23 211.474 2004.3 211.474 Q2006.26 211.474 2008.14 211.891 Q2010.01 212.284 2011.77 213.094 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2023.39 204.738 L2023.39 212.099 L2032.17 212.099 L2032.17 215.409 L2023.39 215.409 L2023.39 229.483 Q2023.39 232.654 2024.25 233.557 Q2025.13 234.46 2027.79 234.46 L2032.17 234.46 L2032.17 238.025 L2027.79 238.025 Q2022.86 238.025 2020.98 236.196 Q2019.11 234.344 2019.11 229.483 L2019.11 215.409 L2015.98 215.409 L2015.98 212.099 L2019.11 212.099 L2019.11 204.738 L2023.39 204.738 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2047.81 215.085 Q2044.39 215.085 2042.4 217.77 Q2040.41 220.432 2040.41 225.085 Q2040.41 229.738 2042.37 232.423 Q2044.36 235.085 2047.81 235.085 Q2051.22 235.085 2053.21 232.4 Q2055.2 229.715 2055.2 225.085 Q2055.2 220.478 2053.21 217.793 Q2051.22 215.085 2047.81 215.085 M2047.81 211.474 Q2053.37 211.474 2056.54 215.085 Q2059.71 218.696 2059.71 225.085 Q2059.71 231.451 2056.54 235.085 Q2053.37 238.696 2047.81 238.696 Q2042.23 238.696 2039.06 235.085 Q2035.92 231.451 2035.92 225.085 Q2035.92 218.696 2039.06 215.085 Q2042.23 211.474 2047.81 211.474 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2081.79 216.08 Q2081.08 215.664 2080.22 215.478 Q2079.39 215.27 2078.37 215.27 Q2074.76 215.27 2072.81 217.631 Q2070.89 219.969 2070.89 224.367 L2070.89 238.025 L2066.61 238.025 L2066.61 212.099 L2070.89 212.099 L2070.89 216.127 Q2072.23 213.766 2074.39 212.631 Q2076.54 211.474 2079.62 211.474 Q2080.06 211.474 2080.59 211.543 Q2081.12 211.59 2081.77 211.705 L2081.79 216.08 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2086.26 212.099 L2090.52 212.099 L2090.52 238.025 L2086.26 238.025 L2086.26 212.099 M2086.26 202.006 L2090.52 202.006 L2090.52 207.4 L2086.26 207.4 L2086.26 202.006 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2097.58 212.099 L2117.81 212.099 L2117.81 215.988 L2101.79 234.622 L2117.81 234.622 L2117.81 238.025 L2097 238.025 L2097 234.136 L2113.02 215.502 L2097.58 215.502 L2097.58 212.099 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2136.1 224.992 Q2130.94 224.992 2128.95 226.173 Q2126.96 227.353 2126.96 230.201 Q2126.96 232.469 2128.44 233.812 Q2129.94 235.131 2132.51 235.131 Q2136.05 235.131 2138.18 232.631 Q2140.34 230.108 2140.34 225.941 L2140.34 224.992 L2136.1 224.992 M2144.6 223.233 L2144.6 238.025 L2140.34 238.025 L2140.34 234.089 Q2138.88 236.451 2136.7 237.585 Q2134.53 238.696 2131.38 238.696 Q2127.4 238.696 2125.04 236.474 Q2122.7 234.228 2122.7 230.478 Q2122.7 226.103 2125.61 223.881 Q2128.55 221.659 2134.36 221.659 L2140.34 221.659 L2140.34 221.242 Q2140.34 218.303 2138.39 216.705 Q2136.47 215.085 2132.97 215.085 Q2130.75 215.085 2128.65 215.617 Q2126.54 216.15 2124.6 217.215 L2124.6 213.279 Q2126.93 212.377 2129.13 211.937 Q2131.33 211.474 2133.41 211.474 Q2139.04 211.474 2141.82 214.391 Q2144.6 217.307 2144.6 223.233 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2170.43 216.034 L2170.43 202.006 L2174.69 202.006 L2174.69 238.025 L2170.43 238.025 L2170.43 234.136 Q2169.09 236.451 2167.03 237.585 Q2164.99 238.696 2162.12 238.696 Q2157.42 238.696 2154.46 234.946 Q2151.52 231.196 2151.52 225.085 Q2151.52 218.974 2154.46 215.224 Q2157.42 211.474 2162.12 211.474 Q2164.99 211.474 2167.03 212.608 Q2169.09 213.719 2170.43 216.034 M2155.91 225.085 Q2155.91 229.784 2157.84 232.469 Q2159.78 235.131 2163.16 235.131 Q2166.54 235.131 2168.48 232.469 Q2170.43 229.784 2170.43 225.085 Q2170.43 220.386 2168.48 217.724 Q2166.54 215.039 2163.16 215.039 Q2159.78 215.039 2157.84 217.724 Q2155.91 220.386 2155.91 225.085 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2193.51 215.085 Q2190.08 215.085 2188.09 217.77 Q2186.1 220.432 2186.1 225.085 Q2186.1 229.738 2188.07 232.423 Q2190.06 235.085 2193.51 235.085 Q2196.91 235.085 2198.9 232.4 Q2200.89 229.715 2200.89 225.085 Q2200.89 220.478 2198.9 217.793 Q2196.91 215.085 2193.51 215.085 M2193.51 211.474 Q2199.06 211.474 2202.23 215.085 Q2205.41 218.696 2205.41 225.085 Q2205.41 231.451 2202.23 235.085 Q2199.06 238.696 2193.51 238.696 Q2187.93 238.696 2184.76 235.085 Q2181.61 231.451 2181.61 225.085 Q2181.61 218.696 2184.76 215.085 Q2187.93 211.474 2193.51 211.474 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2216.49 203.465 L2216.49 216.312 L2212.56 216.312 L2212.56 203.465 L2216.49 203.465 M2225.24 203.465 L2225.24 216.312 L2221.31 216.312 L2221.31 203.465 L2225.24 203.465 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2244.22 202.006 L2244.22 244.275 L2234.41 244.275 L2234.41 240.964 L2239.94 240.964 L2239.94 205.316 L2234.41 205.316 L2234.41 202.006 L2244.22 202.006 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip110)\" style=\"stroke:#e26f46; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1748.51,272.585 1878.75,272.585 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip110)\" d=\"M1900.45 253.846 L1910.27 253.846 L1910.27 257.156 L1904.71 257.156 L1904.71 292.804 L1910.27 292.804 L1910.27 296.115 L1900.45 296.115 L1900.45 253.846 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1923.37 255.305 L1923.37 268.152 L1919.43 268.152 L1919.43 255.305 L1923.37 255.305 M1932.12 255.305 L1932.12 268.152 L1928.18 268.152 L1928.18 255.305 L1932.12 255.305 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1941.33 255.305 L1963.18 255.305 L1963.18 259.24 L1946.01 259.24 L1946.01 269.471 L1962.47 269.471 L1962.47 273.406 L1946.01 273.406 L1946.01 285.929 L1963.6 285.929 L1963.6 289.865 L1941.33 289.865 L1941.33 255.305 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M1992.65 263.939 L1983.28 276.555 L1993.14 289.865 L1988.11 289.865 L1980.57 279.68 L1973.02 289.865 L1968 289.865 L1978.07 276.3 L1968.86 263.939 L1973.88 263.939 L1980.75 273.175 L1987.63 263.939 L1992.65 263.939 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2003.28 285.976 L2003.28 299.726 L1998.99 299.726 L1998.99 263.939 L2003.28 263.939 L2003.28 267.874 Q2004.62 265.559 2006.66 264.448 Q2008.72 263.314 2011.56 263.314 Q2016.29 263.314 2019.23 267.064 Q2022.19 270.814 2022.19 276.925 Q2022.19 283.036 2019.23 286.786 Q2016.29 290.536 2011.56 290.536 Q2008.72 290.536 2006.66 289.425 Q2004.62 288.291 2003.28 285.976 M2017.77 276.925 Q2017.77 272.226 2015.82 269.564 Q2013.9 266.879 2010.52 266.879 Q2007.14 266.879 2005.2 269.564 Q2003.28 272.226 2003.28 276.925 Q2003.28 281.624 2005.2 284.309 Q2007.14 286.971 2010.52 286.971 Q2013.9 286.971 2015.82 284.309 Q2017.77 281.624 2017.77 276.925 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2041.03 276.832 Q2035.87 276.832 2033.88 278.013 Q2031.89 279.193 2031.89 282.041 Q2031.89 284.309 2033.37 285.652 Q2034.87 286.971 2037.44 286.971 Q2040.98 286.971 2043.11 284.471 Q2045.27 281.948 2045.27 277.781 L2045.27 276.832 L2041.03 276.832 M2049.53 275.073 L2049.53 289.865 L2045.27 289.865 L2045.27 285.929 Q2043.81 288.291 2041.63 289.425 Q2039.46 290.536 2036.31 290.536 Q2032.33 290.536 2029.97 288.314 Q2027.63 286.068 2027.63 282.318 Q2027.63 277.943 2030.54 275.721 Q2033.48 273.499 2039.29 273.499 L2045.27 273.499 L2045.27 273.082 Q2045.27 270.143 2043.32 268.545 Q2041.4 266.925 2037.91 266.925 Q2035.68 266.925 2033.58 267.457 Q2031.47 267.99 2029.53 269.055 L2029.53 265.119 Q2031.86 264.217 2034.06 263.777 Q2036.26 263.314 2038.35 263.314 Q2043.97 263.314 2046.75 266.231 Q2049.53 269.147 2049.53 275.073 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2079.85 274.217 L2079.85 289.865 L2075.59 289.865 L2075.59 274.355 Q2075.59 270.675 2074.16 268.846 Q2072.72 267.018 2069.85 267.018 Q2066.4 267.018 2064.41 269.217 Q2062.42 271.416 2062.42 275.212 L2062.42 289.865 L2058.14 289.865 L2058.14 263.939 L2062.42 263.939 L2062.42 267.967 Q2063.95 265.629 2066.01 264.471 Q2068.09 263.314 2070.8 263.314 Q2075.27 263.314 2077.56 266.092 Q2079.85 268.846 2079.85 274.217 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2105.41 267.874 L2105.41 253.846 L2109.66 253.846 L2109.66 289.865 L2105.41 289.865 L2105.41 285.976 Q2104.06 288.291 2102 289.425 Q2099.97 290.536 2097.1 290.536 Q2092.4 290.536 2089.43 286.786 Q2086.49 283.036 2086.49 276.925 Q2086.49 270.814 2089.43 267.064 Q2092.4 263.314 2097.1 263.314 Q2099.97 263.314 2102 264.448 Q2104.06 265.559 2105.41 267.874 M2090.89 276.925 Q2090.89 281.624 2092.81 284.309 Q2094.76 286.971 2098.14 286.971 Q2101.52 286.971 2103.46 284.309 Q2105.41 281.624 2105.41 276.925 Q2105.41 272.226 2103.46 269.564 Q2101.52 266.879 2098.14 266.879 Q2094.76 266.879 2092.81 269.564 Q2090.89 272.226 2090.89 276.925 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2118.44 263.939 L2122.7 263.939 L2122.7 289.865 L2118.44 289.865 L2118.44 263.939 M2118.44 253.846 L2122.7 253.846 L2122.7 259.24 L2118.44 259.24 L2118.44 253.846 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2148.67 267.874 L2148.67 253.846 L2152.93 253.846 L2152.93 289.865 L2148.67 289.865 L2148.67 285.976 Q2147.33 288.291 2145.27 289.425 Q2143.23 290.536 2140.36 290.536 Q2135.66 290.536 2132.7 286.786 Q2129.76 283.036 2129.76 276.925 Q2129.76 270.814 2132.7 267.064 Q2135.66 263.314 2140.36 263.314 Q2143.23 263.314 2145.27 264.448 Q2147.33 265.559 2148.67 267.874 M2134.16 276.925 Q2134.16 281.624 2136.08 284.309 Q2138.02 286.971 2141.4 286.971 Q2144.78 286.971 2146.72 284.309 Q2148.67 281.624 2148.67 276.925 Q2148.67 272.226 2146.72 269.564 Q2144.78 266.879 2141.4 266.879 Q2138.02 266.879 2136.08 269.564 Q2134.16 272.226 2134.16 276.925 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2171.75 266.925 Q2168.32 266.925 2166.33 269.61 Q2164.34 272.272 2164.34 276.925 Q2164.34 281.578 2166.31 284.263 Q2168.3 286.925 2171.75 286.925 Q2175.15 286.925 2177.14 284.24 Q2179.13 281.555 2179.13 276.925 Q2179.13 272.318 2177.14 269.633 Q2175.15 266.925 2171.75 266.925 M2171.75 263.314 Q2177.3 263.314 2180.47 266.925 Q2183.65 270.536 2183.65 276.925 Q2183.65 283.291 2180.47 286.925 Q2177.3 290.536 2171.75 290.536 Q2166.17 290.536 2163 286.925 Q2159.85 283.291 2159.85 276.925 Q2159.85 270.536 2163 266.925 Q2166.17 263.314 2171.75 263.314 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2194.73 255.305 L2194.73 268.152 L2190.8 268.152 L2190.8 255.305 L2194.73 255.305 M2203.48 255.305 L2203.48 268.152 L2199.55 268.152 L2199.55 255.305 L2203.48 255.305 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip110)\" d=\"M2222.47 253.846 L2222.47 296.115 L2212.65 296.115 L2212.65 292.804 L2218.18 292.804 L2218.18 257.156 L2212.65 257.156 L2212.65 253.846 L2222.47 253.846 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /></svg>\n"
      ]
     },
     "execution_count": 27,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# puntos igualmente espaciados\n",
    "a=1-4E-3\n",
    "b=1+4E-3\n",
    "x = a:4E-3/50:b;\n",
    "p1= (x.-1).^7;\n",
    "p2=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x.-1;\n",
    "plot(x, p1,title = \"Expansion vs Fatorizado\", label = [\"Factorizado\"], lw = 1)\n",
    "plot!( x, p2, label=[\"Expandido\"],lw=1)\n",
    "\n",
    "#legend = plt.legend(loc='upper left', shadow=True, fontsize='x-large')\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "83a31910",
   "metadata": {},
   "source": [
    "Por último notamos que, aunque el error de redondeo es pequeño al principio, en cálculos complejos puede acumular para ocasionar efectos **catastróficos**.\n",
    "\n",
    "\n",
    "**EJEMPLO 1:**  Explosión del misil Ariane en Junio de 1996 por un **desbordamiento por exceso** en el computador del mismo.\n",
    "https://www.bugsnag.com/blog/bug-day-ariane-5-disaster\n",
    "\n",
    "**EJEMPLO 2:** La falla de una misión de un misil *American Patriot* durante la guerra del Golfo en 1991 debido a **errores de redondeo** en el cálculo de la trayectoria a seguir. \n",
    "https://www.iro.umontreal.ca/~mignotte/IFT2425/Disasters.html"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f34b1509",
   "metadata": {},
   "source": [
    "A continuación calculamos la recursión $x_0=1, x_1=1/3, x_{n+1}=\\frac{13}{3}x_n-\\frac{4}{3}x_{n-1}$ de dos formas diferentes. Una usando directamente la definición de la recursión. La otra a partir de la formula análitica de la misma, que es $x_n=\\frac{1}{3^n}$."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "c01a26c9",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Calculado(3) = 0.1, \t\t Exacto 0.1 \n",
      "Calculado(4) = 0.04, \t\t Exacto 0.04 \n",
      "Calculado(5) = 0.01, \t\t Exacto 0.01 \n",
      "Calculado(6) = 0.004, \t\t Exacto 0.004 \n",
      "Calculado(7) = 0.001, \t\t Exacto 0.001 \n",
      "Calculado(8) = 0.0005, \t\t Exacto 0.0005 \n",
      "Calculado(9) = 0.0002, \t\t Exacto 0.0002 \n",
      "Calculado(10) = 5e-05, \t\t Exacto 5e-05 \n",
      "Calculado(11) = 2e-05, \t\t Exacto 2e-05 \n",
      "Calculado(12) = 6e-06, \t\t Exacto 6e-06 \n",
      "Calculado(13) = 2e-06, \t\t Exacto 2e-06 \n",
      "Calculado(14) = 6e-07, \t\t Exacto 6e-07 \n",
      "Calculado(15) = 2e-07, \t\t Exacto 2e-07 \n",
      "Calculado(16) = 6e-08, \t\t Exacto 7e-08 \n",
      "Calculado(17) = -3e-08, \t\t Exacto 2e-08 \n",
      "Calculado(18) = -2e-07, \t\t Exacto 8e-09 \n",
      "Calculado(19) = -8e-07, \t\t Exacto 3e-09 \n",
      "Calculado(20) = -3e-06, \t\t Exacto 9e-10 \n",
      "Calculado(21) = -1e-05, \t\t Exacto 3e-10 \n",
      "Calculado(22) = -5e-05, \t\t Exacto 1e-10 \n",
      "Calculado(23) = -0.0002, \t\t Exacto 3e-11 \n",
      "Calculado(24) = -0.0009, \t\t Exacto 1e-11 \n",
      "Calculado(25) = -0.003, \t\t Exacto 4e-12 \n",
      "Calculado(26) = -0.01, \t\t Exacto 1e-12 \n",
      "Calculado(27) = -0.06, \t\t Exacto 4e-13 \n",
      "Calculado(28) = -0.2, \t\t Exacto 1e-13 \n",
      "Calculado(29) = -0.9, \t\t Exacto 4e-14 \n",
      "Calculado(30) = -4, \t\t Exacto 1e-14 \n",
      "Calculado(31) = -1e+01, \t\t Exacto 5e-15 \n",
      "Calculado(32) = -6e+01, \t\t Exacto 2e-15 \n",
      "Calculado(33) = -2e+02, \t\t Exacto 5e-16 \n",
      "Calculado(34) = -9e+02, \t\t Exacto 2e-16 \n"
     ]
    }
   ],
   "source": [
    "using Printf\n",
    "x0=1\n",
    "x1=1/3\n",
    "for n=3:34\n",
    "  x2=(13/3)*x1-(4/3)*x0\n",
    "  exac=(1/3)^(n-1)\n",
    "  @printf(\"Calculado(%.d) = %.g, \\t\\t Exacto %.g \\n\",n, x2,exac)\n",
    "#  print(\"Calculado = \",x2, \"\\t \\t Exacto = \",exac,\"\\n\")\n",
    "  x0=x1\n",
    "  x1=x2\n",
    "end"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "773d7d04",
   "metadata": {},
   "source": [
    "Observe que la columna de la izquierda, tiene hasta valore negativos y parece diverge a $-\\infty$. Este es otro ejemplo de algoritmo inestable. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "dff7db34",
   "metadata": {},
   "source": [
    "En Jilia podemos ver los códigos de lsa funciones internas muy fácilmente"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "7a38b228",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\u001b[?1l\u001b>?12l\u001b[?25h\u001b[30;1H\u001b[?1049l\u001b[23;0;0tr(x) = throw(DomainError(x, \"sin(x) is only defined fo$\u001b[15;1Hfunction sin(x::T) where T<:Union{Float32, Float64}\u001b[16;5Habsx = abs(x)\u001b[17;5Hif absx < T(pi)/4 #|x| ~<= pi/4, no need for reduction\u001b[18;9Hif absx < sqrt(eps(T))\u001b[19;13Hreturn x\u001b[20;9Hend\u001b[21;9Hreturn sin_kernel(x)\u001b[22;5Helseif isnan(x)\u001b[23;9Hreturn T(NaN)\u001b[24;5Helseif isinf(x)\u001b[25;9Hsin_domain_error(x)\u001b[26;5Hend\u001b[27;5Hn, y = rem_pio2_kernel(x)"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Too many errors from stdin"
     ]
    }
   ],
   "source": [
    "@edit sin(1.1)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3b615e28",
   "metadata": {},
   "source": [
    "Un otro ejemplo comun de cancelación es cuando se evaluan polinomios usando la expresión de potencias. Por ejemplo, evaluemos \n",
    "$$P(x)=(x-1)^7=x^7-7x^6+21x^5-35x^4+35x^3-21x^2+7x-1$$\n",
    "usando éstas dos expresiones al rededor de $x=1.0$. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "62518a09",
   "metadata": {},
   "outputs": [],
   "source": [
    "#using Pkg\n",
    "#Pkg.add(\"Plots\")\n",
    "using Plots"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "02b7ebe9",
   "metadata": {},
   "outputs": [],
   "source": [
    "a=1-4E-3\n",
    "b=1+4E-3\n",
    "x = a:(b-a)/200:b\n",
    "p1= (x.-1).^7\n",
    "p2=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x.-1\n",
    "plot(x, p1, label=\"Factored\",width=5,color=\"red\",leged=:bottomleft)\n",
    "plot!(x, p2, label=\"Expanded\", width=3,color=\"blue\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bf2db553",
   "metadata": {},
   "source": [
    "#  Cálculo simbólico\n",
    "\n",
    "Para terminar mencionaremos la librería sympy que permite realizar cálculo simbólico en lugar de cálculo numérico. Recuerden que en el cálculo numérico las variables en todo momento tiene valores particulares asignados los cuales corresponden a números de máquina que dependen del formato que se esté usando: precisión simple, precisión doble, e.t.c.\n",
    "En los cálculos simbólicos las variables no tienen que tomar valores particulares y se pueden manipular solo restringiendo su comportamiento a reglas que aplican a conjuntos numéricos como por ejemplo: enteros, reales, complejos, matrices, e.t.c."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "83530146",
   "metadata": {},
   "outputs": [],
   "source": [
    "#using Pkg\n",
    "#Pkg.add(\"Symbolics\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "3a225c0d",
   "metadata": {},
   "outputs": [],
   "source": [
    "using Symbolics"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "fbf8a7b7",
   "metadata": {},
   "outputs": [],
   "source": [
    "@variables x y"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "56cc653a",
   "metadata": {},
   "outputs": [],
   "source": [
    "z=x^2+y"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "d8bd8f09",
   "metadata": {},
   "outputs": [],
   "source": [
    "expand(z^2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "c8812173",
   "metadata": {},
   "outputs": [],
   "source": [
    "A = [x^2 + y x 2x\n",
    "     0       y 2y\n",
    "     y^2 + x x 0]\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "1dd95ca5",
   "metadata": {},
   "outputs": [],
   "source": [
    "using LinearAlgebra"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a97fca71",
   "metadata": {},
   "outputs": [],
   "source": [
    "det(A)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "65646174",
   "metadata": {},
   "outputs": [],
   "source": [
    "@variables t\n",
    "D = Differential(t)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a1b5805d",
   "metadata": {},
   "outputs": [],
   "source": [
    "z = t + t^2\n",
    "D(z) # Symbolics.derivative(t + t^2, t)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "8fd9be2b",
   "metadata": {},
   "outputs": [],
   "source": [
    "expand_derivatives(D(z)) # 1 + 2t"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "2bec45cc",
   "metadata": {},
   "outputs": [],
   "source": [
    "D.x"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "7c72aa38",
   "metadata": {},
   "outputs": [],
   "source": [
    "B = simplify.([t + t^2 + t + t^2  2t + 4t\n",
    "               x + y + y + 2t     x^2 - x^2 + y^2])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "054d7cf0",
   "metadata": {},
   "outputs": [],
   "source": [
    "simplify.(substitute.(B, (Dict(x => (y-1)^2),)))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "053eae28",
   "metadata": {
    "id": "nWxxD_YZ1Ni-"
   },
   "source": [
    "# Problemas"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "faf310aa",
   "metadata": {
    "id": "GHEQSZR51SrE"
   },
   "source": [
    "**PROBLEMA** ¿Cuánta memoria requiere guardar 100.000 números de punto flotante de precisión doble?¿Cuánta memoria requiere guardar una matriz de números de punto flotante dimensión 100.000 x 100.000?\n",
    "\n",
    "**PROBLEMA** Los números de punto flotante en python son implementados usando la clase float. Es decir, además de la descripción en bits del número tenemos asociados a la una instancia de variable tipo float los los siguientes métodos y atributos para un dato float: as_integer_ratio, conjugate, fromhex, imag, is_integer, real .\n",
    "\n",
    "Describa cada uno de estos métodos y atributos con ejemplos simples. \n",
    "\n",
    "La implementación del tipo de dato float en lenguaje C corresponde solo a la descripción en bits del número y no corresponde a una estructura u objeto. ¿Cuáles son las ventajas y desventajas de usar objetos?. \n",
    "\n",
    "\n",
    "**PROBLEMA(Sullivan)** Con $x_0=1/10$, considere la sucesión,  \n",
    "$$\n",
    "x_{n+1}=\\left\\{\\begin{array}{ll}\n",
    "2x_n & \\mbox{ si } x_n\\in \\left[0,\\frac{1}{2}\\right] \\\\\n",
    "2x_n-1 &  \\mbox{ si } x_n\\in \\left(\\frac{1}{2},1\\right].\n",
    "\\end{array}\\right.\n",
    "$$\n",
    "para $n=1,2,\\dots$. Calcule $x_1,x_2,x_3,\\dots,x_{50}$ de forma análitica y despues usandoun código en python. Compare y explique.\n",
    "\n",
    "Repetir pero ahora iniciando con $x_0=1/8$. Compare y explique. \n",
    "\n",
    "**PROBLEMA** Explique la falla del Ariane y del American Patriot. Muestre cálculos numéricos para soportar su explicación. \n",
    "\n",
    "\n",
    "**PROBLEMA 5** Escriba rutina que implemente la función \n",
    "$\n",
    "SF_{i}(x)=\\frac{\\exp\\left(x_{i}\\right)}{\\sum_{j=1}^{n}\\exp\\left(x_{j}\\right)}.$\n",
    "La rutina debe estar estabilizada para evitar desbordamiento por exceso. \n",
    "\n",
    "**PROBLEMA(Stoer)** Ensaye calcular las funciones $$f(x)=\\sqrt{x^2+1}-1 \\quad g(x)=\\frac{x^2}{\\sqrt{x^2+1}+1}$$\n",
    "Use valores pequeños como $x=8^{-1},8^{-2},8^{-3},\\dots$. Explique los resultados. Note que, análiticamete,  $f(x)=g(x)$.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "47a2e8fb",
   "metadata": {
    "id": "poKJfAr62xKi"
   },
   "source": [
    "**PROBLEMA(Quarteroni,Saleri,Gervasio)** El lector puede implementar el calculo de la siguiente recurrencia que approxima $\\pi$ (formula de Franc,ois Viète) y estudiar su estabilidad/instabilidad numérica, \n",
    "$$z_1=2, \\,\\,z_{n+1}=2^{n-1/2}\\sqrt{1-\\sqrt{1-4^{1-n}z_n^2}},\\,\\,n=2,3,\\dots. $$\n",
    "\n",
    "\n",
    "\n",
    "**PROBLEMA(Stewart)** Repita el experimento arriba con la recurrencia $x_1=\\frac{1}{3}, x_2=\\frac{1}{12}$,  $x_{k+1}=2.25x_k-0.5x_{k-1}$.\n",
    "\n",
    "**PROBLEMA** Presente un ejemplo, adicional  a los presentados en clase, de algortimos inestables o problemas mal condicionados. \n",
    "\n",
    "**PROBLEMA** Repita el experimento arriba con $P(x)=(x-1)^7$. Agrege a la figura el siguiente método \n",
    "$$  P(x)= ((((((x-7)x+21)x-35)x+35)x-21)x+7)x-1. $$\n",
    "Verifique esta formula. Implemente y comente los resultados. Esta forma de calcular polinimios es conocida como el esquema de Horner.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "346d7684",
   "metadata": {
    "id": "OY2xTl3zL0Fy"
   },
   "source": [
    "**PROBLEMA(Stoer)** Considere los siguientes algoritmos. Algoritmo 1\n",
    "$$s=p^2,\\quad t=s+q,\\quad u=\\sqrt{t},\\quad y=-p+u  $$\n",
    "y el altoritmo 2, \n",
    "$$s=p^2,\\quad t=s+q,\\quad u=\\sqrt{t}, \\quad v=p+u,\\quad y=q/v $$\n",
    "Escriba $y$ como función de $p$ y $q$. Compare los resutados de estos dos algoritmos cuando $p=1000$,  $q=0.0018000000081$. Explique los resultados. ¿Cuál es mas confiable para estos valores de $p$ y $q$?"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cc2afa44",
   "metadata": {
    "id": "CiLS02H-QYNd"
   },
   "source": [
    "**PROBLEMA** Considere el siguiente codigo\n",
    "```\n",
    "x=np.sqrt(1/9)\n",
    "print(\"x={0:.60f}\".format(x))\n",
    "```\n",
    "que dá como resultado \n",
    "x=0.333333333333333314829616256247390992939472198486328125000000.\n",
    "\n",
    "Explique, tan detalladamente como le sea posible, lo que  está pasando. \n",
    "Compare con el siguiente código para el cual es más dificil saber la respuesta exacta. \n",
    "```\n",
    "x=np.sqrt(0.1)\n",
    "print(\"x={0:.60f}\".format(x))\n",
    "```\n",
    "¿Cuántos decimales puede garantizar este cálculo?"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ec421256",
   "metadata": {
    "id": "nTJp3M3KDtgg"
   },
   "source": [
    "**PROBLEMA** Describa los siguientes tipos de datos :numpy.half,   numpy.float16, numpy.single, numpy.double, numpy.longdouble, numpy.csingle, numpy.cdouble, numpy.clongdouble."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8d9fe7ec",
   "metadata": {
    "id": "I28slkSm9nBN"
   },
   "source": [
    "# Referencias\n",
    "\n",
    "\n",
    "\n",
    "*    Fundamentals of Numerical Computation by Tobin A. Driscoll and Richard J. Braun. The book was originally written for MATLAB, but this resource has been adapted to suit Julia. https://tobydriscoll.net/fnc-julia/frontmatter.html\n",
    "*   Sullivan, Eric. Numerical Methods: An Inquiry-Based Approach With Python. 2020.\n",
    "*   Bulirsch, Roland, Josef Stoer, and J. Stoer. Introduction to numerical analysis. Vol. 3. Heidelberg: Springer, 2002.\n",
    "*  Stewart, Gilbert W. Afternotes on numerical analysis. Society for Industrial and Applied Mathematics, 1996.\n",
    "*  Quarteroni, Alfio, Fausto Saleri, and Paola Gervasio. Scientific computing with MATLAB and Octave. Vol. 3. Berlin: Springer, 2006.\n",
    "* Estándar de la IEEE\n",
    "* Low Precision Floating-Point Formats: The Wild West of Computer Arithmetic\n",
    "https://sinews.siam.org/Details-Page/low-precision-floating-point-formats-the-wild-west-of-computer-arithmetic\n",
    "* What Every Computer Scientist Should Know About Floating-Point Arithmetic, by David Goldberg, published in the March, 1991 issue of Computing Surveys. \n",
    "* Modern Computer Arithmetic: Richard P. Brent and Paul Zimmermann\n",
    "https://docs.oracle.com/cd/E19957-01/806-3568/ncgTOC.html"
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
