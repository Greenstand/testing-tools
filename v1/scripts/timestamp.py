import sys
import datetime

TIME = datetime.datetime.utcnow().replace(microsecond=0).timestamp()
sys.stdout.write(str(int(TIME)))
