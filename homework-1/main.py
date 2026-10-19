"""Скрипт для заполнения данными таблиц в БД Postgres."""

import csv

import psycopg2


def fill_table_from_csv(table_name: str, file_name: str) -> None:
    conn = psycopg2.connect(
        host="localhost",
        user="postgres",
        password="9896",
        dbname="north",
    )
    try:
        with conn:
            with conn.cursor() as cursor:
                with open(
                    file_name,
                    newline="",
                    encoding="windows-1251",
                ) as csv_file:
                    csv_reader = csv.reader(csv_file)
                    header = next(csv_reader, None)

                    if not header:
                        raise ValueError("CSV-файл пуст или не содержит заголовка")

                    query = (
                        f"INSERT INTO {table_name} ({', '.join(header)}) "
                        f"VALUES ({', '.join(['%s'] * len(header))}) "
                        "ON CONFLICT DO NOTHING"
                    )

                    for row in csv_reader:
                        if len(row) != len(header):
                            raise ValueError(
                                f"Некорректная запись около строки {csv_reader.line_num}: "
                                f"ожидалось {len(header)} значений, получено {len(row)}"
                            )

                        cursor.execute(query, row)
    finally:
        conn.close()


def main() -> None:
    fill_table_from_csv(
        "customers",
        "homework-1/north_data/customers_data.csv",
    )
    fill_table_from_csv(
        "employees",
        "homework-1/north_data/employees_data.csv",
    )
    fill_table_from_csv(
        "orders",
        "homework-1/north_data/orders_data.csv",
    )


if __name__ == "__main__":
    main()
