from metaflow import FlowSpec, step
import mysql.connector


class MySQLFlow(FlowSpec):

    @step
    def start(self):
        """Connect to MySQL database and retrieve data from the employees table."""
        print("Connecting to MySQL database...")

        # MySQL connection configuration
        self.connection_config = {
            'host': 'localhost',  # Replace with your MySQL host
            'user': 'root',  # Replace with your MySQL user
            'password': 'Root@123',  # Replace with your MySQL password
            'database': 'metaflow_db'  # Name of the database
        }

        self.next(self.query_db)

    @step
    def query_db(self):
        """Execute a query to fetch data from the employees table."""
        print("Executing query to fetch data from employees table...")

        # Establish a connection to the database
        conn = mysql.connector.connect(**self.connection_config)
        cursor = conn.cursor()

        # Execute a simple SELECT query
        cursor.execute("SELECT name, position, salary FROM employees")

        # Fetch all rows
        self.employees = cursor.fetchall()

        # Close the connection
        cursor.close()
        conn.close()

        print(f"Retrieved {len(self.employees)} rows from the database.")
        self.next(self.process_data)

    @step
    def process_data(self):
        """Process the data (e.g., calculate average salary)."""
        print("Processing data...")

        total_salary = sum([emp[2] for emp in self.employees])
        self.average_salary = total_salary / len(self.employees)
        print(f"Tota salary: {total_salary}")
        print(f"Average salary: {self.average_salary}")
        self.next(self.end)

    @step
    def end(self):
        """Final step: Output the processed data."""
        print("Flow completed.")
        print(f"The average salary of employees is: {self.average_salary}")


if __name__ == "__main__":
    MySQLFlow()
