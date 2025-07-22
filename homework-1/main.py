"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import os
import psycopg2

try:
    with psycopg2.connect(
        host='localhost',
        database='north',
        user='postgres',
        password='0000'
    ) as conn:

        with conn.cursor() as cur:
            path_employees = os.path.join(os.path.dirname(__file__), 'north_data', 'employees_data.csv')
            path_customers = os.path.join(os.path.dirname(__file__), 'north_data', 'customers_data.csv')
            path_orders = os.path.join(os.path.dirname(__file__), 'north_data', 'orders_data.csv')

            data_employees = []
            data_customers = []
            data_orders = []

            #:NOTE: Первый блок!!!!
            with open(path_employees, encoding='windows-1251') as f_employees:
                reader = csv.DictReader(f_employees)
                for row in reader:
                    if not any((value or '').strip() for value in row.values()):
                        continue
                    data_employees.append((
                        row['employee_id'],
                        row['first_name'],
                        row['last_name'],
                        row['title'],
                        row['birth_date'],
                        row['notes']
                    ))

            cur.executemany(
                'INSERT INTO public.employees '
                '(employee_id, first_name, last_name, title, birth_date, notes) '
                'VALUES (%s, %s, %s, %s, %s, %s)',
                data_employees
            )

            #:NOTE: Второй блок!!!!
            with open(path_customers, encoding='windows-1251') as f_customers:
                reader = csv.DictReader(f_customers)
                for row in reader:
                    if not any((value or '').strip() for value in row.values()):
                        continue
                    data_customers.append((
                        row['customer_id'],
                        row['company_name'],
                        row['contact_name']
                    ))

            cur.executemany(
                'INSERT INTO public.customers '
                '(customer_id, company_name, contact_name) '
                'VALUES (%s, %s, %s)',
                data_customers
            )

            #:NOTE: Третий блок!!!!
            with open(path_orders, encoding='windows-1251') as f_orders:
                reader = csv.DictReader(f_orders)
                for row in reader:
                    if not any((value or '').strip() for value in row.values()):
                        continue
                    data_orders.append((
                        row['order_id'],
                        row['customer_id'],
                        row['employee_id'],
                        row['order_date'],
                        row['ship_city']
                    ))

            cur.executemany(
                'INSERT INTO public.orders '
                '(order_id, customer_id, employee_id, order_date, ship_city) '
                'VALUES (%s, %s, %s, %s, %s)',
                data_orders
            )

except Exception as _ex:
    print('Ошибка при работе c PostgreSQL', _ex)

finally:
    if conn and not conn.closed:
        conn.close()
        print('Соединение с PostgreSQL закрыто')

