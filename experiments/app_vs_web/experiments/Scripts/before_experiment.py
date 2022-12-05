from pathlib import Path
from AndroidRunner.Device import Device
import os

# noinspection PyUnusedLocal
def main(device: Device, *args: tuple, **kwargs: dict):
    # Run pre-experiment hook which sets the device to a known state
    script = str((Path(__file__).parent.parent.parent / 'utils' / 'before_run.sh').absolute())
    os.system(f'{script} killall')
