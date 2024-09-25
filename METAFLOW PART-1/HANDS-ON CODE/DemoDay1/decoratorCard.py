from metaflow import FlowSpec, step, card

class DecoratorCard(FlowSpec):

    @step
    def start(self):
        self.next(self.decorator_func)

    @card
    @step
    def decorator_func(self):
        self.data = [1,2,3]
        self.next(self.end)

    @step
    def end(self):
        print("End step completed")


if __name__ == '__main__':
    DecoratorCard()