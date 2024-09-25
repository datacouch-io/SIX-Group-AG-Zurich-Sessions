from metaflow import FlowSpec, Parameter, step, card
from datetime import datetime
import os
import json

class DefaultCardFlow(FlowSpec):

    alpha = Parameter('alpha', default=0.5)

    @card
    @step
    def start(self):
        # Get numbers from environment variable or use default
        numbers_env = os.getenv('NUMBERS', '[1, 2, 3, 4, 5]')
        self.numbers = json.loads(numbers_env)  # Parse the JSON string to a list
        self.next(self.square_numbers)

    @card
    @step
    def square_numbers(self):
        self.squared_numbers = [x ** 2 for x in self.numbers]
        self.next(self.sum_squares)

    @card
    @step
    def sum_squares(self):
        self.total_sum = sum(self.squared_numbers)
        self.next(self.find_max)

    @step
    def find_max(self):
        self.max_value = max(self.squared_numbers) if self.squared_numbers else None
        self.next(self.end)

    @step
    def end(self):
        print(f"Numbers: {self.numbers}")
        print(f"Squared Numbers: {self.squared_numbers}")
        print(f"Total Sum of Squares: {self.total_sum}")
        print(f"Maximum Squared Value: {self.max_value}")

if __name__ == "__main__":
    DefaultCardFlow()
