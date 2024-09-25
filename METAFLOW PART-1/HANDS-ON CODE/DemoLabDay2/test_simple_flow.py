import os
from metaflow import Flow
import subprocess

def test_flow():
    # Command to run the flow
    cmd = ['python', 'simple_flow.py', 'run', '--run-id-file', 'test_id']
    subprocess.check_call(cmd)

    # Read the run ID from the file
    with open('test_id') as f:
        run_id = f.read().strip()  # Use .strip() to remove any extra whitespace

    # Load the flow run and check the value of x
    run = Flow('SimpleFlow')[run_id]
    assert run.data.x == 1
    assert run.data.y == 5