import sys
import datetime

TIME = datetime.datetime.utcnow().replace(microsecond=0).isoformat() + '+0000'
sys.stdout.write(TIME)
