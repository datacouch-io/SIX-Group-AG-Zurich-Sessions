from metaflow import FlowSpec, step

class ComplexFlow(FlowSpec):

    @step
    def start(self):
        self.numbers = [1, 2, 3, 4, 5]
        self.next(self.square_numbers)

    @step
    def square_numbers(self):
        self.squared_numbers = [x ** 2 for x in self.numbers]
        self.next(self.sum_squares)

    @step
    def sum_squares(self):
        self.total_sum = sum(self.squared_numbers)
        self.next(self.find_max)

    @step
    def find_max(self):
        self.max_value = max(self.squared_numbers)
        self.next(self.end)

    @step
    def end(self):
        print(f"Numbers: {self.numbers}")
        print(f"Squared Numbers: {self.squared_numbers}")
        print(f"Total Sum of Squares: {self.total_sum}")
        print(f"Maximum Squared Value: {self.max_value}")

if __name__ == '__main__':
    ComplexFlow()
