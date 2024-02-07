-- SELECT *
-- FROM dev.mart_companies_dim d
-- JOIN dev.mart_contacts_dim c
-- ON d.company_pk = c.company_pk
-- WHERE d.company_pk = '93ff992c29e86cfd7f8705a995fd1cf5'


{% for i, num in enumerate(range(0, 6)) %}
    {% if num % 2 == 0 %}
        print(i, 'fizz') 
    {% else %}
        print(i, 'buzz')
    {% endif %}

{% endfor %}

-- for i, num in enumerate(range(0, 6)):
--     if num % 2 == 0:
--         print(i, 'fizz')
--     else:
--         print(i, 'buzz')