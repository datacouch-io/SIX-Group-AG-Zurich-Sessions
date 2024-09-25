from metaflow import FlowSpec, step, retry
import random

class RetryDecorator(FlowSpec):
    @step
    def start(self):
        self.retry_count =0
        print("Starting RetryFlow")
        self.next(self.process)

    @retry(times=3)
    @step
    def process(self):
        self.retry_count+=1
        print(f"Processing attempt : {self.retry_count}....")
        self.random_value = random.randint(1,5)
        print(f"Random value generated : {self.random_value}")
        if self.random_value!=5:
            print("Condition Not Met Allowing retry...")
            return
        print("Condition Met! move for end step")
        self.next(self.end)

    @step
    def end(self):
        print("End step completed")


if __name__ == '__main__':
    RetryDecorator()


