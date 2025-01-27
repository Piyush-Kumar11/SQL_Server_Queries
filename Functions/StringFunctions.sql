-- 1. Concatenating Strings (Combine ProductName with Category)
SELECT 
    ProductID,
    ProductName + ' - ' + Category AS ProductDetails
FROM Products;

-- 2. Getting the Length of Strings (Measure ProductName and Category Length)
SELECT 
    ProductID,
    ProductName,
    LEN(ProductName) AS ProductNameLength,
    LEN(Category) AS CategoryLength
FROM Products;

-- 3. Extracting Substrings (First 3 Characters of ProductName and First 5 of Category)
SELECT 
    ProductID,
    ProductName,
    SUBSTRING(ProductName, 1, 3) AS FirstThreeChars,
    SUBSTRING(Category, 1, 5) AS FirstFiveChars
FROM Products;

-- 4. Changing Case (Uppercase for ProductName and Lowercase for Category)
SELECT 
    ProductID,
    UPPER(ProductName) AS UpperProductName,
    LOWER(Category) AS LowerCategory
FROM Products;

-- 5. Trimming Strings (Trim Extra Spaces from ProductName and Category)
SELECT 
    ProductID,
    TRIM(ProductName) AS TrimmedProductName,
    LTRIM(RTRIM(Category)) AS TrimmedCategory
FROM Products;

-- 6. Replacing Text (Replace 'Electronics' in Category with 'Gadgets')
SELECT 
    ProductID,
    ProductName,
    REPLACE(Category, 'Electronics', 'Gadgets') AS UpdatedCategory
FROM Products;

-- 7. Reversing Strings (Reverse ProductName and Category)
SELECT 
    ProductID,
    ProductName,
    REVERSE(ProductName) AS ReversedProductName,
    REVERSE(Category) AS ReversedCategory
FROM Products;

-- 8. Searching for Strings (Find Positions in ProductName and Category)
SELECT 
    ProductID,
    ProductName,
    CHARINDEX('Phone', ProductName) AS PositionOfPhone,
    CHARINDEX('Clothing', Category) AS PositionOfClothing
FROM Products;

-- 9. Repeating Strings (Mask ProductName with Asterisks)
SELECT 
    ProductID,
    ProductName,
    REPLICATE('*', LEN(ProductName)) AS MaskedProductName
FROM Products;

-- 10. ASCII and CHAR Functions (ASCII of First Character and Convert ASCII to Char)
SELECT 
    ProductID,
    ProductName,
    ASCII(LEFT(ProductName, 1)) AS ASCIIOfFirstChar
FROM Products;
