-- 14. Find the total number of couriers handled by each employee using COUNT() and GROUP BY.
SELECT e.EmployeeID, e.Name, COUNT(ca.CourierID) AS TotalCouriers
FROM Employee e
JOIN CourierAssignment ca ON e.EmployeeID = ca.EmployeeID
GROUP BY e.EmployeeID, e.Name;

-- 15. Calculate the total revenue generated by each location using SUM() and GROUP BY.
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalRevenue
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID
GROUP BY l.LocationID, l.LocationName;

-- 16. Find the total number of couriers delivered to each location.
SELECT l.LocationID, l.LocationName, COUNT(c.CourierID) AS TotalDelivered
FROM Location l
JOIN Courier c ON l.LocationID = c.DestinationLocationID
WHERE c.Status = 'Delivered'
GROUP BY l.LocationID, l.LocationName;

-- 17. Find the courier with the highest average delivery time using AVG() and ORDER BY.
SELECT c.CourierID, 
       AVG(DATEDIFF(c.DeliveryDate, p.PaymentDate)) AS AvgDeliveryTime
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
GROUP BY c.CourierID
ORDER BY AvgDeliveryTime DESC
LIMIT 1;

-- 18. Find locations with total payments less than a certain amount using HAVING.
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID
GROUP BY l.LocationID, l.LocationName
HAVING TotalPayments < 3000;

-- 19. Calculate total payments per location using SUM() and GROUP BY.
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID
GROUP BY l.LocationID, l.LocationName;

-- 20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (WHERE LocationID = X).
SELECT p.CourierID, SUM(p.Amount) AS TotalPayment
FROM Payment p
WHERE p.LocationID = 11
GROUP BY p.CourierID
HAVING TotalPayment > 1000;

-- 21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (WHERE PaymentDate > 'YYYY-MM-DD').
SELECT p.CourierID, SUM(p.Amount) AS TotalPayment
FROM Payment p
WHERE p.PaymentDate > '2025-03-01'
GROUP BY p.CourierID
HAVING TotalPayment > 1000;

-- 22. Retrieve locations where the total amount received is more than $5000 before a certain date (HAVING SUM(Amount) > 5000 AND PaymentDate < 'YYYY-MM-DD').
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalPayment
FROM Payment p
JOIN Location l ON p.LocationID = l.LocationID
WHERE p.PaymentDate < '2025-03-01'
GROUP BY l.LocationID, l.LocationName
HAVING TotalPayment > 5000;