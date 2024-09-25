from metaflow import FlowSpec, step
import mysql.connector
from datetime import datetime

class ComplexMySQLPipelineFlow(FlowSpec):

    @step
    def start(self):
        """Initialize the database connection and retrieve data."""
        print("Connecting to MySQL database...")

        # MySQL connection configuration
        self.connection_config = {
            'host': 'localhost',  # Replace with your MySQL host
            'user': 'root',  # Replace with your MySQL user
            'password': 'Root@123',  # Replace with your MySQL password
            'database': 'sales_db'  # Name of the database
        }

        self.min_sales_value = 1000.00  # Filter for sales above this value
        self.next(self.query_data)

    @step
    def query_data(self):
        """Retrieve sales data from the MySQL database."""
        print("Querying sales data from MySQL...")

        # Establish a connection to the database
        conn = mysql.connector.connect(**self.connection_config)
        cursor = conn.cursor()

        # Query to fetch data from the sales table
        cursor.execute("SELECT product, quantity, price, sale_date FROM sales")
        self.sales_data = cursor.fetchall()

        # Close the connection
        cursor.close()
        conn.close()

        print(f"Retrieved {len(self.sales_data)} records from the sales table.")
        self.next(self.filter_data)

    @step
    def filter_data(self):
        """Filter sales records that exceed a minimum sales value."""
        print(f"Filtering sales records with value greater than {self.min_sales_value}...")

        self.filtered_data = [
            record for record in self.sales_data
            if record[1] * record[2] > self.min_sales_value  # quantity * price > min_sales_value
        ]

        print(f"Filtered down to {len(self.filtered_data)} records.")
        self.next(self.aggregate_data)

    @step
    def aggregate_data(self):
        """Aggregate data to calculate total sales value."""
        print("Aggregating data to calculate total sales...")

        self.total_sales_value = sum([record[1] * record[2] for record in self.filtered_data])

        print(f"Total sales value: {self.total_sales_value}")
        self.next(self.write_results)

    @step
    def write_results(self):
        """Write the filtered and aggregated results back into the MySQL database."""
        print("Writing results to the MySQL database...")

        conn = mysql.connector.connect(**self.connection_config)
        cursor = conn.cursor()

        # Create a new table to store aggregated results
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS sales_summary (
                id INT AUTO_INCREMENT PRIMARY KEY,
                total_sales_value DECIMAL(10, 2),
                processed_at DATETIME
            )
        """)

        # Insert the aggregated results
        insert_query = """
            INSERT INTO sales_summary (total_sales_value, processed_at)
            VALUES (%s, %s)
        """
        cursor.execute(insert_query, (self.total_sales_value, datetime.now()))

        # Commit the changes and close the connection
        conn.commit()
        cursor.close()
        conn.close()

        print(f"Results successfully written to the database.")
        self.next(self.end)

    @step
    def end(self):
        """Final step: Complete the flow."""
        print("Flow completed.")
        print(f"Total sales value written to the database: {self.total_sales_value}")

if __name__ == "__main__":
    ComplexMySQLPipelineFlow()
