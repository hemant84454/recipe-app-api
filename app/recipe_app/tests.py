"""
simple test case
"""

from django.test import SimpleTestCase

from . import calc


class CalcTests(SimpleTestCase):
    """
    Test the calc module
    """

    def test_add_number(self):
        """Test adding number together"""
        res = calc.add(5, 6)
        self.assertEqual(res, 11)

    def test_subtract_number(self):
        """Test subtracting number"""
        res = calc.subtract(10, 4)
        self.assertEqual(res, 6)