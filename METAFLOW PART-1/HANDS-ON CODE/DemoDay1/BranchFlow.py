from metaflow import FlowSpec, step

class MyBranchFlow(FlowSpec):

    @step
    def start(self):
        print("Start Step")
        self.next(self.a,self.b)

    @step
    def a(self):
        print("Step a started")
        self.x =1
        self.next(self.join)


    @step
    def b(self):
        print("Step b started")
        self.x =2
        self.next(self.join)

    @step
    def join(self,inputs):
        print(' a is %s'% inputs.a.x)
        print(' b is %s' % inputs.b.x)
        print('total is %d'%sum(input.x for input in inputs))
        self.next(self.end)

    @step
    def end(self):
        print("End Step Completed")

if __name__ == '__main__':
    MyBranchFlow()
