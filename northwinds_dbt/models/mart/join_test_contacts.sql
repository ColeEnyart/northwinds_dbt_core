SELECT *
FROM dev.mart_companies_dim d
JOIN dev.mart_contacts_dim c
ON d.company_pk = c.company_pk
WHERE d.company_pk = '93ff992c29e86cfd7f8705a995fd1cf5'
