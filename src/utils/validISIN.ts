const isValidISIN = (isin: string): boolean => {
  // Basic format check: length should be exactly 12
  if (isin.length !== 12) {
    return false;
  }

  // Regex explanation:
  // ^                -> Start of string
  // [A-Z]{2}         -> First 2 uppercase letters (country code)
  // [A-Z0-9]{9}      -> Next 9 alphanumeric characters
  // [0-9]            -> Last character must be a digit (check digit)
  // $                -> End of string
  const isinRegex = /^[A-Z]{2}[A-Z0-9]{9}[0-9]$/;

  return isinRegex.test(isin);
};

export default isValidISIN;
