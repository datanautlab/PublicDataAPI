// Helper function to validate date format (YYYY-MM-DD)
const isValidDate = (dateString: string): boolean => {
    if (!dateString) return false;
  
    // Check if the format is YYYY-MM-DD
    const regex = /^\d{4}-\d{2}-\d{2}$/;
    if (!regex.test(dateString)) return false;
  
    // Check if it's a valid date
    const date = new Date(dateString);
    const timestamp = date.getTime();
  
    if (isNaN(timestamp)) return false;

  return date.toISOString().split("T")[0] === dateString;
}

export default isValidDate;
