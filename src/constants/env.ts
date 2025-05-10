// Purpose: Define environment variables and their default values.
// The getEnv function is used to get the value of an environment variable. If the environment variable is missing, an error is thrown.
const getEnv = (key:string, defaultValue?:string): string => {
    const value = process.env[key] || defaultValue;

    if (!value) {
        throw new Error(`Environment variable ${key} is missing`);
    }

    return value;
}

export const PORT = getEnv("PORT", "8000");
export const DATABASE_URL = getEnv("DATABASE_URL");
export const NODE_ENV = getEnv("NODE_ENV", "development");