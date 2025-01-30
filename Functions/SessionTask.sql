-- 1> Calculate Age from Date of Birth Write a function that takes a DateOfBirth as input and returns the current age in years.
Create Function udfCalculateAge(@DateOfBirth Date)
Returns int
AS
Begin
	Declare @Age int;
	Set @Age = DATEDIFF(Year,@DateOfBirth,GetDate());
	Return @Age
End;

Select dbo.udfCalculateAge('2000-10-01') AS AGE;

-- 2> Get Initials from Full Name Create a function that extracts initials from a full name (e.g., "Priya Sinha" → "P.S."). 
Create Function udfGetInitials(@FullName VARCHAR(50))
Returns VARCHAR(10)
AS
Begin
    Declare @Initials VARCHAR(10) = '';
    Set @Initials = LEFT(@FullName, 1) + '.';

    IF CHARINDEX(' ', @FullName) > 0
    Begin
        SET @Initials = @Initials + LEFT(RIGHT(@FullName, CHARINDEX(' ', REVERSE(@FullName)) - 1), 1) + '.';
    End

    Return @Initials;
END;

Select dbo.udfGetInitials('Piyush Kumar');

-- 3> Convert Temperature Write a function to convert temperature from Celsius to Fahrenheit. 
Create Function udfConvertTemp(@Celcius decimal(5,2))
Returns decimal(5,2)
AS
Begin
	Declare @Fahrenheit Decimal(5,2);
	Set @Fahrenheit = (@Celcius * 9/5) +32;
	Return @Fahrenheit;
End;

Select dbo.udfConvertTemp(25) AS Fahrenheit;

