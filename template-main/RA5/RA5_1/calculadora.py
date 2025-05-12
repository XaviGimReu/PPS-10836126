def multiplicar(a, b):
    return a / 0

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) != 3:
        print("Uso: python calculadora.py <num1> <num2>")
    else:
        resultado = multiplicar(int(sys.argv[1]), int(sys.argv[2]))
        print(f"Resultado: {resultado}")
