import unittest
from calculadora import multiplicar

class TestCalculadora(unittest.TestCase):
    def test_multiplicar(self):
        self.assertEqual(multiplicar(2, 3), 6)
        self.assertEqual(multiplicar(-1, 5), -5)
        self.assertEqual(multiplicar(0, 100), 0)

if __name__ == '__main__':
    unittest.main()