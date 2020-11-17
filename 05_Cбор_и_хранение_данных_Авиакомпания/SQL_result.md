### Структура базы данных об авиаперевозках
![image](https://pictures.s3.yandex.net/resources/PK_FK_airports_1566761812.jpg)

### SQL-запрос
```sql
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
```

### Результат SQL-запроса
<table cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <th scope="col">week_number</th>
      <th scope="col">ticket_amount</th>
      <th scope="col">festival_week</th>
      <th scope="col">festival_name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>33</td>
      <td>51378</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>31</td>
      <td>51034</td>
      <td>31</td>
      <td>Пикник Афиши</td>
    </tr>
    <tr>
      <td>38</td>
      <td>51518</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>30</td>
      <td>43568</td>
      <td>30</td>
      <td>Park Live</td>
    </tr>
    <tr>
      <td>32</td>
      <td>51675</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>34</td>
      <td>51492</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>35</td>
      <td>51360</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>37</td>
      <td>51670</td>
      <td>nan</td>
      <td></td>
    </tr>
    <tr>
      <td>36</td>
      <td>51386</td>
      <td>36</td>
      <td>Видфест</td>
    </tr>
    <tr>
      <td>39</td>
      <td>51623</td>
      <td>nan</td>
      <td></td>
    </tr>
  </tbody>
</table>

### Вывод:
Сопоставляя показатели продажи билетов `ticket_amount` в периоды проведения фестивалей с другими неделями можно сделать вывод, что спрос на авиаперелеты во время фестивалей практически не меняется.
