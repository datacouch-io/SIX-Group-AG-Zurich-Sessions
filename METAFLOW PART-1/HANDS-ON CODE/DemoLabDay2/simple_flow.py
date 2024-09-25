from metaflow import FlowSpec, step

class SimpleFlow(FlowSpec):

    @step
    def start(self):
        self.x = 1  # Setting x to 1 for testing
        self.next(self.add)

    @step
    def add(self):
        self.y = self.x + 4
        self.next(self.end)

    @step
    def end(self):
        print(f"The value of x is {self.x} and y is {self.y}")

if __name__ == '__main__':
    SimpleFlow()
