
### Структура базы данных об авиаперевозках
![image](https://pictures.s3.yandex.net/resources/PK_FK_airports_1566761812.jpg)

### Запрос SQL для проверки гипотезы о влиянии фестивалей на спрос авиаперевозок
SELECT
    SUBQ_1.week_number,
    SUBQ_1.ticket_amount,
    SUBQ_2.festival_week,
    SUBQ_2.festival_name
FROM
    (SELECT
        EXTRACT(week FROM arrival_time::date) AS week_number,
        COUNT(ticket_no) AS ticket_amount
     FROM
         flights
         INNER JOIN ticket_flights ON ticket_flights.flight_id = flights.flight_id 
         INNER JOIN airports ON airports.airport_code = flights.arrival_airport
     WHERE
         arrival_time::date >='2018-07-23' AND arrival_time::date <='2018-09-30'    
         AND airports.city = 'Москва'
     GROUP BY
         week_number) AS SUBQ_1
LEFT JOIN
    (SELECT
        EXTRACT(week FROM festival_date) AS festival_week,
        festival_name
    FROM
        festivals
    WHERE
        festival_date >='2018-07-23' AND festival_date <='2018-09-30'
        AND festival_city = 'Москва'
    GROUP BY
         festival_week,
         festival_name) AS SUBQ_2
ON SUBQ_1.week_number = SUBQ_2.festival_week
