BEGIN TRAN;

DECLARE @startdate DATE = '2020-03-01',
        @enddate   DATE = '2023-06-01';

DECLARE @datelist TABLE(FullDate DATE);

-- Si quieres continuar desde la última fecha cargada:
IF @startdate IS NULL
BEGIN
    SELECT TOP 1 @startdate = DATEADD(DAY,1,FullDate)
    FROM dbo.DimDate
    ORDER BY DateKey DESC;
END;

WHILE (@startdate <= @enddate)
BEGIN 
    INSERT INTO @datelist(FullDate)
    VALUES (@startdate);

    SET @startdate = DATEADD(DAY,1,@startdate);
END;

INSERT INTO dbo.DimDate(DateKey,
                        FullDate,
                        DayNumberOfWeek,
                        DayNameOfWeek,
                        DayNumberOfMonth,
                        DayNumberOfYear,
                        WeekNumberOfYear,
                        [MonthName],
                        MonthNumberOfYear,
                        CalendarQuarter,
                        CalendarYear,
                        CalendarSemester)
SELECT CONVERT(INT,CONVERT(VARCHAR(8),dl.FullDate,112)) AS DateKey,
       dl.FullDate,
       DATEPART(WEEKDAY,dl.FullDate),
       DATENAME(WEEKDAY,dl.FullDate),
       DATEPART(DAY,dl.FullDate),
       DATEPART(DAYOFYEAR,dl.FullDate),
       DATEPART(WEEK,dl.FullDate),
       DATENAME(MONTH,dl.FullDate),
       MONTH(dl.FullDate),
       DATEPART(QUARTER,dl.FullDate),
       YEAR(dl.FullDate),
       CASE DATEPART(QUARTER,dl.FullDate)
            WHEN 1 THEN 1
            WHEN 2 THEN 1
            WHEN 3 THEN 2
            WHEN 4 THEN 2
       END
FROM @datelist dl
LEFT JOIN dbo.DimDate dd ON dl.FullDate = dd.FullDate
WHERE dd.FullDate IS NULL;

COMMIT TRAN;
GO