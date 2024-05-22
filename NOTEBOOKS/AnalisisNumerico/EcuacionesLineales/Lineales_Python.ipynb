{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "collapsed_sections": []
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "source": [
        "Elaborado por [Juan Galvis](https://scholar.google.com/citations?user=lbfc2joAAAAJ&hl=en)."
      ],
      "metadata": {
        "id": "yslTRpgBNcFC"
      }
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "xpYVGLKCEsoc"
      },
      "source": [
        "## Prerequisitos\n",
        "Usarememos numpy y linalg de scipy (que incluye mucho de numpy.linalg)"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "96Iru7rGEgfh"
      },
      "source": [
        "import matplotlib.pyplot as plt\n",
        "import numpy as np\n",
        "import scipy.linalg as la\n",
        "import scipy.io as io\n",
        "import scipy.sparse as sp\n",
        "np.set_printoptions(formatter={'float': '{: 0.4f}'.format})\n",
        "import pprint\n",
        "import urllib.request"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "TTdPrYh2Fawu"
      },
      "source": [
        " **scipy.linalg**  contiene todas las funciones de **numpy.linalg** y algunas otras. **scipy.linalg** usa BLAS/LAPACK por defecto. Se aconseja \n",
        "usar **scipy.linalg** a menos que se tenga una razón de peso para no hacerlo. \n"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "-alj3AwHLFqQ"
      },
      "source": [
        "### Normas "
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "x=np.array([1,2,3,-4])\n",
        "la.norm(x,1)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "bHqq68Y7Oxup",
        "outputId": "ae71e755-3f56-45de-f0ee-54cda3fc97d6"
      },
      "execution_count": null,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "10.0"
            ]
          },
          "metadata": {},
          "execution_count": 24
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "la.norm(x,2) #Euclidiana"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "5zfQyX0yRcbh",
        "outputId": "c504a967-2f30-476d-9387-b998cd7495f5"
      },
      "execution_count": null,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "5.477225575051661"
            ]
          },
          "metadata": {},
          "execution_count": 25
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "la.norm(x,np.Inf)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "H7wE5B5mRkkX",
        "outputId": "af238a64-7d99-41d2-fe7c-f40dd9ef74d0"
      },
      "execution_count": null,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "4.0"
            ]
          },
          "metadata": {},
          "execution_count": 26
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "W7TxbVj1LJNb",
        "outputId": "daf54560-e97b-490c-fe8e-4fac8598c6f1"
      },
      "source": [
        "A=np.array([[0, 0, 1],\n",
        "       [-1,  2,  2],\n",
        "       [ 1, 2,  1]])\n",
        "print(A)\n",
        "print('La norma  2 de la matrix extendida a vector  es = ',la.norm(A)) #máximo valor singular\n",
        "print('La norma de Frobenious es = ',la.norm(A,'fro')) # Frobenius\n",
        "print('La norma subordinada 1 es = ',la.norm(A,1))\n",
        "print('La norma subordinada 2 es = ', la.norm(A,2))\n",
        "print('La norma subordinada Inf es = ', la.norm(A,np.Inf))"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "[[ 0  0  1]\n",
            " [-1  2  2]\n",
            " [ 1  2  1]]\n",
            "La norma  2 de la matrix extendida a vector  es =  4.0\n",
            "La norma de Frobenious es =  4.0\n",
            "La norma subordinada 1 es =  4.0\n",
            "La norma subordinada 2 es =  3.622222345931449\n",
            "La norma subordinada Inf es =  5.0\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "hf2Hzz92_3Ni"
      },
      "source": [
        "## Métodos directos\n",
        "Presentamos algunos comandos relacionados con la solución de sistemas lineales por métodos directos."
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "WeqXAN6rE5B1"
      },
      "source": [
        "### Factorización $A=PLU$ y Cholesky"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "Q84YMaKV9qZ6"
      },
      "source": [
        "Calculemos la factorización $A=PLU$ de una matriz $4\\times 4$."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "7JbMg460E99G",
        "outputId": "9f7d0115-a143-4487-99ff-b0db8b00a5cb"
      },
      "source": [
        "A = np.array([[2, 5, 8, 7], [5, 2, 2, 8], [7, 5, 6, 6], [5, 4, 4, 8]])\n",
        "p, l, u = la.lu(A)\n",
        "print('Matriz de permutación:\\n',p,'\\n')\n",
        "print('Matriz triangular inferior\\n',l,'\\n')\n",
        "print('Matriz triangular superior\\n',u,'\\n')"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "Matriz de permutación:\n",
            " [[ 0.0000  1.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  1.0000]\n",
            " [ 1.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  1.0000  0.0000]] \n",
            "\n",
            "Matriz triangular inferior\n",
            " [[ 1.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.2857  1.0000  0.0000  0.0000]\n",
            " [ 0.7143  0.1200  1.0000  0.0000]\n",
            " [ 0.7143 -0.4400 -0.4615  1.0000]] \n",
            "\n",
            "Matriz triangular superior\n",
            " [[ 7.0000  5.0000  6.0000  6.0000]\n",
            " [ 0.0000  3.5714  6.2857  5.2857]\n",
            " [ 0.0000  0.0000 -1.0400  3.0800]\n",
            " [ 0.0000  0.0000  0.0000  7.4615]] \n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "bCqKO0YT-Ovo"
      },
      "source": [
        "Ahora calculemos la factorización para la matriz de Hilbert."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "a7sBO26YGfmj",
        "outputId": "0d2a439a-6b78-438a-f7d4-69c2cb9ee40e"
      },
      "source": [
        "H=la.hilbert(9)\n",
        "print('H=\\n',H)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "H=\n",
            " [[ 1.0000  0.5000  0.3333  0.2500  0.2000  0.1667  0.1429  0.1250  0.1111]\n",
            " [ 0.5000  0.3333  0.2500  0.2000  0.1667  0.1429  0.1250  0.1111  0.1000]\n",
            " [ 0.3333  0.2500  0.2000  0.1667  0.1429  0.1250  0.1111  0.1000  0.0909]\n",
            " [ 0.2500  0.2000  0.1667  0.1429  0.1250  0.1111  0.1000  0.0909  0.0833]\n",
            " [ 0.2000  0.1667  0.1429  0.1250  0.1111  0.1000  0.0909  0.0833  0.0769]\n",
            " [ 0.1667  0.1429  0.1250  0.1111  0.1000  0.0909  0.0833  0.0769  0.0714]\n",
            " [ 0.1429  0.1250  0.1111  0.1000  0.0909  0.0833  0.0769  0.0714  0.0667]\n",
            " [ 0.1250  0.1111  0.1000  0.0909  0.0833  0.0769  0.0714  0.0667  0.0625]\n",
            " [ 0.1111  0.1000  0.0909  0.0833  0.0769  0.0714  0.0667  0.0625  0.0588]]\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "_usuSB5dHjp2",
        "outputId": "9ad30003-355b-4b4c-992b-70cc302a0bd2"
      },
      "source": [
        "p, l, u = la.lu(H)\n",
        "res=H-p@l@u\n",
        "print('pA-LU=\\n',res)\n",
        "print('La norma Inf del residuo es ',la.norm(res,np.Inf))\n",
        "print('La norma 2 del residuo es ', la.norm(res,2))"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "pA-LU=\n",
            " [[ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000 -0.0000  0.0000  0.0000 -0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000 -0.0000  0.0000  0.0000 -0.0000  0.0000 -0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000 -0.0000  0.0000]\n",
            " [ 0.0000  0.0000 -0.0000  0.0000 -0.0000  0.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000 -0.0000]]\n",
            "La norma Inf del residuo es  5.551115123125783e-17\n",
            "La norma 2 del residuo es  4.3091695835249104e-17\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "b4xUEDnzOygd"
      },
      "source": [
        "Calculemos la permutación de la factorización $A=PLU$ para una matriz diagonal dominante."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "pRrx8ByPIKVn",
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "outputId": "584b85e6-2902-4633-eb70-7355e5034050"
      },
      "source": [
        "A = np.array([[5, -1, 2, -1], [-1, 5, 0, 1], [0, -1, 4, 2], [1, 1, 1, 5]])\n",
        "p, l, u = la.lu(A)\n",
        "print(p)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "[[ 1.0000  0.0000  0.0000  0.0000]\n",
            " [ 0.0000  1.0000  0.0000  0.0000]\n",
            " [ 0.0000  0.0000  1.0000  0.0000]\n",
            " [ 0.0000  0.0000  0.0000  1.0000]]\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "J9OS-PF3_Kgp"
      },
      "source": [
        "Calculemos ahora la factorización de Cholesky de una matri de la forma $A^TA$ con $A$ aleatoria. "
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "ejshwODcOuYF",
        "outputId": "a2ec5a86-f5f0-4238-9054-42387a81a70f"
      },
      "source": [
        "A=np.random.rand(4,4)\n",
        "B=A.transpose()@A\n",
        "r=la.cholesky(B)\n",
        "print(r)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "[[ 1.0061  0.4779  1.3392  0.9703]\n",
            " [ 0.0000  0.6235  0.2981  1.0280]\n",
            " [ 0.0000  0.0000  0.6111  0.4311]\n",
            " [ 0.0000  0.0000  0.0000  0.3996]]\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "lRFppWvXQrym"
      },
      "source": [
        "### Sistemas lineales"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "c-W953fD_WcZ"
      },
      "source": [
        "Resolver un sistema lineal general."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "bzSP0QJ_QtPl",
        "outputId": "8c344942-dc94-4a4a-9517-f82d0a296b93"
      },
      "source": [
        "A = np.array([[3, 2, 0], [1, -1, 0], [0, 5, 1]])\n",
        "b = np.array([2, 4, -1])\n",
        "x = la.solve(A, b)\n",
        "res=b-A@x\n",
        "print('x=',x.transpose())\n",
        "print('res=',la.norm(res))\n"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "x= [ 2.0000 -2.0000  9.0000]\n",
            "res= 0.0\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "GnBnFCc1_bF0"
      },
      "source": [
        "Otro sistema lineal con una matriz mal condicionada es el siguiente."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "L0nQcGXxQ2mm",
        "outputId": "6348b1cf-4575-44c7-887a-873b96f13950"
      },
      "source": [
        "A=la.hilbert(15)\n",
        "b=np.ones([15,1])\n",
        "x=la.solve(A,b)\n",
        "res=b-A@x\n",
        "la.norm(res)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "/usr/local/lib/python3.7/dist-packages/ipykernel_launcher.py:3: LinAlgWarning: Ill-conditioned matrix (rcond=8.18724e-19): result may not be accurate.\n",
            "  This is separate from the ipykernel package so we can avoid doing imports until\n"
          ]
        },
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "1.8515526644951704e-08"
            ]
          },
          "metadata": {},
          "execution_count": 33
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "-UJTq-m5Ssoj"
      },
      "source": [
        "Recuerde que $rcond=8.18724e-19$ es un estimado del recíproco del número de condición de la matriz del sistema lineal. En esta caso \n",
        "$\\kappa(A)\\approx 10^{19}$. Tenemos un residuo del orden de $1.85\\times 10^{-8}."
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "5xVNvY8OAArC"
      },
      "source": [
        "##Iteraciones"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "vXLB7R_xDzFj",
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "outputId": "3954be44-6b86-4cc9-f175-ac54fef04e0a"
      },
      "source": [
        "def jacobisolver(A,b,tol,Maxiter=25,x=None):\n",
        "    # x inicial en caso no se tenga                                                                                                                                                            \n",
        "    if x is None:\n",
        "        x = zeros(len(A[0]))\n",
        "    #A=D-L-U y R=A-D=-L-U;                                                                                                                                                                \n",
        "    D = np.diag(np.diag(A))\n",
        "\n",
        "    #Interation                                                                                                                                                                          \n",
        "    for i in range(Maxiter):\n",
        "        r=b-np.dot(A,x)\n",
        "        nr=la.norm(r)\n",
        "        print('norm(r(',i,'))=',nr)\n",
        "        if nr<tol:\n",
        "          break        \n",
        "        delta=la.solve(D, r)\n",
        "        x = x+delta\n",
        "    return x\n",
        "\n",
        "A = np.array([[2.0,1.0],[5.0,7.0]])\n",
        "b = np.array([11.0,13.0])\n",
        "guess = np.array([1.0,1.0])\n",
        "\n",
        "sol = jacobisolver(A,b,0.00001,Maxiter=100,x=guess)\n",
        "\n",
        "print(\"A:\")\n",
        "print(A)\n",
        "\n",
        "print(\"b:\")\n",
        "print(b)\n",
        "\n",
        "print (\"x:\")\n",
        "print(sol)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "norm(r( 0 ))= 8.06225774829855\n",
            "norm(r( 1 ))= 20.000510197574094\n",
            "norm(r( 2 ))= 2.8793777672494825\n",
            "norm(r( 3 ))= 7.143039356276462\n",
            "norm(r( 4 ))= 1.0283492025891017\n",
            "norm(r( 5 ))= 2.5510854843844535\n",
            "norm(r( 6 ))= 0.36726757235325247\n",
            "norm(r( 7 ))= 0.911101958708741\n",
            "norm(r( 8 ))= 0.13116699012616342\n",
            "norm(r( 9 ))= 0.32539355668169445\n",
            "norm(r( 10 ))= 0.04684535361648634\n",
            "norm(r( 11 ))= 0.11621198452917507\n",
            "norm(r( 12 ))= 0.016730483434460305\n",
            "norm(r( 13 ))= 0.04150428018899745\n",
            "norm(r( 14 ))= 0.005975172655166063\n",
            "norm(r( 15 ))= 0.014822957210355727\n",
            "norm(r( 16 ))= 0.002133990233987848\n",
            "norm(r( 17 ))= 0.0052939132894127576\n",
            "norm(r( 18 ))= 0.0007621393692812169\n",
            "norm(r( 19 ))= 0.0018906833176474099\n",
            "norm(r( 20 ))= 0.0002721926318847325\n",
            "norm(r( 21 ))= 0.0006752440420146464\n",
            "norm(r( 22 ))= 9.721165424498798e-05\n",
            "norm(r( 23 ))= 0.00024115858643596378\n",
            "norm(r( 24 ))= 3.471844794583464e-05\n",
            "norm(r( 25 ))= 8.612806658643426e-05\n",
            "norm(r( 26 ))= 1.2399445696986865e-05\n",
            "norm(r( 27 ))= 3.0760023784682106e-05\n",
            "norm(r( 28 ))= 4.4283734631151675e-06\n",
            "A:\n",
            "[[ 2.0000  1.0000]\n",
            " [ 5.0000  7.0000]]\n",
            "b:\n",
            "[ 11.0000  13.0000]\n",
            "x:\n",
            "[ 7.1111 -3.2222]\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "vvZ6CrVh6-6y"
      },
      "source": [
        "## Matrices dispersas"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "yEYPWKBML3Lu"
      },
      "source": [
        "Consideremos un ejemplo de una matriz dispersa en https://suitesparse-collection-website.herokuapp.com/. En particular la matriz correspondiente a: *HB/1138_bus\n",
        "S ADMITTANCE MATRIX 1138 BUS POWER SYSTEM, D.J.TYLAVSKY, JULY 1985.*"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "CL7bCp6l7A8k",
        "outputId": "54b9e4c1-d9b1-4d3f-8873-08012cd4ec60"
      },
      "source": [
        "import requests \n",
        "# Import to a python dictionary\n",
        "url = \"https://suitesparse-collection-website.herokuapp.com/mat/HB/494_bus.mat\"\n",
        "file = requests.get(url, allow_redirects=True)\n",
        "print(file.content)\n",
        "open('bus494.mat', 'wb').write(file.content)\n"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "b'MATLAB 5.0 MAT-file, Platform: GLNXA64, Created on: Sat Sep  6 04:04:21 2008                                                \\x00\\x01IM\\x0f\\x00\\x00\\x00\\x901\\x00\\x00x\\x9cl\\x99\\t\\x98\\xcf\\xd5\\x1a\\xc7\\xcf\\x99\"\\xcb\\xb5\\x94+*\\xcb\\xdf\\x12e\\xcb\\xd6X\\x8a\\xcc0\\xf6a\\x98\\xb1\\x8c\\x16\\xfb\\x96]C\\x08\\xe5RH\\xc8\\x92\\ne\\xab\\xe4\\xda\\x97H\\\\K\\x91\\xb1\\x14\\xb2\\x8c\\xdc\\x9a\\xac\\xc9ruo\\xe5\\xb6\\\\\\xe9~\\xbf\\xde\\xf7}~\\xe7z\\xee<\\xcf\\xe79\\xeb\\xef\\xf7;\\xffs\\xde\\xf5L~\\xe7\\\\fG\\xe7r\\xa2\\xcc\\x05\\xe2\\x9c\\xfc\\xe5\\xd0\\xb6\\x0f\\xb8\\x03\\xa4\\x0c\\x1d\\xd4\\xad\\x7f\\xcf\\x01\\x18\\xbf\\xfdf\\x9b\\xfd\\xb5AF\\xdf\\x8c\\xfe=\\x9dK\\x90\\xa7\\x07v\\x1d\\x80\\x86\\xeb\\xdb\\xe3f\\xabG\\xd7\\x0c\\xb6\\xba\\x0e\\xcb\\xe83h\\xa8\\xeb)\\x9d\\xfd\\xfa\\x0ed%?\\x18\\xe1\\xa2\\xef\\xdf\\xfe\\x7f\\xbe\\xdfPK\\xfe\\x15\\xd4vj,\\xa1Qr\\xb3\\xb4\\xb4\\x84V\\r\\x93b\\xc9\\tim\\x9bu\\x8c\\xc5j\\xd6\\xa9\\x19Kl\\x97\\x1aKi\\xdd!\\xa9m,5=5-)\\xb9R\\xacQ\\x95\\xe6U\\xd2\\xd2[&\\xb4Om\\x91^)\\xd6\\xbc]\\xcb\\xf4X\\xb5:\\xb5\\x1f\\xaer\\xf3}\\xfc~\\xac}\\xf4\\xfd\\x1c\\xf8\\xc0\\xf8\\x9c\\xd1\\xf7\\xafz\\xc1\\x07\\xeb\\xfa\\xd3\\xbdR/\\x00*\\x83<:~\\x9b\\xee_\\r\\xb0\\xd9E}\\xdc\\xa7g\\xc1[`\\x05:W{\\xf9\\x9dC\\xf5}\\xaf\\x815^\\xd6p\\'x\\x87;\\x88\\xf62\\x1f=\\xcf\\xb5\\xbc\\x8bvn\\x94\\x07\\xc0\\x9fQ\\xcf\\x83r\\x1e\\xca\\xf5 /\\xd7\\x05\\xf2\\xe9\\xba\\xac\\x9dW\\xfb\\xf2k\\xbf\\xd3>ks?\\xef\\xd23\\xb4v!\\xbe\\x1f\\x14\\xc5{\\x93\\x83u\\x15\\xd0\\xb96\\xa7\\xa0\\xce+\\x0c\\xee\\x06Sn\\xa9\\xcf\\x05\\xbb@\\x11\\xbe+(\\xe7\\x83e\\xe0\\x1e\\xd0\\r\\xbc\\x8fopK\\xefsQ\\x99\\xc6\\xbd\\x02\\xc5@u\\x8c?\\x02\\x8a\\xa3^\\xc2E\\xe5\\x07\\xba\\xcf%\\xb9\\xbf\\x18\\xdf\\x02b\\xa8\\x97\\xe2\\xb9\\xb9\\xa8^\\x1a|\\r\\xca\\x80F\\x98\\xb3\\x18\\x94E}&\\xf7\\x1f\\xf5\\xfbQ\\x96\\x03S\\x83zy\\xfd\\xfdV_\\x88\\xfa\\x03()5MP\\x9f\\x0f\\x1eD}\\xb9\\xb6+\\xa0\\\\\\x05*\\x02\\n{q\\xf4UB\\xb9\\x12\\xec\\xe3\\x19\\xa2]L\\x85\\x882s\\xddE\\xef{\\xc3\\xc9\\xd8Cz\\xb6\\xf9\\xb9\\x1f\\xa0\\x1a\\xa8\\x8av50\\x04|\\x1a\\xb4\\xff\\x01\\x9a\\xa3\\xbd\\x19TG\\xbd\\r\\xdf\\xe3#\\xf9{\\x05\\xf5\\x9a\\xfa\\xae\\x87\\t\\xea\\x8b(k\\xa8\\xc7S6P>\\rj\\xa1\\xfe\\x1c\\xf8F\\xcf\\x97r\\x90\\n\\xea\\x80\\xba\\xe0\\x91\\xa0\\xde\\t\\xf3Gxi\\xb3\\xffQ\\xd0\\x02\\xedE\\xa0\\x1e\\xcf\\x03e}\\x94\\x8f\\x01\\x98\\x14\\xf7709\\xe8k\\xe0\\xc4@,W\\x99\\xb5v\"\\xcf\\x05$\\x81\\xc6N\\xf4\\x9b\\xf5&\\xa0)8\\x16\\xccI\\x0c\\xc6\\x1b\\xeb\\x9c\\xa9 \\x1e\\xef{\\xcc\\xcb\\xb8\\x8d5\\xe3\\x1eq\\x8d\\\\;\\xe8\\xe2\\xff\\xf7\\xddG\\xc0Q\\xb0\\t\\xfd\\x07u\\xaci\\xf0lc}\\xbe\\xb1\\xbe\\xa3%H\\x06\\x1f\\xe9yZ{\\x14\\xc8\\x85v+\\x94\\xadu\\xbd\\xef\\x04m\\xca\\xd9\\x7f@7\\xf4M\\x02\\x1b@\\n\\xdaSPf\\x06\\xe7W\\x02\\xf5\\xb6(\\xff\\x82\\xf2=\\x1f\\x9d\\x05\\xf5\\xc0t\\xa2\\x03x\\x06\\xdc\\x85\\xf1\\xdd\\xa0\\x9d\\xf6\\xb5\\xd7\\xf2\\xb2\\xcek\\x17\\xf4\\xd5\\xd7\\xf3H\\xc2\\xfct\\xdd\\x8bq^~\\x97\\xb5\\x9f\\x00O\\x82\\xa7\\xc0P\\x8c=\\xaeu\\xae\\xc5\\xc6;\\xe9\\x1c\\x966\\xde9(\\xbb\\xe87h\\xa7\\xba:\\xb1k\\xf3\\\\\\xa4\\xe7\\x94\\xb1\\xeeN\\xec\\xe0\\xdf\\xc1K\\x98G\\x1f@}\\xa1\\xdeX}-\\xf8\\xce\\x89\\x0e\\xf5r\\xa2\\x07\\xb4\\x9b\\xbdQ\\xef\\x03\\xb6\\x01\\x1a\\xd7\\x9cA__p\\x03<\\r\\xae9\\xb1[\\xfdt\\xees\\xa8\\xf7G9\\x08\\x0c\\xd0r\\xa0\\x96\\xfd\\xb5\\xcf\\xda<\\xcbu\\xe0A<3\\xd8\\xc97R\\xc0H\\xb0@\\xf5\\x8f\\xbaH\\xdb]L\\xed\\xb8\\xb5\\xbbz\\xd9{\\x9eOFP\\x0e\\x07\\xc3\\x9c\\xe8Y\\xba\\x8f\\xfa\\xd2\\xd5\\xbe\\xd37\\xf0\\xf7\\x8d\\xd0\\xef\\x8f\\xd4\\xd2\\xe4\\xec\\x01/r\\xc6\\xf5\\x8d\\x08\\xc6\\xd7\\xa9\\xdc\\xd5\\n\\xde?\\x1a\\x8c\\t\\xca\\x170>\\x96%8\\r\\x9e\\x07\\xa7\\x9c\\xe8\\xaa\\xf5\\x8f\\x03\\xaf\\xf0\\xac\\xb5\\x1c\\xaf\\xe5\\x04\\'\\xba\\xf5\"\\x98\\xc6\\xf3rb\\xd7\\'\\xea8\\xc7\\xa6\\x83IA\\xfbU0\\x19|\\nR\\xf1\\x8d\\x97\\x9d\\xc8\\xbf\\xf9\\x05{\\xc78\\xfd\\xdex}\\x9f\\xbd#I\\xbfk}S\\xf5\\xdb\\'\\xf0\\xae\\xaf\\xc1\\xb7^\\xd6c\\xfd\\xff\\xd2\\xb9\\xb6\\x0e~\\x7f\\x06\\xd8\\x08~\\x02m\\xd5\\xd6S\\x0fm-\\xb3\\xc0Z\\xf4\\x7f\\x04f;\\x91\\xd3\\x13N|1\\xe5\\xd6\\xfahC\\xe78\\xb1\\xcfo:\\xf1g\\xaf\\xdf\\xd2\\xa6\\xfd\\x9e\\x13\\xf4\\xef\\x0b\\xdao\\xeao\\xb66\\xe7\\xffS\\xbfA\\xbd\\xa0\\x1f,\\x1a\\xd4)\\x0b\\xa6\\x1fo\\x83\\x05\\xfa;~\\xe6>a-\\x13}\\xd4?\\x18\\xf5i`!\\xbf\\x13\\xd8w\\xda\\x98\\xc5(\\xdfs\\xa2\\x07K\\xb4\\xfe\\xad\\x13\\x1fvL\\xfd9c\\x8cwA\\x9a\\xda\\x9a\\xc5\\xc1\\xdc\\xa5\\xe0\\xfd\\xa0\\xec\\x80\\xf1\\xe9^\\xd6J\\xbfM\\x1f\\xfaW\\'\\xbe\\x8f>\\xd0\\xea\\xb4Qf\\xaf\\xf6\\xba\\xc8\\xff\\xd1/\\x16S\\x1fi\\xed\\xd5Nl\\xee\\x1a\\'rizO\\x99\\t\\xf5p=\\xd8\\x10\\x94\\xb4\\x0b\\xe6\\xfbg\\xe8>q\\x8f6\\x81\\x0fu\\xaf\\xac\\xbdQ\\xfb\\xe2\\xf4\\x19\\xc6\\n\\xb4\\xd9\\xd4\\x1f\\xea\\xd6\\x16\\xb0\\xdb\\x89\\x1f\\xd8\\xea\\xc4_\\xd5\\x0f\\xea\\xaf\\xaa}1;\\xb2\\x1d|\\x0c>\\x01\\xc3\\xbc\\xd8\\x15\\xda\\x04\\x1b\\xdb\\x01v\\x06\\xf5\\xed\\xda\\xde\\xa6\\xcfm\\xd3g)\\x13\\x8c\\x8b\\x0e\\xf9h\\r\\x99.\\xd2\\x9b~\\xe8\\xdf\\x83\\xb2\\x88\\x8f\\xc6lO\\xff\\xad\\xfbj\\xb2F\\xdb\\xb0\\xdfI\\xdc\\xf0\\x19\\xf8\\xdcI\\x8c\\xc8X\\xc2\\xfa\\x0f:\\x89\\'zx\\x91\\x9b\\xfd:w\\xbf\\xce/\\xec\\xa3y\\x87\\x82\\xf20\\xf8\"(\\xe9\\xab\\xb8\\xe6&\\xbaw\\xdc7\\xd6\\xe9C\\xb7\\xa8\\xff\\xa4\\xcf\\xa3\\xff;\\x0e^\\xf4\\xe2[\\xb3\\x9c\\xe8\\xd7\\x97\\xe0\\xa4\\x13\\xfd\\xb2>\\xc6\\xb1\\xc5\\xd5\\xbeg\\xe9\\x9c,\\x9dw\\xc9\\x89>\\xd0W0\\x8e\\xd9\\x01\\xber\\x12\\x1bSv,\\xae\\xfb\\xdeI<\\x91\\x8d\\xb2\\xa3\\x978n\\x8e\\xdaE\\xf3;#\\xd4_\\x9a\\xfd\\xa3\\xcc\\xdd\\xa3\\xf1\\x0c\\xed\\xe0\\x9a\\xa0\\xff\\x0c8\\x1b\\x94K0\\xe7\\x1c\\xca\\xf3.*\\xebj\\x0cC\\x9d\\xa1n\\xd1\\x9f\\xd2F]p\"\\xa3\\x17u\\xfd\\x94k\\xca\\xad\\xf5_\\xd0\\xb1\\x93Z\\xe7\\x1c\\xfai\\xfa\\xedJ\\xaa\\xd3WP\\xaf\\x88\\xb2\\x86\\x8fb\\xbd\\xfb\\xbd\\xc4\\xb3\\x8ck\\x13|\\xf4\\xbb\\xe9k\\xcd\\xae4\\xf5\\x91M\\xf4\\xa8\\xaf\\x02\\xdf\\x80\\x1f\\xd0\\xfe\\x11\\xd4\\x0c\\xea\\xd4\\x9d\\x9f\\xf4;\\xf4\\x99\\xd4\\xffk\\x81\\x8c\\xb5\\xf4\\x91nQ\\xa7~\\t\\xca_\\xc1oA\\xfd\\x17m\\xd3\\xc62\\xcea\\\\i1\\xee\\x1f\\xe0w-\\xcdG\\xb3N\\xbft]\\xc7\\xac\\x8f\\xbaF\\xbf\\x9e\\x1b\\xb4\\x063hg|\\xf4{\\xe2\\xe8/\\xe9s\\xf5\\xb7\\x1d\\xf6Q\\xbf\\xd71\\xaf\\xe3\\xb4\\xf99\\xd4\\xc6\\xf3\\xbd\\xe6\\xcb[\\xab/\\xa7\\x0e\\x99-\\xa0\\x8f\\xcd\\xe5\\xa3X\\xce\\xda\\xb6\\x16\\xfe\\xe5Q\\x99\\xca\\xeb%vf\\x0cmu\\x9eA>\\xf0\\x0c\\x98\\xe5E\\xf7j\\x06r[\\xc0K\\x0cNY\\xb3vApgP/\\xa0m\\xc6\\x0f\\x8c\\xed(\\xc7\\xc3\\xf5\\x9b\\x85\\xbc\\xc8\\x1bc\\xe9\\xdc\\x81\\xde0\\x8f4\\xfd\\xbd[\\xf7$\\xdbGm\\xb3!\\xccc\\x98\\xab\\x95\\x0b\\xda\\xa7T\\xfe-\\xe7\\xa0}\\xb8\\xcf\\x8b\\x9df\\x1cZR\\xf7\\x88\\xfe\\x8d\\xf1\\r\\xed\\xb6\\x8d\\xc7@)\\x1f\\xe5:\\\\O\\xf1\\xa0\\xbf\\x8d\\xce-\\xa1\\xef,\\xa9\\xcf\\xd9\\x9c\\xd2A\\x9b\\xf3\\xcb\\x04\\xfd\\xd6.\\xebE\\xe6)\\xfbVg\\xdeV\\x0el\\x03\\xe5\\xbd\\xd8>\\xc6i\\x15\\xbc\\x9c#\\xed\\xa1\\xf5\\xef\\xf1\\xe2G\\xca\\xeb\\x9c\\xf2:\\xefJ \\xf7</\\xd3\\xbb\\xca\\xdc\\x0b/\\xb1&\\xcf*\\xd1\\x8bM\\xb2\\xb1*|6\\xa8W\\xd2\\xf9U\\xb9\\xc6\\xa0\\xce\\xfd\\xec\\xa5\\xef\\xb4wY\\x0e\\xbbV\\xbfO\\xbd\\xce\\xf0\\xa2\\x8b\\xd4I\\xe6m\\x96\\xab\\x85\\xcf=\\n\\xea\\x81\\xfa^be\\xc6F\\xf1\\xb7\\xf43\\xe7\\xa9\\xa5}\\xb5\\xb5\\xbf\\x8e\\x8e\\xd1N\\x99\\xecp\\r\\xcc\\xa1\\x97\\xeb\\xbb\\xe3\\x83\\xe7\\xacm\\xcf[\\xdb\\xdec\\xdf\\xe5\\xb7\\x1a\\x04%\\xfd\\xa3\\xd9\\xa3D]\\xbb\\xd5\\xe9\\xc7\\xd7\\x81\\x86^\\xe2\\x05\\xe6\\xde\\x8c\\x1d\\xac\\xcd|\\xa4\\x8b\\x93|\\xa1\\xb1\\x97\\x1c\\x9a\\xf90\\xe3\\tk\\x9bMc\\x9e\\xd4\\xccK\\xbeK{hu\\xcb?[\\xf9\\xc8f1F\\xa2\\xac\\xd3\\xa61\\x07\\xb0q\\xee\\xbd\\xe5\\x0c\\xb4\\x01\\xb4\\x07\\x8c\\xeb\\xdb\\x836^t\\x8b6\\x91\\xf1b;/\\xbe\\x98\\xf1\\x88\\xfd\\x960V\\xb29\\xf6<c\\x00\\x8b\\x93\\xb2\\x03\\xfd}\\x1c<\\t:{\\xc9=\\x19\\xa3[\\xdc\\xcf\\\\\\xfa\\t\\xf0\\x94\\x8eQ\\xd7\\xeb\\x06c\\xf6|\\xba\\xce\\xeb\\xa8\\xefJ\\xd7g:\\xea{_\\xf6\\x92\\xc7u\\xd41\\xbek\\xa6\\x8f\\xf2\\x11\\xfa.\\xda\\xe5ENb\\xc3\\xee^l/u\\x9e\\xf1@O\\xd0\\x0b\\xf4\\xf1\\xe2{\\xac\\xaf7\\xe8\\xab\\xed^A_\\x0f\\x9d\\xdbS\\xc7\\xe3\\x03\\x9bo\\xb1K\\x7f/\\xf9\\xc5\\x00/\\xbe\\x9a\\xf1&\\xfd\\xb6\\xb5yW\\xc3\\xbb\\xadA^\\xe2\\x91!^r\\xce\\x05j\\x8b\\xac\\x9f\\xfa\\x99\\xa1\\xf38\\xa7\\x93\\x8eq.\\xedm\\xc5`^\\r\\xadg\\xa8\\x0c0\\xd6b\\x8c\\xf6\\xba\\x97\\xf3H\\xd7=\\xe6]\\x91\\xad\\x81\\xfb\\xcd\\xd8\\xe0\\x94\\xea\\xde\\x08\\xddO\\xf3\\x15\\xf4\\x13\\xa3\\xbc\\xc4y\\xa3\\xc1X\\x1f\\xc5\\x82\\xd6\\xff\\xbc\\xce\\xe18\\xe3\\xeb\\x95`L\\xd0?V\\xe7Y\\xdf\\x18\\xf5wv\\x0e\\xcc\\xbf-~`\\xee\\xcf\\xbc\\x9a97}/c\\xfe\\t>*-\\xa6\\xda\\xe8%.\\xa2\\x9e\\xbe\\xa4s[\\x06\\xbf}\\x96\\x9e\\xf9$\\x9d[_\\xed\\x80\\xc9y\\xe7\\xe0\\xb7\\xa6\\x04:f\\xf1\\x1d\\xef\\x8f,\\xff\\xe1}\\x18ez\\xaa\\x9e\\xcfe\\x95\\x1b\\xca\\ne\\x9ey\\x01\\xef\\xa0\\x18/\\x9bM\\xa0\\x9e\\xcdP9\\xec\\x12\\xd4\\xf3\\x05\\xeb\\x9b\\xed\\xe5.\\x8ay\\x8b\\xd5\\xb3\\xd5\\xcf\\xf2\\xbc\\xe8\\xf7\\xec\\xfc\\x18\\x03T\\x0fl\\xe5B\\'9\\x0f\\xef\\x9d\\xe6z\\xb9\\x03\\xe5]\\xa8\\xd5y\\xbfB[\\xc2;\\xba\\xb7\\xb8?^tta\\xd0\\x1e\\xac\\xe7\\xd8^\\xfb8\\xce{>\\xc6s\\xa3\\xb5\\x8f\\xf3\\x1f\\r\\xbeE\\x1bf~\\xe8l\\xa0_K\\xbd\\xc4\\xbd\\xbc\\xf3a,@\\xbb\\x97K\\xed\\x1bc4\\xc6\\x086\\xc63\\x0em\\x89=\\xcf;\\x12\\xde\\x83\\xe6t\\xd1\\xdd\\xaf\\x0b~\\x7f\\x83\\xc0~\\xdf\\xa6>\\xe6Y\\xf5\\xbd\\xb4\\xbb\\xf4U\\xabT\\x0eWj\\xdd\\xe2\\xa6\\xc2:n\\xfd|\\xde\\xe2\\x07\\xe6\\xbc\\xbc{\\x9e\\xa5>\\xcal%\\xf70Q\\xd7\\xcd\\xdf\\xb3^\\xf7\\x98\\xeb`\\xecI\\xdfb\\xfd\\x94\\xb5y\\xc1s\\xbc\\x0bd\\x9cmv\\x802k\\xb2\\xc8|\\x81r\\xcc\\xbc\\xe0C\\x95\\x9dj*G\\xd6\\xe6Z,v\\xa3\\xbeZ~\\xb1\\x95r\\xe6\\xc5\\xff\\xef\\x08\\xda;\\xbd\\xdc\\x8d\\x96\\xd3\\xbem\\xda\\xde\\xaec\\x8c\\xc3\\xb6\\xea3\\x1f\\x83O\\xc0.}\\xd6\\xe6\\xd8\\xd8\\x0e\\x1d\\xdf\\xa1s\\xd2\\xd4F\\xec\\xf6\\xd1\\xfd\\xab\\xad\\xc1\\xfa,\\xde\\xa0\\xfe\\xec\\xf5\\xa2S\\xcc\\x97\\xa6\\x04\\xfd\\xfb\\xc0~p\\x00|\\x06>\\xd7\\xb1\\xbd\\xc1x\\xa6\\xce\\xc9\\xd4y\\x99:7S\\xe7s\\xefV\\xab-e\\xfe\\xb3+\\xf8\\x0e\\xf5\\x96g\\xcd\\x98\\xf8\\x0b/q\\xbf\\xd5O\\x81# \\xcb\\xcb\\x1d\\xcaQ\\x1f\\xdd\\xa7P\\xdey\\'p\\xdcGe\\x96\\xce\\xb7\\xfaT\\xb5Q\\xf6\\xdc\\x97\\xe0$\\xf7\\x15|\\x15\\xf4\\x9d\\xd0\\xfe\\x13:vB\\xc7\\xf9\\xfc\\x11\\xfd.\\xbfIyd\\x9cJ\\xf9<\\xack\\xe5\\x1a\\xcf\\x04kg\\xfb\\xb4\\xf6\\x9d\\x0f\\xda\\xe7o\\x99\\x7f\\x16\\x9c\\x0b\\xeag\\xb4\\x1d\\xce\\xbf\\xb9~\\x94\\x17\\xc0E/q\\x1cc\\xb6\\xef\\xb4}I\\xc7\\xac}Y\\xeb\\x97\\x82ve\\x9d\\xc3g\\x1f\\xd2:\\xdfa\\x7f\\xd4\\xa3\\xadwH\\x9dw\\x82\\xd4c\\xc6\\xea\\xf6\\xff\\x15\\xde\\x7f\\xf1\\x7f\\x1b\\x8c\\xc3x\\x17Q\\xcaI\\x8eB;\\xc5{\\x11\\x8b\\xb5i\\x0fy\\xb7N\\x1d\\xe2\\x9dy\\x82\\x93\\xbc\\xda\\xee\\xa0\\x99\\xa30\\xbe\\xa6\\\\2o\\xb4;Y\\xde\\xbfvW\\xbb\\xc0<\\x8b~\\x8a\\xf7\\x9a\\xb4s\\xbc\\x87d\\xdc\\xc1\\xdc\\x86\\xfeg\\x9c\\x93;6\\xde\\xc51\\xcea\\xce\\xc8\\xd8\\x876\\x9f\\xb9\\xe4\\xdb.\\xba\\x0bb\\xcc\\xb6B\\xe5\\x8e\\xf71\\xbcw\\xe1\\x9d\\n\\xf3\\x7f\\xbb\\xdf\\xa0\\x1c\\xd2\\xf7\\xdb\\xbd\\x02\\xef\\x0bx7\\x90\\xa5\\xb2\\x9a\\xad\\xf2\\xc3X\\x919&\\xf3H\\xe6\\x8d\\x8c\\x1b~W\\x1bE}g\\xae\\xc5\\\\\\x88\\xbe\\x8a\\xf9\\x0b\\xf3\\x13\\xe6\\t\\xcc\\x0b\\x98\\x030\\x86\\xa7\\xcfg\\xfc\\xcd\\x18\\x99\\xf1*m\"cV\\xc6\\xa4\\x8c-\\x19O\\xd2\\x9fY\\xdc\\xc7X\\x8d\\xb6\\x961\\x15\\xe3\\'\\xc6@\\x16\\xd30~\\xa1\\x8d\\xa2\\xbde\\xec\\xc0\\xb8\\x82>\\x9f>\\x9b>\\x98\\xbe\\x95\\xfe\\x92~\\x90\\xf6\\x89>\\x8c~\\x8a6\\x99\\xbe\\x85\\xb6\\x9b6\\x9cv\\x9bv\\x99\\xb6\\x956\\x906\\x91v\\x8f6\\x8e\\xf6\\x8c\\xb6\\xcbl\\rm\\x0b\\xf5\\x9e\\xfaN\\x1d\\xa7\\xde\\x1eW\\x99>\\xab\\xf2zAe\\xee{\\xf0\\x03\\xb8\\x06~\\x037@\\\\\\x1c\\xf2S\\x90\\x07\\x14\\x00w\\x81\\xc2\\xa0((\\x01J\\x83\\xb2\\xa0<\\xa8\\x00\\x1e\\x02\\xd5@MP\\x0b\\xd4\\x01\\xf5@\\x03\\x90\\x08\\x92@3\\x90\\x0cR@[\\x90\\x06:\\x80N\\xe0\\t\\xd0\\x19t\\x05\\xbdA_\\xd0\\x0f\\x0c\\x04C@\\x06\\x18\\x0eF\\x81\\xf1`\"\\x98\\x0c\\xa6\\x80\\xa9`:\\x98\\t^\\x03o\\x80\\xb9`>X\\x00\\x96\\x80\\xa5`5X\\x0b6\\x80M`3\\xd8\\x02\\xb6\\x83\\x8f\\xc1n\\x90\\t\\xf6\\x83\\x83\\xe0\\x18\\xc8\\x02\\'A68\\r\\xce\\x83\\x8b\\xe0*\\xf8\\x11\\xfc\\x0c~\\x05\\xd7\\xc1\\r\\x10\\x07\\xa7\\x97\\x13\\xe4\\x01\\xf9AAP\\x08\\x14\\x01\\xf7\\x82\\xe2 \\x06\\xca\\x80r\\xa0\"\\xa8\\x02\\xaa\\x82\\x1a \\x1e\\xd4\\x01\\xf5@\\x02h\\x08\\x92@S\\xd0\\x02$\\x836\\xa0\\x1dx\\x1ct\\x03=@/\\xd0\\x07\\xf4\\x03\\x83\\xc100\\x12<\\x07\\xc6\\x82\\x17\\xc0\\x040\\x11L\\x033\\xc1l0\\x07\\xcc\\x03o\\x83\\xc5`)X\\x06V\\x805`\\x1d\\xf8\\x00l\\x06;\\xc1\\x1e\\xb0\\x0f\\x1c\\x00\\x87\\xc0Qp\\x1c\\x9c\\x00\\'A68\\x05\\xce\\x81\\x8b\\xe0\\n\\xb8\\n\\xfe\\x0b\\x00\\x00\\xff\\xfft\\x99\\x078\\x97]\\xfc\\xff)\\xa3(\\x19!d\\xaf\\xf0\\xb5IV\\xdf\\x93=2\\xfa\\xda+\\xe3A\\t\\x85\\x904\\x84\\x8a\\xca\\xcah\\xd1\\x9e\\xb4w$>*\\xf5\\xb44\\xe4A\\xf5\\xa0\\xe7iO4\\xf44\\xff\\x9f/\\xf7\\xb9\\xaf\\xff\\xaf\\xdf\\xf5\\xeb\\xeau\\xbd\\xafs\\xees\\xee\\xfb|\\xef\\xfb\\x9c\\xcf28Z@\\xe0+\\xf2\\x13\\x11\\x10\\xc2\\xff\\x88\\x08\"\\x8eH R\\xc8DD\\x19\\xd1D\\xb4\\x11]D\\x0f\\xe1 \\xc6\\x889b\\x85\\xd8\"\\\\\\xc4\\x01qF<\\x90\\x99\\x88/\\xe2\\x87\\x04 !H82\\x1b\\x89Fb\\x919\\xc8<$\\x19IA\\x16\"\\x19H\\x16\\xb2\\x14\\xc9Ar\\x91\\x95\\xc8j\\xa4\\x18\\xa9B6![\\x90\\x1ad\\x1b\\xb2\\x03\\xd9\\x8d\\x1c@\\x0e\"G\\x90c\\xc8\\x19\\xa4\\x01iD\\x9a\\x10@.\"\\xad\\xc8U\\xe4\\x1ar\\x03\\xb9\\x8bt \\x0f\\x91\\xbf\\x91>\\xe4\\t\\xf2\\x02y\\x8d\\xbcC\\x06\\x90!\\xe4+\\xf2\\x13\\x19-,  \\x8a\\x8cE\\xc4\\x11\\tD\\x1a\\x91E&!J\\x882\\xa2\\x86h\"S\\x10\\x03\\xc4\\x181C\\xac\\x10\\x1b\\xc4\\x1e\\x99\\x818!\\xae\\x88\\x07\\xe2\\x85\\xf8\"<$\\x00\\tA\\xc2\\x91H$\\x06\\x89E\\xe6\"\\xf3\\x90\\xf9H\\n\\x92\\x81d#\\xcb\\x90\\x15\\xc8J\\xa4\\x10)A\\xca\\x91Jd\\x03\\xb2\\x19\\xa9A\\xb6#\\xfb\\x90Z\\xe4(r\\x029\\x85\\xd4#\\x17\\x90K\\xc8U\\xe4\\x06\\xd2\\x86\\xdcE\\xda\\x91N\\xe4\\x01\\xf27\\xf2\\x18y\\x8a\\xbcD^#\\x03\\xc8G\\xe43\\xf2\\x05\\xf9\\x8a\\xfcDF\\x8b\\xe0\\xbbB\\xa4\\x10\\x19D\\x16\\x91G\\x14\\x10%D\\x19QG\\xb4\\x11=\\x84\\x83\\x18#f\\x88%2\\r\\xb1E\\x1c\\x11g\\xc4\\x15qG<\\x11\\x1fd\\x16\\x12\\x88\\x84#\\x91H,\\x12\\x8f\\xccE\\x12\\x91d$\\x15IG\\xb2\\x90ld)\\x92\\x83\\xe4!\\xfc\\x7fc\\x11I\\x0b\\x9c\\xb3\\xfe\\xed\\xd2\\xe6\\x90\\x9d\\xa4\\xe4u\\xef\\xa7\\xcd\\xaf5!\\xadw\\xde\\xd6s\\xb1j\\xf0,L\\xf5/%KI\\x98x\\xc3\\xf0\\xf0\\xea=\\xb2\\x84Q\\x98g2\\xfe\\x92\\xab\\x96\\x019v\\xd5\\xc9\\xe3d\\xad\\x1c\\xec_4\\xb0\\xfc\\xd16U:\\x0e\\x92\\xb2\\xb2\\xf7r\\xfc\\xf2I\\x9a\\xdc\\xe7S\\x97~\\x05\\xc2\\xc8\\xd3B@w\\xc7\\x9ac\\x8f\\xa3\\xd3\\xc0t\\xb3\\xfe\\xa4*\\xf0\\x80\\xb9\\\\\\x9e\\xd3\\xea \\x1es]\\x8d0\\n!\\x85\\x12\\xb9\\x9a\\x82\\xb2\\xe4\\xf4\\xfc\\xfc\\x07\\x0b\\x92\\xbf4G\\xc8\\xc9T\\x97\\xde\\x18\\x0fC\\xc1_\\xef\\x08\\x0b\\xeb1\\xe3\\xfa\\x9a\\xcb\\xafO\\\\(\\xf9Q\\x08\\xfe\\xea[\\x16`t\\x7f\\x1c\\\\\\x1c\\xfa)\\xf2V[\\x1e\\xe8s\\x19%\\xcf\\xbf\\xd5\\x0e\\xdcK\\xd6\\xa2\\nW\\x1b\\xce\\x15\\x8b\\x04\\xa6\\x92\\xbb\\x1a\\x0f\\xff[\\xde\\x16\\t:O\\xf2\\xb7\\xdd\\xba\\x1c\\x03e\\x89\\x8e\\xad\\xd3>\\xf8\\x91\\xb5\\xb7\\xae\\x9e\\xde\\xa9\\xe3\\x0e\\x062\\xcbk\\xb7\\xe7\\xd8\\xc3\\xe0\\xa6\\xdc\\xeb_D\\xf5\\t\\xaf\\xf3\\xc17\\xff\\x80O\\xcd\\xb1\\xcf\\x93\\x932\\x9d\\x04!\\xe5d\\xd6q\\x93q\\x9a@\\xfb\\x19\\xe5\\xd2\\xeb\\x8c\\x92\\xba\\xd3&\\xe2o\\xc7M\\xa6\\n\\xf4=\\xd3\\xf9l\\x7fy\\xd0\\xf3I\\x92\\xde\\xa4hg\\xcd\\xdc\\xa0k\\x96\\xb0\\xf7\\xe3LcS\\x9d\\xc9\\xf0Y[i\\xc2\\x99i2@\\xfb\\x07g\\xdc\\x8e\\xef\\x10\\r!\\xdf\\x16\\xfb\\xad\\x17\\xab6\\x05\\xaa\\xdc\\xa0\\xb0\\xe3\\xcd5\\x1cpJX\\xd0\\xbf\\xea\\xae\\x1d\\xd0\\xf7\\xc4(\\x97\\xde\\x8f\\xd1\\xdf\\xe7\\xff\\xaf\\xf6\\x18\\xfb\\xea\\x80\\xed\\x0bC\\xc9\\xab\\xebs\\x16\\xab\\x1cp\\x80\\x05\\xb9B\\xad\\xa5\\xaa\\xb3\\x80\\xb65J2R\\x95Z\\x93I\\xd4\\xa8\\xb3\\xef\\x9e-\\xf3\\x07\\xee\\x95G\\xa7Wr\\xc2\\xe0\\xc8\\x99\\x98\\x9c\\xee\\x08-\\xf08\\xab\\x9d\\xd6b\\xadJ\\x18\\xa5m\\xf8R\\xb8I\\xda}\\x9c5)\\x1a\\xbcy#zH\\x9aY\\xa7\\x1e\\xdct^\\xaa\\x1b\\xaf\\xcd#\\xa5u:\\x85\\r\\xc6\\xce }qw\\xb1\\xe6\\xd4\\xe9`\\x16`\\xa2_\\xbb$\\x9b0J\\xdb\\xa0\\x1c\\x1ak\\xdb\\xfb\\xa9\\x94\\x08_\\xd6\\n\\xffSS\\x02\\x92\\xc6\\xfe\\xb7\\xe3\\xf9\\xe6<X\\xd2\\x14_\\x9f\\x94\\xaeB\\xb6\\xbf\\xd4\\xbebV,\\x05\\'\\xdf\\xb8G-l\\x1b\\x0b\\xde\\x91\\xb7;9ge\\t\\xa3\\xb4\\r[\\xce\\xe4\\xc4\\xed}iGV\\x18t\\x1f\\x97\\x9ad\\nU\\xef\\x8e\\x9cT/U\\x80\\x9a\\xfd6O\\xe2\\xa3L\\x98\\xfd6\\x11j?\\xbf\\xcc\\xba\\t:p8\\xa1\\'u\\xed\\xdaPr\\xa4+2\\xd3G\\xc2\\x07Tw\\xddU\\xbe,\\xe2\\x02\\xb4\\xcd(\\x99\\x13\\xedc\\xfb\\xdd\\xd2\\x80*\\x04J\\x18\\x9e\\xd8\\xban=I\\xc6\\x8d\\x98\\x1a\\xbe\\x1e\\x8c\\xe7\\xef\\x16l\\xac\\xd2\\x85>\\xc3\\xb2\\x1d_\\xa4\\xe6\\x11\\xee\\x8f9\\xb7JU\\xd5\\x99\\xf7\\x91\\x00[\\x1c\\x9e[f\\xba\\x9b\\x93q\\xaf\\xc2\\x9e\\xa5+\\xe8\\x80\\xb2\\xfa\\xe8\\xc5\\x99\\x8b\\xd5\\x80\\xb6-\\x9a\\xb7\\x8c\\x16\\xb2r\\'\\xfb:\\xca\\xce]-\\x9f\\n\\xe9\\xa2\\xc7\\xcdW\\xb5\\x99\\x00mw\\x8c\\x9d\\xab\\x91t?\\x94y\\x9f\\x01ph2\\xbe\\xb0\\xaa\\xf5DE)7+\\xc2G\\x17\\xe8:\\x16\\xee\\x1c<\\xfa4@\\x08\\xae\\xf8z\\x9f:\\xe8\\xebD\"~:~}\\x9b8\\x83=O\\xfd\\xe6F\\x93\\xc7\\xa8\\x13\\xc2(\\xac\\xeb\\xcb1\\xe8\\xb6v\\'\\x0e\\x8e\\xbf\\x84\\xe4\\xbf\\xe9B\\xcfS\\x8d&\\x19[G8\\xd1y\\x9e\\xdb\\xf3\\xaf%IV\\x9e\\xfc\\xc6\\x8b\\xa3\\x00\\xf0b\\xf0Y\\xca\\x0f\\x19\\x98?\\xf7\\xba77X\\x16\\x94\\xea\\xe7{,\\x1e/\\xcb\\xda\\x97\\xfa\\xab\\xf7\\n\\x8c^\\x18\\x92B\\x99M\\xde\\xafE\\x94\\x80\\xae\\xcb\\x86\\x98\\xb8\\x96\\xba\\xda\\x93K\\xdb\\x1f\\xdfR\\x0c\\x17\\x07\\xbd\\x1b\\x92W\\x1b\\xe6r\\x86\\xd7;\\xe0\\xb9\\x85x\\xfe)j_\\x9d\\x1b\\x0e.g>\\xfc\\xf0\\xef\\xa8\\x84\\x03A\\xd7\\xcd.\\xaf\\x8a\\x07\\xab\\x92\\xe0u>\\xf5\\x9eP\\xe6\\x1d\\xf1\\x1f\\'\\xc4\\x97\\xcc\\xe6\\x0f\\xbc\\xed\\nN\\x16\\r\\xf9]c\\'\\x01\\xff\\xf3\\x16\\x16\\xe8\\x02\\xed7\\xe7\\xff\\x1b\\x1fG\\xd0Z9N\\xbe\\x1a\\x06K\\xe6\\xaa\\x1a|\\xf1\\x9a8\\xb2\\xbe$ix\\xe9f\\xf4K\\xbd\\xde\\x91\\xecl\\x8a\\xf3\\xde\\xe8<\\r\\xa2\\xf7\\xbd\\x8d\\x0c\\t1\\x02j\\xf7\\xce\\xa9\\xacz=\\xeb\\x8b\\x16\\x81\\x8c\\xd6\\xa2~\\x17\\x19\\xe8\\xfd\\xf2\\xc0\\xdc\\xd3#\\x90\\xec\\x16i7Y\\xda\\xef\\x00\\x93_\\xff3Uq\\x8f;\\xb8\\xa6\\xfd7\\xe1\\xe5\\x1cC\\xe2\\xbb\\xdf\\xaeAj\\x83\\x12{\\x0eJD\\xfa\\xe5\\xdc\\x92\\x9c\\xc8\\xd2\\x8e\\xeb+#\\xbfZ\\xc2\\x0e+\\xd9Z\\x93\\x1e3\\xe8\\xa8\\xba=h\\xd7eA\\xacu\\xd6}+u\\xd2\\x04\\xad\\x1a\\xb9\\xc6\\x17\\x89:\\xac\\x1d\\x18\\x15\\xe7w\\xa4\\x7f\\xaa9\\xf9\\xd1X\\xeb\\xb6\\xea.\\x07j\\xbcOt<\\xad\\xa4\\xf6S\\x01Rm\\xae\\x05n\\xf4\\x13\\x00\\xda\\xae\\xef\\xdd9\\xe5\\xce/\\x1f\\xb2m\\xc9\\x84\\x8d\\x93\\xaf\\x1a\\xc0=\\x81\\x9eQc\\xdf9\\xb3\\xe3\\x18%a\\xda\\xc1\\x93\\xdbNY\\x13\\xdb\\x8b\\t-\\xeb\\x8c\\xcc`\\xdcS\\xa7\\xf3b\\n*\\xe0\\xfa\\xafo\\xb3\\xb8\\x81\\x1aa\\x14\\x02zJRB\\x05LI\\xf6\\x99\\x1f\\x8f\\xb7\\xa6=m\\xbe\\xbb\\xb88bW\\x83\\x18k\\xcf2\\x94\\xeb\\xf4\\xae5\\x88\\x03\\xbd\\xce(\\xd7\\xa23a\\xcf\\xde)\\xb3\\xc85\\xbbA\\xd1\\xd1\\xf23A\\xef\\xd4\\xa1oW\\xcb\\xe5\\xa0\\xbdk\\xb6x6W\\th?\\xa3\\xa4f\\x97f\\xfd\\xd2\\xf6B\\xb2&\\xf2\\xf8\\xeau\\xe9\\x9aPQ\\x9b7\\xcb\\x9d\\xb7zd]\\xd5\\xb3@~\\xcbk\\x8b{=>\\xe4\\xe4\\x92\\xc1c\\xbe\\x89Vp\\xbec\\xe1\\xbdo:F\\xb0`|RUT\\xae6p-g7\\xb8\\x7f\\xe7\\x00\\x9d\\xcf(\\xa1\\xf7\\xa1\\xf3\\x8eV\\xc6\\x15\\xfe!UD\\xb8\\xff^\\xcc-\\x13\\xf1\\x05G;ic\\x9f\\xf7j\\xd0\\x1ce\\x95\\x14v\\xc7\\r\\xfe\\xb2\\x16\\x89=*j\\x04\\xd1?\\xb6_Z:\\xc3\\x8a}>\\x1d\\xcf?\\xc6\\xc2\\xe1\\x0b\\xc9\\xca\\xdc\\xe7=\\x97VM\\x05\\xaa\\xd7F\\xe9\\xa4\\xbc\\x16\\xb1\\x85G\\x1f\\xe7py\\x8d3\\xe1\\x83\\xdd9\\xdb\\xc4N\\x17v\\x9d\\xf49u\\x12\\xf5\\n\\xf3\\xfd]\\xc8wE\\xf7\\xbc\\x94*5\\x88\\xbe\\xd4n\\x10\\xd7\\xad\\x06\\x8e7\\x1ar8\\xb1\\x82\\xf0\\xb3\\xb3>\\xc1\\xbcM\\x90\\xfd]\\x8c\\xfe\\xfe\\xbc\\xff\\xd5\\xa6\\xcfg\\x94\\xd4\\x9a\\x9c\\x91|\\xb2\\xc3\\x99\\x1c\\xa8\\x8dK\\\\6C\\x17HK\\xebZ\\xc5=\\xd6 \\xbc\\x7fzY\\xe3\\x07y\\xa0\\xfd1+\\xfb\\xe7\\xfe\\x8b\\xe7r\\xcd\\xdbw\\x82\\r\\xc6\\x9f\\x9a\\x9dc\\xf2\\x14\\x9b\\x84\\x05 \\xa71\\xe8\\xf0\\xcc\\'^\\xc4cI\\xbe\\xf1\\xcc\\x9ff\\x90\\xc0\\x13k\\xb8\\xb0\\xd2\\x0c<\\x0f\\xaa\\xa7\\x96:O\\x05\\xda\\xdf9\\xabCh\\x16\\xd7od?\\x16j\\xc2\\xa8\\x0ena\\xec\\x011\\xc8\\xdf)a\\xf0\\x88\\xa7\\t\\xc9\\xd6\\x1b\\xff\\xa9\\xab#\\x90\\xdc\\xfa\\xf3\\xc4\\x92\\xb4\\x9f\\xcdocS*\\x1b\\xe7{\\x92a?\\xaf:\\x03T\\xb76\\x0c\\x86l\\xb3\\x00z\\xee\\x16\\x19\\xaa\\xab~\\xf4\\x8f\"\\xc5\\x1b\\xe7K\\xe7o\\n\\x85\\xb5\\x81\\xef\\x84\\xe3\\xbd\\xd4\\xc9\\xf0sW\\xc9@\\xf9\\xe8L\\xcb\\xc5\\xfa\\x12@\\xcfC\\xee\\x9bO\\xefJ\\x0b\\xccH\\x86F\\x8b\\xbf\\xf9\\x12I\\xa0\\xfe\\xc1K\\xb6\\xc8\\xe3\\xd5\\xf3\\x85\\x84\\xc6!\\xc7\\xd20\\xf2\\x19\\xc7\\x81\\x07O1\\xd0\\t\\x1b\\x07\\x05\\xbd^g\\xdf\\xf8\\x8e\\x01\\x1d?\\xe1\\xdd\\xe56\\xba\\x84QX\\x11U\\xa2\\xd2\\xfc\\xde\\x939_N0*\\xcf:\\xfb{\\x931\\x1b\\xcf\\xd0q\\xf4zr\\xe0\\xb2#g\\xaa3\\x08=\\x17\\x9bw\\xac^\\x10\\xed\\xa5Fn\\xc6\\xc4|H\\xb5\\x97\\x81\\xfb\\x06q\\n\\xff\\xfc3o\\xe4~$\\x92\\xb1_\\x81\\xec>\\xa1\\xfdQO\\xefh<\\xccL#\\x15E5\\xab\\xec\\xa3\\x1dA?(k\\xe3\\xbatGX\\xa0\\xcf\\x8bN\\x92\\xd2\\x85\\x9c\\x1e\\xff=\\x17\\xc1\\n\\xdazW:\\x08\\r\\xfa\\x91\\xef\\x96!\\xbbU\\x0e\\xf0`k\\xd3\\xb6\\xa3!\\xdb&\\x02\\x9d\\xc7(\\xa1\\xf3\\x19%\\xf4>t\\xde\\x1b\\xf97\\xab\\x93\\xf3\\x83\\x88\\xc2\\xf55\\x99\\xb2\\xe5\\xaa\\xf0\\x9b\\x92&\\xaf\\x9c\\xcf\\x9a\\xc5\\xa6\\xa4\\xbd\\xfbZ\\xdf\\x94\\xcd\\xda\\x10\\xf1\\xa3K\\x8b;Ji$\\x8e\\xd36&*-\\xc5\\x95\\x86\\xe5\\xf2\\xd0\\xab\\xe4(\\x90\\x12\\xae\\t\\xd4\\x8fk\\x13/\\xc30)?\\xb2\\xf1W\\xd9\\xf2o\\x83\\x04F\\x19\\x14\\xc8\\x85XW\\x10\\xe9\\x89\\x181HE@\\xe0\\xf6\\x83\\x87\\xbb\\xc6\\x16\\xc2Y\\x0c\\x1b\\xec\\x8b3F\\xf6\\x87\\x98\\ra\\x14\\xa8\\x9f\\xa1\\xed\\xb3\\xd9\\xde\\xd9\\xbd\\xaf\\xfc\\xc8\\x95\\xfd\\x02\\x93ngMe\\xde\\xbb\\x16tm}g7\\xe0\\xaf\\x01<\\xbeaV\\x08\\x1dy\\xde=O@o\\xd2\\xfb0\\xca\\r\\n\\x1ek\\xc6x\\xc4\\x04\\x90\\x87\\t\\x89N&=\\xd2\\xd02\\xbf\\xeb\\xcc\\x94\\x1b\\xa6\\xccw4\\x03\\xb1\\x8fk\\xec\\xdcy.@\\xaf3J\\xed,ko\\x13\\x040\\x12Z\\xefD\\xbeL\\xfd\\xd1]:\\xd1\\x02\\x1e\\xe0\\xebX<\\xde\\x12\\xee\\n\\x7f2\\\\\\xf8&\\x90$\\x9e\\x8d\\x98{D\\x99\\xc7\\xf8Esx\\xf8\\xbd\\xf9\\xd5\\x9f\\xeb5\\t\\xa3P`\\xe6\\xdf\\xea\\x9f\\xdd\\xcfe\\xb4\\xd9q\\xf4\\xf1\\xa4g\\xbe\\x82\\x84Q\\xf8m\\x1c\\xbd\\x0e\\xfeE\\x1f\\xacv\\x1e\\xb3!?\\xdd\\xa4\\x14\\x02\\x07\\xc4\\xe1\\x157q\\xf9wK%\\xf8f\\x93\\xd2V\\xc8\\x13\\x87\\x03W<\\xad\\xd6\\xe4G\\x13\\xcf\\xcc$\\xa1\\x7f\\xa2\\x1d\\xd88\\xad}\\x9e\\xdb\\xa3?\\x16\\xbbBhW\\xbbD\\x8e\\xac9\\xeb\\x0f?k:\\xc7\\x06\\x0bsHP\\xa5t^@\\x87\\x10\\xa4\\xf9\\x04-\\xe2l\\x90\\xa5\\xf18\\xd0~W{\\xa7\\xdd\\xb6_\\x0c\\xc8\\xe5\\xa8\\x9fb\\x9b\\xc5\\xc5\\xd9s\\xb3\\xbd\\xa2\\xc7\\xaaI\\x85\\x10\\xce\\x966o\\x11+3\\xa0\\x1a\\xdc\\xaa\\xb4\\xd95\\xc6\\x81\\xdc\\xa81Z\\xb7\\xa6\\xd8\\x0c\\xee}\\xbb\\xd2\\xb9\\xad\\xc5\\x9e\\xd0\\xe7\\x0f\\xb8<[\\xcf\\r\\xd6\\x06z\\x9d3\\xb0\\xe2\\x84\\xdeY;\\xd2r`\\x8f7\\xf1\\xd3b\\xf3\\x05AtSk\\x95\\xe3\\xc9\\xcdl\\xd3J\\x19[?\\x18\\xd9?&\\xcc>2\\x81\\x01)S\\xed\\xf2/\\x84L\\xba\\xbdcg\\x8e\\x86<\\xd8\\x15n\\xd5Ko\\xd3\\x03\\xea7\\xab\\xb6\\xd8\\xdf\\x11[*\\x07\\xd4\\x8e\\xd1\\xf7F\\xe7\\xd3y\\x1fJ\\xfc\\xd2\\xb5\\xc4\\x1d\\x89\\xf5\\xf8Y\\xab\\xb82*\\xf0\\xf4~\\x9b\\xc9i\\xed1\\xec}\\xe8\\xba\\xffB\\xb3}\\x05\\xd7\\xf9\\xbd8\\xf3Q\\x7f\\x98\\x18U\\xa0z\\xe5\\xf1\\xcd\\xa3\\xcf\\xca\\xb4\\xc8\\xa6\\xcf\\xb7~t|P\\x02q=n\\xed\\xe7b\\xc7\\x91x\\xab\\xd3\\x1c\\x86\\xf7\\x8b\\x939x\\xd7_<\\x1f\\xae6\\x93\\xe4\\x98\\xf4?Z\\xd2o\\xc6~\\':\\x8eQ\"\\x7f\\xff\\xec\\xcd\\x97\\x83\\xc6T\\xe1\\xf76\\xb3o\\t\\xdd\\xbf4\\xee\\xa4q\\xe8\\xea\\xb4]\\x11\\xab8\\x9e\\x84Q\\x1a\\x17\\xb2\\xf1\\xa2\\xd2x\\x8c<\\xc3\\x17\\x93\\xc9K\\xa3\\xcd\\x02:\\xd2\\x01\\xa3\\x9d\\x1f\\x9f\\xab\\xbc\\xc0\\x06\\xdd\\xdd\\xa2R}89.\\xf5\\xd0:XB\\x84\\x9e\\x17My\\xab\\xbd\\x08\\xd2\\xf9\\x1fR\\xc5\\x1b\\x86\\xd7\\xdd\\xa5\\x0f\\x1fT\\xef-\\x88\\x8c\\x8c$\\xe3ne(&$xAX\\xdb\\xdesuu\\xbe\\x904\\xfd\\xc8xYM\\x03\\xc2(\\x9b7\\xd0<\\x81>\\x7fT\\xa3\\xb0\\xf4\\xc4\\x9dq\\xbf\\xff>\\xf6<\\xd2u\\xd1\\xe7\\x8b\\x9f\\xde\\xb7\\xd8\\xb5\\xac\\x80P\\xbfL\\x7f\\']7]\\xdfp\\xfe\\xa3\\xb8\\x92\\x8c\\xc4\\xd7s\\x80j\\xf8\\xb3\\xf4\\x90\\x99\\xe1S \\xcd\\xf7\\xe2\\xcc\\x87\\xdb\\xa7\\xd2\\xf7\\xc3^oj\\x91\\xd7\\xf1\\xd3K%h\\x15N\\xce(\\xe1\\xb2\\xef\\x81QB\\x7f7\\xa3$H\\xe7;\\x8f\\xbb.\\x80\\x88.\\xb6\\xdf4QW\\x1d\\x9e4\\x13I\\xb5|%P\\xd3\\xd3\\xb8\\xa4\\x7f\\x04\\xe3\\x83\\xff?\\x9eG?H\\xdf\\xc7\"Y\\xder\\xdeS.\\x890\\xff/\\xbe\\xba\\xda\\x9c\\xf4I\\xc9\\xd6UWk\\x02U\\xd16\\x85Y\\x0fD\\x1d\\xc8\\xd7\\x8e\\xc9j\\x9b\\xaa-@\\xbf\\xc8P\\xc8\\xfa\\x85\\x11\\xd0|\\x98\\xdaYz}^A\\xb3N\\xa2\\xa4#\\xf1\\xd14\\xac:k\\xae\\x05\\x0b\\xb7\\xba\\x84\\xea/\\xf0 \\xfc4!d\\xa9,L\\xb8\\xb3\\xcc\\xfa\\xe4\\xd6\\xd1\\x8c\\x9fq\\x81\\x9bw\\xff\\x1d\\x9a\\xda\\xe2I\\xa2\\x17\\xc4\\xb8y_\\x91\\x85)\\xce\\x06C\\xa3*F\\xb3q1\\x8d\\xbb\\xe9|:\\xce\\xdb\\x19W\\xf2\\xc8\\x9e\\xf1[\\xc6\\xec}\\xe9\\xfc\\x9a\\xb5\\xfe\\x93\\xc26\\xc9\\x10\\x9a\\x07\\xd2\\xe7\\xd1\\xfb\\x0ee\\xf4\\xd5H\\x05%\\x12S\\x87\\xacS\\xa9\\xe1\\xa6\\xac\\x9f\\xd8\\x93b/\\xd6Yt\\x89\\x89\\x17.\\xc1\\xff\\xc8\\x0b\\xb1\\x8dQ\\xf6\\xb9\\xd9k/\\xb1~\\x9b\\xfa\\r\\x0e\\xba\\xd1\\xe0}\\x8b\\xc9\\xfb4\\xa9\\xde5\\xef\\x83\\x88]\\xfe\\xea\\x9fcg;\\xc1\\xe2\\xe0\\x03\\x96\\xb7\\xc4\\xb5\\xc0\\x81\\xef@\\r,!\\xaf\\x15\\x0ff\\xa6\\t\\x94\\x1e\\\\\\x1f\\x91\\x90\\xa0\\x0ct\\xdc\\xc4#\\xae\\x8f\\xb3I\\x02\\x99Pc\\xbe\\xeb\\xd4\\x02s\\xc0hq\\xdc\\xa8\\xf3\\xd1\\x90q\\xf0\\xf9\\x9e\\xa1\\xc3\\x82\\x84Q\\xa0q\\xbbv\\xe8`Vh\\xa0:ya\\xbe\\xa3\\xa7(\\xf4{3F\\x13B\\x16\\xc5Ql\\xdc\\xf5p\\xed\\x8f\\xb8\\xa1\\xac0\\xa8\\x1b\\xb8\\xe7\\xf5O{\\x19\\xd1\\xb7)\\xbf\\xf1\\x8b[\\n\\xfb7\\x1c\\xfe\\xe4lf<\\x12o\\x85\\xdb\\x02\\xbe\\x85\\xbd\\x17\\x04g\\x00\\xad_0J\\xc6\\xf0\\x03\\xb5\\xf3\\xba\\xa4\\n\\xc3\\xd1\\x08-5h\\xf7P/\\xf3\\x0c\\x97`\\xe3Iz?\\x05!\\xcc$?\\x96\\x12~y\\xc2\\xea\\xa4/U\\xa0\\xca?n\\xa6\\x8e~\\xc4K2Cu\\xc5\\x13\\x19P\\x1d\\xdcpPU\\x89\\xdau=\\xe0\\xa7O\\x01q\\xf1dX;b\\x81\\xb1\\xaf\\xac\\x9d\\xa5\\xf9\\x1fm\\x9b\\x9c\\xd7\\x9d >\\x10Fh~M\\xe3*\\xf9\\xee\\xb6!\\xbf\\xc0|\"i\\xeb\\xf7\\xa2q\\xbe9\\xd0\\xbc\\x8f\\x7flMJ\\x9cHE\\x99\\xdb\\xc3/K4F\\xe2\\xec\\nk\\x9aG\\x02\\xed\\x1f\\xae\\xc3\\x80\\x13c?\\xc6S\\x057\\xab\\x8b\\xbb4\\x8e\\xc8\\x12F\\x81\\xfa\\xf9\\xa1\\xabK:\\xaeg9\\x10\\xbf;o\\xb5\\x8b\\x078\\xac\\xff\\xa3v{\\xa2\\xf0W\\xa7m{8\\x84\\xefN\\x82\\xdc\\x0c\\xa9\\x02\\xd5\\x18~\\xe1!#\\x908\\x1d\\xe0\\x9d\\x14\\xbd\\xc9\\x03\\x9a\\xef3\\xca\\x9ec\\xba\\x7f\\xcao\\xe4\\xb85\\x87\\xb8\\x11\\xcfCE.\\xd3K\\xc5\\xe0\\xddk\\xb0\\xd6\\x0c\\xd5\\x02\\xed\\xf2\\x17q\\x13\\xabM\\x80\\xf63J\\xe8uF\\t\\xad\\x8b\\xd1zB\\\\\\xafl\\xcb\\xaf\\r\\x1cB\\xe3n\\xea\\xaf\\xd6%ab\\xeb\\xecH\\xb6-\\xf7\\x95\\xd7\\x8b\\x95$r\\x85\\xdb*\\xdd\\x93G\\x037\\xa5JW\\xf2\\xcc\\xd7\\xe6\\xcc\\r\\x13\\x86\\\\\\xdbZ\\xb9\\x8c6\\xd3<\\x8b\\xb6\\xd1\\x1aVv\\xf7M!\\x17\\xae\\x18\\xcd\\xba\\xf0I\\x98\\x8dkh\\x1c\\xf2\\x8c\\xbb\\xa7\\xb7I\\x7f\\x1e[_kH\\xc4\\x0f):\\x05$\\x9aL6\\xebw\\x99\\x82\\xc6\\x8f\\xcf\\x19}K\\xa7\\x03\\xffX\\x18\\x05r\\xe0\\xf5\\xe1\\xdc\\xc3\\xd2n\\x0el\\x1cPp\\xd9~\\xc3\\xf4\"{r\\xbe\\x9a_\\x10\\xd1\\x02\\xde\\xdb\\xf6\\x81M\\xc7u\\x80\\xb6\\x19%\\xb4\\x9fQB\\x9f\\xc3(\\xa1\\xcfc\\x94\\xd0:Q ? \\xc8\\xb1#\\xbf\\xaa\\xaat\\xf6\\xfa\\x9a\\x01\\xfd\\xfd\\xcb\\xffM\\xbc\\xcd\\xb1\\xd6&Y3\\x9c\\xe6=\\x88P\\x03\\xeag\\xf8\\xe6Q)8\\x84\\x9c\\xb2\\x9b\\xf0\\xae\\xcd\\xc5\\x99\\xe6\\xc5\\x84\\xe6\\xc7t<\\xa3\\xec\\xfe\\\\\\x11\\xb7\\xd7]o\\x8a\\x13y_:TW\\xf5\\xd8\\x82\\xadOP{f\\xb1\\xe2,\\xc93\\x8b$\\xeb\\'dO=(\\x16\\n\\xd2\\xf9p]\\xfdk9Y\\x82\\x86\"\\xbad=\\xac}b\\x90[9F\\x1e\\xb4\\xb3\\x15Z\\xd3<\\x03\\x80\\xd6\\x0fi=\\x82\\x8e\\xeb\\xf5\\xc1LEe\\x13\\t\\x8a\\xfa\\xf3U\\xe0/#0Z\\xd8\\xc0\\xd1\\xe1\\x05\\x8d|\\xe7b\\x0f\\x10\\x949\\x97a\\xd5k\\xc2\\xde\\x8fQB\\xef;\\x9f\\xbf\\x90\\x131$\\xef\\xb04GB\\xc1\\x17\\xe8}>Z\\xed\\x94\\x14\\xbcjI\\xe4\\xf6\\xae\\x8c\\nPV\\x80\\xdf\\x94\\xc0\\xcdE\\xfd2\\x1b\\xd5\\xa9\\x02\\xd5\\xe9/\\xba\\x0f}\\xfd\\xd3\\x85t\\xe8x\\xbf[\\xd4g\\x01\\x1b\\x1cq%7\\x8c\\x81\\xe6\\x9bt\\x9f\\t]\\xb3-0{\\xa3Ih\\xfe\\xc97\\xb3\\xa7\\x1bM\\xc8\\x98:\\x97\\xa3\";\\xd4\\xd8|\\x9a\\xe6}\\xab\\xce\\xd4x\\xa6\\xe6\\x12\\xd29\\xb3\\xa9\\xfb\\xd9\\x06-R\\xdf\\xe2[ \\xdb&\\x07Yg\\\\\\x17\\x9c\\x8b\\x94\\x86\\x1f\\x05\\x1f\\x1fv\\xe6\\xcc\\'\\xe8\\x05\\x8e\\x1b5\\xc4\\xc3\\xea\\xd1\\xea!p_g\\xa4\\xae\\x15\\xed\\xce\\xfa5z\\xdd\\x91_0\\x89I%\\xab\\x16\\xd5\\x17\\xbe\\xf7w\\x05\\xd7\\x8au\\xa6\\xc7zd\\x99\\xbc\\xc8\\x8e\\x9d\\xcf(\\xa1\\xf7\\xa9\\xecV\\xab(\\x8a\\xf5#\\x9d\\x16\\xef\\xa79\\xdf\\xb6a\\xf3\\x89t\\xad\\x8d\\xbf$\\xcbJ\\xc8\\xa1\\x03-\\x16\\xe3.yA7\\x86\\x0b*\\x07b`s\\xbf\\xe7\\x8f\\xc6\\x10\\x0e\\xe1\\xb9o]\\xa13J\\x1b\\x0c\\xe4\\xf5\\x7f\\x85\\xce\\x1e\\x0f\\xb4N7\\x9c\\x1f\\xc14&.\\x99\\x00\\x17-\\x17}l\\xae\\x99\\x0c-e\\x1d\\x87\\xb7\\xe5\\xdb2v\\xca\\x10L\\x06O\\xe8\\xc8u\\xc9A]\\x8e\\xe4\\xb5\\xb2?&\\xb3u\\x1a\\x9a\\xe7\\xf4\\xef\\xe7\\x07\\xe4<\\xe2\\xbd\\xb1\\xf5\\xf2\\xb3?\\xa6A\\xb1k\\xedJ\\xddJi\\xa0q\\xdf\\xd4\\x83\\xd3\\x83\\xc2Z\\x93\\t\\xad\\xf7\\x1d}uH\\xae\\xcbVm$\\xff\\x9e\\xa6\\xc3\\xc6\\x8b\\xd4\\x0e\\xd2q\\xb1\\x11\\x8f\\\\F\\xcb%\\x91\\x91skD\\x15\\xa8\\xce\\x8a\\xcf\\x9fiv\\xd1\\x9c\\xcc_\\x13\\x9e\"2A\\x1a|\\xf8\\x05\\x0e\\xae\\x03a\\x94\\xb6\\xe1\\xd85\\xc5O\\x92\\x7f\\x07\\x91\\xbf0\\x1c\\xbb\\xb7\\xdd\\x13\\x9ete\\xafN94\\x9e\\xf5W\\xc3\\xf1\\x17\\'\\x84\\xd8\\xedH\\xba.\\xebm>R\\xdfO\\xf3\\x05\\x8b]\\xa7\\xac\\xbelNg\\xd7]\\xb8*\\xb4\\xbd\\xf1\\x83.\\xb4\\xaaaf\\x90\\x10\\xc1\\xe6c\\xd4\\xce\\xd2q\\xc3\\xfe\\xb5=\\x95\\xd0\\xf1\\x8c\\xb2\\xdf\\x8d\\xce\\xaf\\xcb\\x9b\\xe5\\xbeU\"\\x86\\xd0<{\\xac\\xd2\\xb6\\xd9zgc\\x89\\x03\\x7f#+\\xfa\\xc0P\\xf9\\x95\\xb9\\xca/\\x03\\xa0\\xc0wo\\xfc\\x84\"\\x7f\\x92\\xaa\\xa6%\\xbeI\\xc0\\x0bl\\x05\\xbdV\\x8e7\\x9e\\x06\\xb4\\x9e\\xd7Vx\\xaf\\xa7\\xefm\\x0c\\xf9i`\\xe0\\xe5\\xa1\\xe7\\xc4\\xd6i\\xd7)\\xce\\xbc\\xd4?\\xc3\\x8d\\xf8\\x16q6\\xff\\xd1-\\x05\\xf4;\\xa7%\\xd9;N\\xcbT#\\xdd\\xefTv|\\x1b\\x94\\x04\\x1a\\xa7\\xd4-\\xb3Q1\\x07\\x1bb\\x11/\\xfd)\\xef\\xaa\\x06\\xd0\\xf8\\xf0\\xb1xEm^E\\xfa\\xc8>\\xe2\\xcd\\x014\\x17;\\x9d=\\x1c\\xc1AG\\xc1Z\\\\\\x9d\\x07O\\x1e\\xf8\\x9a\\xb6m\\xb7c\\xe2o[8\\xb2u\\xca\\xd85\\x16C\\xcd\\xb4\\xcd(\\xa1q\\xe3Mt7\\xcb\\x969\\x90\\xbe&\\x89\\x1as\\xc5\\xe9@\\xf3K\\x1aW\\x0c\\xff>n\\x14k\\xbf\\xbe\\xff{a^\\x1c\\x043q\\x93\\x1f\\x1b\\xefP\\xff\\xa4\\xba\\xe2\\xbe\\x8ew\\x93\\x0b\\xe9\\t\\xf6\\x9dT\\xd9\\xad\\x02T\\xc5:w\\xa7\\xbc]\\xd3\\xce\\xc6[\\xff\\x87\\xfe~\\x9d\\xd0:\\xce/\\xf4\\x12\\xf7\\x8fi\\x93_\\xa2\\xc1\\x073\\xc7\\xab\\x00\\xad\\xdf\\x16v~\\x12\\xcf\\xcc7d\\xfdL\\xdfG\\xa3\\x9e\\xd2\\xb0!.\\xa3\\xcd4\\x7f\\xde\\xa0^\\x92\\x91\\xfa0\\x84\\xad\\xa7\\x04\\x07n\\xa9\\xcc\\xcbs\\x83\\xdf\\xe65\\xd3\\xeb\\xf1\\x18\\x0e=jpc\\xf3\\x9c\\x9e\\x8a\\x82U\\xa1\\xf5\\xd1\\xa4\\xacPo\\xbd\\xd3{m\\xb6\\xfe$\\xc0\\xab\\x9eV/\\xe3\\x06\\x19\\xfc\\x1f>\\xca\\x19\\xe8w\\x19\\x8e\\x13\\xc7\\xe6\\x8e\\xfc=\\xe3h \\xe4\\xcckL\\xafX\\x11\\x08\\x1d\\xd3\\x95K\\x15\\xdc\\x02A\\xf1\\xab\\xee\\xb9\\xe0Z;P~vC\\xfc\\x98\\xa87\\xd0q\\x8c\\x12:\\x9eQB\\xe71\\xca\\x9e\\x83\\x89w\\x9c\\xba\\xfak\\x12H\\xf9\\x86\\xeb\\x0f\\xa5\\xb6\\xc9\\xb0\\xf5\\x04\\x9a\\x8f\\x0f\\xc7\\xc1\\x1b\\xe3\\x88\\xc8\\xcc\\xbe\\xbf\\xfe\\xee\\xf2\\x81\\x91sg\\xcb\\xd6\\xc7i\\x1d\\x8e\\xe6\\x9d\\xf6\\x9c\\xfb[\\x9e]\\xb0a\\xf3[Z\\x87\\xa3\\xf9)\\xed\\x0fO{\\xa4\\xa7\\\\\\xa3\\xcd\\xbe\\x0fF\\t\\xfd\\xfb\\xdd\\xd9S\\x8a\\xd2C\\x07\\xa6\\x90\\xcb\"\\xe2\\xba\\t%j4n\"4~\\xa2\\xf5g\\xda\\x1e\\x8e\\xfbN\\x132NU\\xcaOc\\x8d4(B\\x98\\xda\\x0c\\xe7\\x18\\xc2\\xcf\\x9e]$y\\xf0\\xa8\\x01\\x1d~6\\x8f\\xad\\xbf\\xd3z7\\xb5\\xb3|?\\xa7\\xe7\\xbf\\x91\\xf0\\xb7\\xe1\\r{S8\\x80\\xd1\\xc1\\xb9\\xc76@\\xeb\\xca\\xb4\\x7f\\xd3\\xdf\\xf8!?;\\x13\\xc5u\\xfbNV\\xec\\xd4\\x87\\xca\\x96Y\\x83\\xaf\\x1a\\xf5\\x81\\xb6\\x19%\\xb4\\x9fQB\\xebu\\xfc\\xb2\\x90\\xc1=[\\xa6\\xae\\xa0\\t\\x02\\xad\\x7f\\x96[\\x1fQ\\x83\\xb4\\xa2\\xd8R\\xdf\\n\\x050\\xf9\\xf4a\\x9f\\xc6\\xde)\\xe4i\\xd4T\\xc1\\xd5\\xa7\\xa5\\xe1\\xff\\x01\\x00\\x00\\xff\\xff\\xa5X\\t8\\xd5[\\xd7G.\\x19\\xc3\\x892\\xc4\\x911\\xf3L\\x86,d\\x9e\\x8ec\\x1e2+d\\x1e\\x12\\r\\x8a\\x8a\\x8a&)RQ\\xa9P\\xa19\\xdedE\\xd2Mi\\xba\\x95\\x86[JsH\\xea\\xa6{+\\xbdG\\xfe\\xfb\\xff\\xbe\\xd7\\xbd\\xdfs\\xbf\\xef\\xf9<\\xcfy~\\xd6\\xdak\\xfa\\xefa\\xad\\xb5\\xf7\\xe7\\xbaR\\x81\\xd6\\xad\\xf2\\xa8\\xfa,\\x7f\\xf7\\xd5\\x0b\\x91\\xb8:\\xab\\xa9\\xf0\\x9d\\x8f#\\xce\\xc9\\x0e\\xa81\\x8eM\\x05\\xe7]+T\\xdb\\x12|0\\xef\\x88\\x84\\x96\\xa84\\x0b_XW?>\\'\\x96\\n\\xfbG\\x8a\\x1b\\xac\\x8a}q\\xf3\\x94\\x1c\\x93C\\x82A(\\xba*\\x9a\\x9b\\xe1d\\x80\\x84O!|R\\x91\\x9dr\\xca\\x8c\\x81\\x9f\\x17\\x1es\\xb0Z\\xa5\\x0b+NC\\xde\\xd3\\x97*h\\xed\\x1f|\\xb4u\\xa7\\x16f\\xf0\\x1f5\\\\\\xdd\\xad\\x87\\x84_<oo\\xce\\xc2\\xc9\\xf6\\xd0\\xf0\\xe6\\xb0T\\x8f\\x05\\x13)\\x84\\x1a\\xff\\xcb\\x06\\x17V\\xcfG\\x9d\\xf4f-U\\xb6?\\xaa//jZ8-\\x15\\x9c\\x0e\\xd6/\\xdd\\x96o\\x07\\xa3N\\xe2\\xd2~\\xef\\x850\\xb6\\xfe\\x96\\x93\\xab\\xa4\\x01N\\xceZ0p*]\\x1fe\\x9b\\x92\\\\\\xb2E$qV\\x97Xgs\\xac\\x16\\xa6y\\xfagim\\x93\\xc4\\xe3K\\x86\\x1bY%\\xb3\\x91\\xe8\\xa5\\x84\\xf1wK\\x7f\\x8f\\x84\\x00\\xbf\\x1d[\\xf3\\xf2\\x9c\\x90\\xe0\\xa3\\xe73\\xcf1,\\xec\\xb0g\\xd7\\xa0\\xe5{\\x9f\\x99\\xe8X\\xb2^\\xbf\\xf1\\x91$~\\x8b\\x17\\x15\\xbbb\\xc3\\x82%\\x1f\\xd7|\\xb9\\xf4\\xeb4$X\\xbc=I\"\\xbf,\\x88\\x8e\\xc35p\\x8d\\xd9\\x9d\\x19a@\\xe2\\xa1\\x90\\xf6C\\xf4\\xf8z\\x1c\\x0f\\xd6\\x17\\xba\\xc3\\xc7\\xe9\\xcf\\xcb\\xb7{\\x8b\\xe1?\\x8dO\\xc0\\x89|\\xb8u\\xef\\xe7^\\xf5r\\x15\\x828\\xaa\\xa9\\xe9\\xee2k.\\x12:\\xc6\\xbb~H\\'\\xd8\\x07>\\x9dh\\x0f+q\\x9f\\x83\\\\c\\x7f\\x85v@!rfW\\xe0\\xf7\\xe6\\\\x\\xe5\\x9a\\x9c\\xab\\xd3,5>\\x0e\\xb9\\xc8\\x13q0\\xc0x2\\x17\\x96\\xee\\xb0\\xba.\\xb8T\\x8a^\\x7fZ.y%oG~\\x06\\x8c\\xcfC<~1O\\xe9.d\\x0b\\xd1\\xfa\\x8bzw\\x8a\\xef_\\x94\\x0b\\xc4\\x0e\\x85\\x90\\xcaT\\x16*\\xe3r\\xc7\\xdes\\xa2;\\re\\xe6\\x8c\\xa3y \\xd8\\x1e[!\\xf0p\\xc7,\\xb4\\x9d\\xf3\\xea\\xdea\\x19O\\xfc\\xa4\\x1e\\xb21\\xf2\\xf3\\xf1\\xf18\\xa1\\x12\\xff\\x8c\\xb94n\\xd2\\x13\\x0eH\\xfbI\\x11O\\xeftM\\xf5\\xbd=\\x97\\x96cq\\x02\\xdbbQ\\x05\\xe9Q9m\\x12\\njX\\x9a\\x97\\xa4\\x1b\\xb7\\x81\\x85\\x84\\xa6\\x10\\xfe\\xaf\\xf2\\xa6\\x1b\\x02\\xd6{6\\xb9\\xe2\\xf6\\xef\\x9b\\x96\\x7f\\xb9\\xe9J\\xc7\\xf1\\xd9\\xbbo\\x7f\\x85\\xf9\\x16H|\\xf9\\xa565d%V\\xbeV\\xb9hP,\\x8e\\xb2n\\xedC\\xe2\\xe5\\xfa\\xa0|\\xe2y\\xc8\\xba\\x85\\x1ah\\xc1\\xed\\xbeJD\\xd7\\x0c\\xdf\\\\[^]X\\xed\\x06n\\x9e\\x01O\\xb9\\x8b\\x01\\xebw\\xa9\\x0b\\xac5\\x1ai]V\\x7f*27\\xd0\\x11<r\\x1e\\x7f\\xbe_\\xe9\\x80ro\\x9f\\x9a\\xc8T;c\\x8d\\xf9\\xb3\\xf9g\\x9e\\x98\\xd3\\xfe\\x88\\x9f\\x92\\xe9\\xbc~\\x1e\\x0f\\xf7\\x00\\xef\\xcb\"\\xf5\\x01\\x95,\\x9c\\x88\\x11\\t\\x8a\\x97lj\\xe7\\xe2\\x9d\\xd9|\\xd1\\r\\xfc:x\\\\8\\xf5\\xf0\\xfa\\xf6D\\xc8\\xb8\\xf9\\xe5\\xe2]y\\x0f\\x9c\\x88\\x1b\\xebT\\x0b\\x9bu\\xed1Wo\\xe8\\xe1\\x92\\x1e\\r\\xa0\\xf0\\x1f\\xe9;\\x9b\\xcet\\xde\\xact\\xc5\\xe7\\xe1&\\xdckNJ`%O\\xb8e\\xfe\\'w8\\xde\\xef\\x1c\\x9e\\xde-\\x80\\x92\\xeb\\x1fO\\xf5c+\\xc1\\r\\x85\\x1d\\xd9i-\\xd2t|\\xc4/\\xb1\\xf3#>\\\\\\x02\\xff\\xdf\\xf1\\x88o\\x95\\xedKmL\\xe9\\xef\\ta\\xda\\xbc\\x8f\\n\\xf5\\x82(\\x81\\x85Q\\xfd\\x17D\\x91`\\xad\\xfb\\xce\\x87\\xef\\x98\\x9aP\\xd42-\\xecD\\xb2\\x12\\xb2\\x8a\\xb4\\xca\\xa3\\xee\\x89c\\xd8\\xbb\\xd1\\xc5\\ryz \\xf2\\x8d\\x11rx\\xba:\\xbd\\xcf\\x08m%xw\\xdf\\xf5m\\xed\\x10*\\xfa\\xafw\\xd3UgR\\xe7\\xaa\\x1d-\\xda\\xe2\\xce\\xaf\\xd71\\x00\\n\\xa9u\\xda\\x8c\\x97\\xf8\\xad*|oG\\x93q\\xcc\\xe4,\\xdc\\x1d\\xeb\\xadp%2\\xf2C\\xaa\\x15\\x83>\\xaf\\xc3\\xa1\\'\\r\\x9e\\x98\\xea\\xc2{\\x87\\x17\\x9b\\xad{&\\x13\\xa4\\xed\\xb4\\x8d\\x8c\\xf2\\r\\xa8LC\\xc2?\\x9b\\xc11\\xb4b3\\x18\\xcd\\x97\\xf8-\\xafs&~\\xefw\\\\wi+\\x1b\\x98\\xa1wu{,Xx\\xa9\\\\5\\xc1:P\\x02(\\xc4%\\xb1\\n\\x9a\\x9f\\xdd\\xa7\\x12>F\\r\\xe9\\rTx+\\xd1\\xf12\\x86m\\xae\\xcd\\x7fn\\n\\xc9\\x9f\\xf8/\\'>\\xa0\\xf2A\\xa17\\x9e:\\xe7\\x14\\xdbe\\xe8\\x0f\\xf5\\xbf\\xd9\\xdb\\x06\\x87j\\xe3\\xdc\\xb8\\xe4\\xa1\\xd57,\\xf1>\\'\\xecl\\x11c\\xdc(]S\\x94\\xfb\\xce\\x89\\xd6\\xd3\\xca\\xfb~$:K\\x1d\\x12\\xfa%n\\x073d\\xd0\\xf5\\x90b\\xeaF{\\x13\\xe4s\\xeb\\xbd\\xf3k\\x8f\\xe7\\xf8~Y\\xe6\\x0bo./\\xc8\\x96\\xaf\\xb1\\xc5\"\\x977\\xbcF\\xcb|@\\xf0\\xe3ZKg\\xb6\\x03\\xdaM:\\x9a\\xf0\\x82\\xc5\\r\\x14\"s\\xd6\\xccv\\x8dz\\xafq?\\xa5l\\xb8\\x11rp\\xf3\\xb67\\xc2\\x18\\xdc\\xbd\\xffL]\\x1d\\x0b\\xbd\\xaf\\x0f\\xa8\\x14\\xbf\\xd7B\\xb2\\x1e2\\x1c\\xb1\\xcab?(\\x8d)\\x8c\\x9a\\xa7\\xccD\\xae\\x8c2]\\xdd!e\\xa8\\xe0)\\xdfe\\xaf;\\t\\x89>\\x85\\xb4\\xdf\\xd0\\x8f\\x92\\xd5\\xd2o=\\xa1\\x86k\\xfa\\xb5*}Ct\\x17\\xcbTX\\xf1\\x8cA\\x10\\x84\\xaff\\xca\\xc4\\xc5icP\\xcf-\\xd1\\\\I%\\xdc\\xd4\\xf2\\xe8\\xdb\\xfbS~\\x90\\xe7\\x17~\\xe9\\xcd\\'a,Zp\\xfd\\xba\\xb5\\xb8:\\x0eZ\\x85\\xa4=\\x14\\xb7B\\x81\\x83?\\xe9\\xfe\\xf1\\xd4x|\\xbd\\x02T\\xf0|M\\xb5\\x07x+\\xe3\\xb0\\xb0\\xcc\\x1fj\\xc7|!\\x9f\\x93f\\x8aL\\xccP\\xbdY\\xe7k\\xefRQ\\xf4\\xd8\\xdeq\\xe1E\\x94:2\\x96\\xd7V\\x9a\\xb6\\x18#\\xeb\\xc0\\x8dg\\x91\\xfdSp\\xf7\\x92)\\xdb\\xe5:5\\x91\\xc8\\xcf\\xda\\x16\\x1c$\"bG\\xfb\\xa5\\x10\\x88\\x1d\\n\\x81\\xc4C!\\x10\\xfb\\x14\\x02\\x89\\xd3&\\xefig\\xd9\\x07\\'(\\xb9\\x18;\\xc3\\xf7\\xb6\\x11~\\xb0<c\\xb1\\xf0\\xae\\x03\\x1d?\\x89\\xe7I\\xce\\xd4\\xfa\\x83\\'\\xda\\x81\\xec\\xf7\\x0b\\xe1\\xa3\\x82\\xe5BB(3\\xf2\\xc2\\xd4\\xed\\xe1L\\xf0\\xdb\\x19\\xaf}\\xc5`:\\xe6\\xef\\x11\\xd5|\\xc8V\\xc2W\\x86U\\x8f\\x8a\\x82\\xbe\\xb6Z\\xde7\\x8b\\xd4~\\xa4\\n~\\x95\\x87\\x8e\\xf4\\x08\\xc4\\x12\\xc4\\xf5\\t\\x9c\\x8d]\\xec\\x82\\x85\\x1f\\x1f\\xdc]y0\\x02\\xa4/\\xaf]$\\xb9E\\x17\\x0f\\x88\\x14\\xec_\\x99<\\x03\\x7f\\xec\\xb7\\xe5\\nx\\xb6>\\xacQv\\x83\\x1b\\x92\\xf1\\xb3\\xaf4\\x9d\\x0c\\xf9\\x00^\\x15\\x88\\xb7\\xed\\xf3e\\xe2\\x10k\\xea+\\x86>\\x93\\xd6\\xa3\\x90\\x1e\\xa7\\x10\\x88=\\n\\x81\\xe8Q\\x08U\\xa6\\x92\\xb5z\\x8f\\x0c\\xf0;\\x7f\\xc0\\xa1E\"\\xf2\\xb8c\\xe9\\xf1\\xab\\xc5\\x11\\xe6p\\xc2r\\xca`\\xb7\\x83=R\\x08\\xfd\\xfb\\xbc\\xfd\\xe7X\\x18\\x13\\xc4\\xb2\\xcf\\xfbj\\x0cO\\x0f[S\\xd8z\\xa7w\\x99\\xaf\\xce/\\xc2\\xc8\\x1ek\\xacxT\\xc8xktCV\\xee\\xd9\\xb09\\xd0\\xcc\\xe8o\\xed\\xd6\\x16\\xc6\\x16\\xf3\\xce\\x15\\xfd*jX\\xac> r.9\\x05t\\x93\\xf6q\\x9f-]\\x80\\xae<\\xbf\\xfcr,F\\x13\\xc7\\xeb\\xb6\\x07N\\xd9i\\xb8\\xf7D\\xb2!r3\\xced\\x9a>\\xd6C\"\\'\\x18;3aqH*<\\x17|\\x97&\\xeei\\x8e\\x06\\xbez\\x1a\\xb5K\\xcci}\\n!\\xf7\\x91Ou\\x1b\\x9a\\xd2\\xf6d%F\\x02\\xfe\\x90\\xf2\\x85\\xb1\\xae\\xc8A\\x8c\\x8d\\xa4\\xfe\\x12;\\t\\x02\\xbfW-\\xb8\\x1bL\\xd7\\'b\\xf7G}V\\r\\xa6\\xfb\\x9a\\x99\\xdf>e\\xf6.\\x9d\\x83n\\x07\\x04\\x1dT:BaxI\\xc5h\\xbf\\x8a?ru\\\\\\xda2\\xbb\\x9eI\\xef\\xdf\\x1do\\x8dn\\xb2k\\xd5\\xc7\\xf7\\r\\xd7T$\\xdf?\\xc8\\xfb\\xa5!]H\\x11nr=\\xe2\\x11\\x18\\xb4\\xa7\\xf6\\xa5\\x19F\\xae\\x1a\\x8a\\xed3S\\xa5\\xf3\\xa50\\x8ff\\x81\\x94M(\\xdc\\x8awz\\x18\\x95m\\x8a\\xe3\\xe8H\\xd5\\x1d\\x0b\\xac\\x0c\\x94\\xa8:P\\xcd\\x86\\xb1vQ\\xe0u\\x18\\xc8\\xb3L\\x9e\\x0bV\\xd8 \\xe7\\xd4\\xfe\\xa2\\xca\\xe3\\x8b\\x97\\xe3\\x9bw\\xbf\\xba\\xcc\\xa4\\xfa<C\\xcc_3*\\xa0\\xe3\\xa7\\x85Dn\\x93~\\x96\\xb6b\\x857\\xac\\xeb\\xb4?YX\\xa5D\\xeb\\xd5\\x85\\xfb\\xb0\\xd5\\xcc\\x92\\xa1\\x96sl\\x19\\x16Q\\xd8\\xb7\\xf0\\x9a\\x96\\x00\\xaa\\xe1OF\\xe2&\\x96\\xbf\\x86\\x02\\x85\\xb4}\\ni;d|I\\xbe\\xae\\xdb\\x81\\x9ap(\\xfbt\\xf5\\xdb\\xed\\x0f\\xb2t\\xdfG\\xce\\x81\\xc4\\xfe\\x96\\xf3\\xd3\\x04\\x93\\xa9\\xfe\\xd7\\x0f-\\xab\\x12.Kz\\x18bIm\\x9e\\x97s`0\\xfc\\xc8\\x9f\\xab\\x19\\xb8\\xeb\\xdc\\xee\\x86\\xc0\\xddS\\xd1Xy\\xf0\\xe8Gqe\\xc8\\xebxr\\xa5a\\x91\\x1e\\xeaEg\\x1ez)g\\x00B\\xb7Fd\\xf2\\xa2\\xfeh\\x9d\\x80\\xd6M\\xe7Y\\x05\\x92\\xddR\\x88\\x8d_\\x7f?\\x95\\xc2\\x84\\r\\xd6^\\xf7\\x1aUy\\xf1td\\xee=\\xab\\xe2L\\xbaOh\\xbe\\xbf\\xee[\\xcc\\xcc\\xc5\\xb0\\xf1\\xd0\\xe6yqq\\xd4\\xf9\\xe3\\xe4{\\x12\\xef\\xc6g\\xc3\\n75\\xe3!p\\xda\\xe9\\x1b\\\\.\\x11\\x988{\\xfb\\xd3\\xba:\\x18G\\r;z}3g\\xd4\\xcd\\xfa\\xb9Y\\x08\\xc9\\xbd\\x83\\xe4\\xf1\\x86\\xa0\\xf2!\\xd7b\\r:\\xcf\\x90\\xf5<^\\xd6\\xb34D\\xcd\\x01\\xe6I1*6*\\xd8 \\xa9_\\xfb9\\xd3\\x1eQ\\x1b\\x0e7\\xfbFL\\xbe\\xcdR\\xc1gZ\\xfdq\\x05\\x05\\xa6\\x88\\x99\\x1dEC\\x0e\\x0c\\xf4T\\xd2.=m\\xa8\\x8c\\x1f\\x0e\\xcd\\x06\\xbd\\xbb\\xda0CqR\\xf6\\xa2l&\\xea\\r\\x1fS\\x95\\xea\\x91B\\xdd_\\x95\\xf9V>\\xd7\\x84\\xd0fga\\x9e\\x7fE\\xe0\\xc8\\x16\\x8e\\xe3\\xd7\\xbet>\\xf9\\xd1/\\xbcN\\x05\\x85\\xe1m\\x87\\x14d%Q\\\\>Q\\xee\\xa8\\x94!\\xfc\\xf8\\xceJMl\\xb9\\xa8\\xe3\\xd5\\xf2\\xdbOH\\xfa\\x83\\xac=M\\x1eJ\\x03\\x9c}\\xcc\\xae0kb8\\xe1\\xc7\\xde\\xc1\\xc3\\xbf\\xce\\xf7\\x85\\x97\\xc9\\xb6\\x8a<\\xcd\\xb6t\\x1f@\\xe8\\x1d\\xe5\\xe5\\xe5M;\\xda\\xe1as\\xc5A\\xf3\\x1c6\\x92y\\xd3\\xfae\\xc7\\x8b\\x19\\x05\\xf1\\x10\\xdfz\\x92\\xa1\\xf2^\\x8c \\xba\\x9cVI;?[\\x01\\t\\xcd\\x98\\xa2^\\x91&\\xa9\\x0eu\\xb9b?o\\x8a\\x92\\xc3\\x0b|Bjq\\x1b\\x98\\x98V\\x14\\xbd\\x91U\"\\x8dq\\x17\\xf7\\xbe\\xee\\xbf`L\\x9f;i^?Qm\\xf6<0m\\x17\\xf9\\xfc\\xb5\\xd1\\x0c#\\x0e\\x0c\\x84\\x05\\x06\\xea \\xe9\\'_\\xf6\\xddg\\xe9\\x9bx\\x00g\\xb7T\\x8f\\x1c\\xe1\\x1e\\xbf\\xe7\\x9dS\\x07R\\x97.\\x1e\\xe4\\x14\\xbeM\\xd6@!\\xae\\xbb\\xdayr\\x8f\\xaa3\\xe1\\x8f\\xdf\\x07n\\xfa\\xc0\\xd4\\xee$\\xed\\x92=\\x9fZ\\xd3\\xf7\\x0c7<\\xf7\\xe5E\\na\\x9b\\xe2\\x86\\xcc\\xd4\\x91y\\xa0\\xe5\"p\\xbe\\xae\\x8e\\x89c\\xd7\\x80\\x16n\\x1b,)\\xda\\xb9\\xda*\\xc2\\x1b\\t\\x9fB\\x18\\xaf\\xa3\\x86\\xf8\\xf6\\xc8\\xca#\\x12N\\xb6H\\xea.\\xd1;Pq\\x81\\xd9h\\x12\\x0c\\xe3}\\x9c/\\xc2\\xf9\\x8eu2!\\x16H\\xce#\\xb1\\xcb9\\xa5Uk\\xb32A\\xf8\\xf9\\xdc\\x7f\\tJ\\xcb\\xd3u\\xb63\\x8aO\\xa3\\xafA\\x9f\\xca\\xabjH\\xeeA\\xfc\\xa7\\\\\\x1a\\xcd\\x84\\xed!imH\\n\\xdf\\x14\\t$u\\xeb\\x9a\\x07\\x9f\\xe3\\xcfB\\x86p\\xbe3\\xbc\\xa3\\xf6\\x13\\x93\\xee[\\xee\\xa7\\xe9t\\xf8\\xd6:\\xc3\\xd4+ey\\xc6\\xf2\\xb24\\x9fS\\xbd\\xde\\xdfLT\\xc6y\\xdfz\\x94\\xadyd\\xf1\\xde\\xa0|\\xd5\\x97a1\\x14V\\x10\\xf7\\x9e\\xb9V\\x02\\x89\\xfcv\\xb9,\\x17~O\\x80-\\x93\\x16\\x19gk\\x88\\xe2-\\x17\\xc5M\\xae!\\xa2H\\xfa\\x91\\x1f\\x86\\x07\\x94h\\xbf\\x14\\x82D\\xdb\\xbeb%\\x939H!\\x90\\xfe\\x8f\\xd4\\r}\\xdb\\xc5\\'RC\\xf4a<_\\xd9#Y\\xf7\\xc2\\x15v5\\xec#,\\x98u\\xe2\\xf0\\x97\\xce-RH\\xfa\\xee\\x15N\\xad\\xcbf\\xa8\\xab\\x83~\\xb9\\xc6\\xf4RtA=\\xc7\\x8d\\x8f\\x1f\\x84;\\xe1\\x95\\x1c\\xfd\\xad\\x0c\\x0bo|\\xf8q\\x815\\xfb\\xac%}\\x9f\\xe2d\\xdd{\\xdd5\\xcb\\xa1\\x96q}n\\x8f|\\x12\\x9d\\xff\\xc6\\xaeA\\xdc\\x9f\\xfd\\xa8\\xf3\\xee\\x83\\xf9xy\\x8f\\xbd\\x8b\\x1dr\\xba\\x9a3\\x01\\xb5\\x96\\xf4}\\x91\\xe8\\x119\\x0e5\\xf4\\xb1c9\\xc4Z\\xb3\\xe7\\xae\\xf1g#ywp\\x9c\\xb4XH92j\\xfc\\xfcw\\x89 \\x85\\xd0+.YWQ\\xa1\\x84\\xe4\\xfeD\\xfaI\\xb9r\\xc7\\xd1p\\xb4\\x83\\xd4\\xa0\\xa1\\xbd\\rCJ\\xf4\\xb9#\\xeb\\xd2\\xfe\\x9bz\\x88gY;\\xc8\\x8a\\xf4jojTF\\xcd\\xb1\\x06&\\xd7\\no\\xf5\\x84\\n\\xe5X\\xcbb\\x9bq\\xd6\\xc7\\xd6\\x9dr\\xf8\\xac\\'gM\\xcaa\\x11$r_\\x8b\\x84\\xf8m\\xdb\\xdc \\xb1c\\xf4\\xd8\\x92\\xb4\\xd1V\\xb2\\xcf\\x89\\x9f\\xfd\\xf7\\x0f\\xf6\\xe9\\x97h\\x80c\\x1f\\xabUH\\x93\\x89\\xa4\\x7f%}@\\xc8\\xcf\\x1b\\x8a\\xa1\\x86E\\xe7W\\x92\\x0f;+k\\x12\\x02\\x18\\xf2`\\xd7\\xd5\\x9c\\xab\\x15\\xcd\\x8d\\x8bO9&\\x9f\\t\\x93@i9\\x95\\x86nqYp\\xc7\\x86\\xcd\\xca\\x93\\x15\\x08b\\xda\\xe3\\xf8]g\\x12$\\x90\\xe4!\\xc2\\x1f\\x0b\\x83\\xa9mN\\xcf\\xcb\\x96m\\x97\\x1f\\x88\\xeff\\xe0\\x80F\\xf5\\xd7\\xeaxm\\xa8\\xfd\\xf4z\\xf1\\x15T\\xc5\\xc9u\\x0e\\r|UL\\xfc\\xce;M3\\xbe\\xd1\\x10R\\xde&\\xed~\\xb3\\xc8\\x0b\\xfcN\\xe7x\\xe4X[\\xe0\\x9bc\\x9c\\x84\\x9ba\\x8e\\x97\\xde%\\xfeq\\\\M\\x0f\\t\\xff\\xd5YN\\xc2\\xeb\\xf3\\xa1\\xdf\\x07\\xb6\\xbc\\x8a\\x99\\xdae\\xa5O\\xde\\rh\\xbd\\xab\\x16\\x1e767\\xfa\\xc0\\x9f\\xc7\\xff\\xd3\\x17\\xde\\x0b[\\xe4)_\\x13I\\xdb\\xf7\\x94\\x97\\x8awWZ\\x00\\x83\\xd7\\x1b\\xa7g.\\x93A\\xcd\\xc4\\xd4\\xe2k\\xca\\xffAb\\x9f\\xe8\\x8f\\xf5\\x99\\x05\\x15\\xed\\xb4<\\x850A\\xef/t\\xc1c\\xf7\\xd3\\xfd\\xac\\xc9X\\xecX\\xbbJm\\xab\\x04j\\\\\\xfc\\xbd\\x82\\x15\\xca\\x86\\xa9]\\xdaG\\xd6\\xa4\\xb1P\\xf3\\xdeQ\\xf1\\xc2\\x025\\xfa\\xbb\\x08\\x92qK\\xceg\\x85\\xf0\\x84\\xd0\\xef\\x1aS\\xeb\\x1d\\x9f\\xdc\\xff\\xad\\x1d\\xc6\\xfboY:>\\x85]\\xcd\\xc3\\x81\\xbb\\x8d\\xf0\\xb6\\xaa\\xc7`V\\xaf\\x11\\x92\\xfaD\\xe4:g\\x99o\\xe9R\\xf0\\x01\\xf5\\xa8\\xa5e-\\xabfbS\\x9f\\xfb\\xf2\\xf5:<4\\x1a\\x0fD\\xeex=G\\x14\\xef\\x1c\\x94+\\xe9\\x981\\x85\\xb6K\\xe6\\x91\\xe8Q\\x08\\x13\\xf4\\xffB\\x13{\\x14\\x02\\xb1K!\\x8c\\xdem\\x8a3\\xec\\xe6\\xc6\\xf1\\xfb\\x8b\\x08jN\\xd3\\xf8\\x1e\\x14*\\x82\\x1e\\xa1\\xd1<\\xcbU\\x94\\xe0{i\\xa9\\xea~\\x96\\x01n\\xb3\\xe3t\\xe4]\\xbat\\x9d\\xf5?\\x16\\xa5$\\xf6\\xd8\\rf\\xbc\\xe8\\x12j\\xe4\\xf7\\xc0\\xea\\x14+A\\xff\\xa2f\\xd0\\x1bk\\xf8\\x16xa\\xb2D>\\xd6\\t6#\\xa1\\xd3\\xefJ\\x0c\\xdb\\x94\\xa5\\xc3x_\\x98\\x84c\\xd7\\x94\\xb5\\xa5\\xde0\\xcc?\\xe9Z\\x0b\\xb7\\x175o\\xca\\xb8\\x92\\x93\\x9e\\x8eOr\\x83\\xc2\\xd5A\\xb7\\xce~PC\\x85\\xbd7f\\\\\\xe0s\\xa0\\xf3~mAl\\x06\\x7f\\xae\\x17\\xa4\\xa6\\xb5\\xday}\\xb5A\\x82Q\\xdbk\\x1e\\xc9\\x88y\\xc03\\xe7\\x9b\\xc6%jfH\\xec\\x12:HwM\\xda^!\\x7f\\xba\\x8f&\\xebJ\\xfc\\xbc>\\xdd0\\xe9\\xa5n\\x0e\\xfcx\\xbf\\x19\\x06\\xbc\\xbe\\xbc\\xbaP\\xb8\\xdd\\x8a\\xea7\\x1dh$\\xe3\\x14\\x02\\x91\\xa3\\x10&\\xc8\\xff\\x85\\x0ey\\x91\\x11\\xe8\\x16\\xa2N\\x7f/\\xf9\\xbe\\xdc\\xf3I=\\xa7\\xf6\\xb2\\x80\\xbc\\xa3R\\x08\\xb6\\xaa\\xd2\\xb3\\x85\\x14\\xd9\\xf4|\\x8e\\xed\\xff\\x97M\\xcd\\xa0\\xbd\\xf8\\x86\\xff&>@\\xb1+7\\xfaF\\xea\\xbc\\x90\\xcc+\\xe1\\xa7\\x8e=D\\x9c\\\\\\x05c\\xcf\\xbau\\xe5)8d\\xa8#7Y\\x110\\xe3\\xdd\\x93-}f~H\\xf8?\\xfa\\xcb\\xc1t\\x98|X.(z\\x9f\\x0bm\\x8f\\xc8?}]zL\\xb82\\x0e2l\\x96u\\xed\\xccs\\xc6\\xff\\x01\\'\\x8e\\x03\\xf1C\\xec\\xdas\\xd2\\xbbKG\\x04\\xa4\\xb1\\xda\\xdc\\x1eT\\x9a \\x850\\xf6,{\\xc69\\x1a~\\xdcs\\x04\\xd9\\x18\\x1c\\xc6\\xc9\\xe8\\'\\x1cPI\\xf2\\xa2T^\\x88\\x03f\\x9d\\xab\\x94\\xd15d\\x01\\x99\\xa7\\xdd\\'\\x1f\\xe8\\x18\\xb5\\x1a!\\x91\\'|\\xd9\\xdd\\xa1\\xb3\\xba\\x9cb`\\xbf\\x96\\x9d\\xdc[>WZ\\x8eB\\x9aO!\\x90w<\\xe2O\\x84\\xd3\\xee=x\\x15L\\xf3\\x89\\x7f\\xb3\\xcfm\\xd1ug\\x83At\\xecy\\x8d\\xf3\\xe3\\xe3\\xfc&s~\\xbc\\xe3\\t\\x9c\\xeb\\'\\x8a\\xe6\\xe6\\xfc\\x04)\\x1c\\xfb\\x13\\xa3h\\'[]\\xa3\\xd9Fa\\x91\\x99\\xe9\\xe3\\xfc1;z\\xffe\\x87\\xefo\\xecp\\xff\\x97\\x1d\\x1e\\xce\\x7f<\\x7f\\xa3\\xf7w\\xfey\\xff\\xe4\\x9f\\x97K\\x7f\\xb6\\x99\\xf1\\xff&n\\xa1\\tq\\x8f\\xd1su\\x98>\\xd9\\t\\x11\\x8b\\xd2\\x17f\\xd3q\\xb3\\xfe\\xc1\\x8e\\xdc\\x04;c\\xb4\\xb3\\x0esn\\xe6\\xfc\\xf9ZL\\xb6\\x0e\\xd31-.1&]\\x8b\\xe9\\xa2\\xc3t\\x8b\\xc9\\x8aK\\'v\\x9d\\xfe\\xc1\\xae\\xe4\\x04\\xbbctJrVL\\x1a3)&#+9m!3%-92!&\\x91\\xc3\\xff7L\\xd7\\x84\\x01'\n"
          ]
        },
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "12824"
            ]
          },
          "metadata": {},
          "execution_count": 3
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "_XMGyQRoMlMC"
      },
      "source": [
        "Después de descargar el archivo .mat, exploramos la estructura de datos para localizar la matriz dispersa. Podemos mirar el patrón de dispersión (gráfico en dos dimensiones con un punto en el lugar de las entradas diferentes de cero)."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 612
        },
        "id": "maX3HV0cA-Le",
        "outputId": "70030849-2433-47c6-be3e-1b9d5f3ef5df"
      },
      "source": [
        "mat = io.loadmat('bus494')\n",
        "#print(mat)\n",
        "A=mat['Problem']['A']\n",
        "B=A[0]\n",
        "C=B[0]\n",
        "D=sp.csr_matrix.toarray(C)\n",
        "print(type(D))\n",
        "plt.figure(figsize=(10, 10))\n",
        "plt.spy(D)\n",
        "plt.show()"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "<class 'numpy.ndarray'>\n"
          ]
        },
        {
          "output_type": "display_data",
          "data": {
            "image/png": "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\n",
            "text/plain": [
              "<Figure size 720x720 with 1 Axes>"
            ]
          },
          "metadata": {
            "needs_background": "light"
          }
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "GCM5gF10MeRh"
      },
      "source": [
        "Observemos el efecto de la factorización LU en el patrón de dispersión."
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 286
        },
        "id": "VdRzF0RZKB8w",
        "outputId": "383c398d-a963-467f-d8e4-0b8f0a59f9f9"
      },
      "source": [
        "p,l,u=la.lu(D)\n",
        "plt.spy(u)"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "<matplotlib.image.AxesImage at 0x7f1bf590afd0>"
            ]
          },
          "metadata": {},
          "execution_count": 36
        },
        {
          "output_type": "display_data",
          "data": {
            "image/png": "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\n",
            "text/plain": [
              "<Figure size 432x288 with 1 Axes>"
            ]
          },
          "metadata": {
            "needs_background": "light"
          }
        }
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "Gsh9haogNtPw",
        "outputId": "ec4ba85b-5b83-4c22-d592-488b675835a7"
      },
      "source": [
        "print(np.linalg.cond(D))"
      ],
      "execution_count": null,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "2415411.0174664636\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "z5Ed1f6RWMkV"
      },
      "source": [
        "# Problemas\n"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "aXXXQKtHbVAw"
      },
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
      "metadata": {
        "id": "FpZtQD27WS3q"
      },
      "source": [
        "## Problema 2\n",
        "Considere la matriz de Hilbert $H(n)$ con $n=4,5,6,\\dots$.\n",
        "\n",
        "\n",
        "1.   Para $n=5,6,7,\\dots$ calcule $\\lambda(n)$ el menor valor propio de $H(n)$. Grafique $\\lambda$ como funcion de $n$.\n",
        "2.   Al intentar hacer a factorización de Cholesky de $H(20)$ en Octave/Matlab/Python la factorización no se calcula llevando a la conclución de que la representación numérica de $H(20)$ no es definida positiva. En Octave parece el error \n",
        "```\n",
        "# error: chol : imput matrix must be positive definite\n",
        "```\n",
        "Verifique teoricamente  $H(n)$ es en realidad positiva definida (no necesita mostrar detalles aqui). Con ayuda del gráfico anterior y de lo estudiado sobre artimética de punto flotante explique esta situación.\n",
        "3. Calcule $R(n)$ de la factorización de Cholesky de $H(n)=R(n)^TR(n)$ con $n=14,15,\\dots,20$. Presente un gráfico de $t(n)=tr(R(n))$ como evidencia del cálculo.\n",
        "\n",
        "\n"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "sp1uFPlHY6Hz"
      },
      "source": [
        "## Problema 3\n",
        "Considere la matriz de Hilbert $H(n)$ con $n=4,5,\\dots,20$. Existe una fórmula exacta para la inversa de $H(n)$, implemente esta fórmula. Con el comando de MatLab o Python para calcular la inversa calcule $G=\\mbox{inv}(H(n))$. Compare y comente los resultados.\n",
        "\n",
        "\n"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "k53Ch1rsYKLa"
      },
      "source": [
        "## Problema 4\n",
        "Considere la matriz en https://suitesparse-collection-website.herokuapp.com/Sandia/oscil_dcop_21. El archivo .mat puede ser recuperado de \n",
        "https://suitesparse-collection-website.herokuapp.com/mat/Sandia/oscil_dcop_21.mat .\n",
        "Gráfique el patrón de dispersión de esta matriz. Liste (con justificación numérica) las propiedades de esta matriz. "
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "blxFOwK_Ye_Z"
      },
      "source": [
        "# Problema 5\n",
        "Considere la matriz en https://suitesparse-collection-website.herokuapp.com/Sandia/oscil_dcop_21. Use un método iterativo (diferente de Jacobi) para resolver el sistema $Ax=b$\n",
        "con $b=(1,1,\\dots,1)$. "
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "XEz_YOFtYuA-"
      },
      "source": [
        "## Problema 6\n",
        "Considere la matriz https://suitesparse-collection-website.herokuapp.com/Sybrandt/AGATHA_2015.  Que puede decir del problema asociado a esta matriz? "
      ]
    }
  ]
}