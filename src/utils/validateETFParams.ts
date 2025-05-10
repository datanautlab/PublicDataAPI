import isValidDate from "./validDate";
import isValidISIN from "./validISIN";

// Common validation function for controllers with date parameters
const validateETFParams = (isin: string, from?: string, to?: string) => {
    const errors = [];
  
    if (!isValidISIN(isin)) {
      errors.push("Invalid ISIN");
    }
  
    if ((from && !isValidDate(from)) || (to && !isValidDate(to))) {
      errors.push("Invalid date format. Use YYYY-MM-DD");
    }
  
    return errors;
  };

  export default validateETFParams;